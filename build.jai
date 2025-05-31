#run build();

build :: () {
    set_build_options_dc(.{do_output=false});

    options := get_build_options();

    args := options.compile_time_command_line;

    do_debug   := false;
    do_release := false;

    for args {
        if it == {
            case "debug";
                do_debug   = true;
            case "release";
                do_release = true;
            case;
                print("Unknown argument \"%\".\n", it, to_standard_error=true);
                return;
        }
    }

    if !do_debug && !do_release {
        do_release = true;
    }

    if do_debug   then build_debug();
    if do_release then build_release();
}

build_debug :: () {
    print("Building debug binary.\n", to_standard_error=true);
    workspace := compiler_create_workspace("Main debug");

    if !workspace {
        print("Debug workspace creation failed.\n", to_standard_error=true);
        return;
    }

    options: Build_Options;

    set_optimization(*options, .DEBUG, true);

    options.output_path            = "bin/debug/";
    options.intermediate_path      = ".build/debug";

    build_workspace_options(workspace, *options);
}

build_release :: () {
    print("Building release binary.\n", to_standard_error=true);
    workspace := compiler_create_workspace("Main release");

    if !workspace {
        print("Release workspace creation failed.\n", to_standard_error=true);
        return;
    }

    options: Build_Options;

    set_optimization(*options, .VERY_OPTIMIZED);

    options.output_path            = "bin/release/";
    options.intermediate_path      = ".build/release";

    build_workspace_options(workspace, *options);
}

build_workspace_options :: (workspace: Workspace, options: *Build_Options) {
    options.import_path             = .["./src/modules/"];
    options.machine_options         = get_build_options().machine_options;
    options.write_added_strings     = true;
    options.output_type             = .EXECUTABLE;
    options.output_executable_name  = "jai_pico";
    options.text_output_flags       = xx 0;
    options.cpu_target              = .CUSTOM;
    options.os_target               = .LINUX;
    options.backend                 = .LLVM;
    options.emit_debug_info         = .NONE;
    options.use_custom_link_command = true;
    options.dead_code_elimination   = .ALL;

    options.llvm_options.enable_split_modules = false;
    options.llvm_options.output_llvm_ir       = true;

    set_build_options(options.*, workspace);

    make_directory_if_it_does_not_exist(options.output_path, recursive = true);

    compiler_begin_intercept(workspace);

    add_build_file("src/main.jai", workspace);

    while true {
        message := compiler_wait_for_message();

        if message.kind == .COMPLETE {
            complete := cast(*Message_Complete) message;

            if complete.error_code == .NONE {
                output := tprint("%1%2", options.output_path, options.output_executable_name);
                print("\nSuccessfully built binary: %\n\n", output, to_standard_error=true);
            }

            break;
        }

        if message.kind == .PHASE {
            phase := cast(*Message_Phase)message;

            if phase.phase == .READY_FOR_CUSTOM_LINK_COMMAND {
                wd := get_working_directory();

                path_overwrite_separators(wd, #char "/");

                out_elf_file_path := parse_path(wd);
                intermediate_path := parse_path(options.intermediate_path);

                array_add(*out_elf_file_path.words, ..intermediate_path.words);
                array_add(*out_elf_file_path.words, options.output_executable_name);

                out_elf_file := path_to_string(out_elf_file_path);


                out_file_path := parse_path(wd);
                output_path := parse_path(options.output_path);

                array_add(*out_file_path.words, ..output_path.words);
                array_add(*out_file_path.words, join(options.output_executable_name, ".uf2"));

                out_file := path_to_string(out_file_path);

                command: [..]string;

                array_add(*command, "clang");
                array_add(*command, "-nostdlib");
                array_add(*command, "-O3");
                array_add(*command, "--target=riscv32-unknown-unknown");
                array_add(*command, "-mabi=ilp32");
                array_add(*command, "-march=rv32imac_zicsr_zifencei_zba_zbb_zbkb_zbs");
                array_add(*command, "-fPIC");
                array_add(*command, "-flto");
                array_add(*command, "-o");
                array_add(*command, out_elf_file);
                array_add(*command, "src/builtins.s");
                array_add(*command, "src/metadata.s");
                array_add(*command, "src/linker.ld");

                for file: phase.compiler_generated_object_files {
                    extension := path_extension(file);
                    path_wo_extension := path_strip_extension(file);
                    ll_file := join(path_wo_extension, ".ll");
                    text := read_entire_file(ll_file);

                    output: [..]string;

                    // We need to fix up the LLVM IR a bit...
                    for line: split(text, "\n") {
                        if begins_with(line, "@_no_reset_base") {
                            array_add(*output, "@_no_reset_base = internal global <{ [0 x i8] }> zeroinitializer, align 4096");
                            continue;
                        }
                        if begins_with(line, "target triple = ") {
                            array_add(*output, "target triple = \"riscv32-unknown-unknown\"");
                            continue;
                        }
                        if contains(line, " !dbg !") && ends_with(line, "{") {
                            _, left := split_from_left(line, "!dbg !");
                            array_add(*output, join(left, "{"));
                            continue;
                        }
                        if contains(line, ", !dbg !") {
                            _, left := split_from_left(line, ", !dbg !");
                            array_add(*output, left);
                            continue;
                        }
                        array_add(*output, line);
                    }
                    fixed_ll := join(..output, separator="\n");
                    write_entire_file(ll_file, fixed_ll);
                    array_add(*command, ll_file);
                }

                {
                    process_result, output_string, error_string, timeout_reached := run_command(..command, capture_and_return_output=true);

                    if process_result.exit_code {
                        if output_string then print("clang output: %\n", output_string);
                        if error_string  then print("clang error: %\n", error_string);
                        compiler_custom_link_command_is_complete(workspace);
                        continue;
                    }
                }

                {
                    process_result, output_string, error_string, timeout_reached := run_command(
                        "tools/picotool", "uf2", "convert", out_elf_file, "-t", "elf", out_file, "--family", "0xe48bff5a",
                        capture_and_return_output=true);
                    if process_result.exit_code {
                        if output_string then print("picotool convert output: %\n", output_string);
                        if error_string  then print("picotool convert error: %\n", error_string);
                        compiler_custom_link_command_is_complete(workspace);
                        continue;
                    }
                }

                compiler_custom_link_command_is_complete(workspace);

                {
                    process_result, output_string, error_string, timeout_reached := run_command(
                        "tools/picotool",  "load", "-x", out_file,
                        capture_and_return_output=true);
                    if process_result.exit_code {
                        if output_string then print("picotool load output: %\n", output_string);
                        if error_string  then print("picotool load error: %\n", error_string);
                    }
                }
            }

            continue;
        }
    }

    compiler_end_intercept(workspace);
}

#import "File";
#import "String";
#import "Basic";
#import "Compiler";
#import "Process";
#import "File_Utilities";
