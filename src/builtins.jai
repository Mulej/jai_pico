put32 :: (addr: *u32, val: u32) #c_call #foreign;
get32 :: (addr: *u32) -> u32 #c_call #foreign;
delay :: (delay: u32) #c_call #foreign;
