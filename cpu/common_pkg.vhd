package common_pkg is
	
    type instruction_type is (
        INST_MOVE,  -- A move operation from SOURCE to DEST
        INST_ARITH  -- An arithmetic operation on A = A op SOURCE
    );

    -- Used only in moves, since with arithmetic operations the destination is
    -- always A.
    type destination_type is (
        DEST_REGISTER,         -- Store the result in a register
        DEST_REGISTER_POINTER, -- Store the result in a pointer held by a reg
        DEST_IMMEDIATE_POINTER -- Store the result in an immediate pointer
    );

    type source_type is (
        SRC_REGISTER,          -- Source is a register
        SRC_IMMEDIATE,         -- Source is an immediate
        SRC_IMMEDIATE_POINTER, -- Source is pointed to by an immediate
        SRC_REGISTER_POINTER   -- Source is pointed to by a register
    );
end package common_pkg;