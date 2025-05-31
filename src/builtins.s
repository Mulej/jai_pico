.globl __muldi3
__muldi3:
    mv     a2, a0
    mv     a0, zero
.L1:
    andi   a3, a1, 1
    beqz   a3, .L2
    add    a0, a0, a2
.L2:
    srli   a1, a1, 1
    slli   a2, a2, 1
    bnez   a1, .L1
    ret


.globl put32
put32:
    sw x11, (x10)
    ret

.globl get32
get32:
    lw x10, (x10)
    ret

.globl delay
delay:
    addi x10, x10, -1
    bnez x10, delay
    ret
