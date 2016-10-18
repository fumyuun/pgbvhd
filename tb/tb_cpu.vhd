library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.memory_pkg.all;

entity tb_cpu is
end entity tb_cpu;

architecture behavioural of tb_cpu is
    signal clock_s : std_logic := '0';
    signal reset_s : std_logic := '1';

    signal memoryAddress_s     : std_logic_vector(15 downto 0);
    signal memoryWriteEnable_s : std_logic;
    signal memoryReadData_s    : std_logic_vector(7 downto 0);
    signal memoryWriteData_s   : std_logic_vector(7 downto 0);

begin

    clock_s <= not clock_s after 238 ns; -- more or less 4.19MHz
    reset_s <= '0' after 100 ns;

    cpu_inst: entity work.cpu
    port map (
        clock_i => clock_s,
        reset_i => reset_s,

        memoryAddress_o     => memoryAddress_s,
        memoryWriteEnable_o => memoryWriteEnable_s,
        memoryReadData_i    => memoryReadData_s,
        memoryWriteData_o   => memoryWriteData_s
    );

    mem_inst: entity work.memory
    generic map (
        MEM_INIT => (
            -- Test a few immideate loads
            0 => x"3E", -- ld a, 0x42
            1 => x"42", -- 0x42

            2 => x"06", -- ld b, 0xba
            3 => x"BA", -- 0x42

            4 => x"0E", -- ld c, 0xbe
            5 => x"BE", -- 0x42

            -- Test a memory load with immediate address
            6 => x"FA", -- ld a, (0x24)
            7 => x"24", -- 0x24

            -- Test a memory load with a pointer address
            8 => x"7E", -- ld a, (hl)
            9 => x"78", -- ld a, b

            others => (others => '0')
        )
    )
    port map (
        clock_i       => clock_s,

        address_i     => memoryAddress_s,
        writeEnable_i => memoryWriteEnable_s,
        writeData_i   => memoryWriteData_s,
        readData_o    => memoryReadData_s
    );

end architecture behavioural;
