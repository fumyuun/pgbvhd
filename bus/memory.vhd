library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.memory_pkg.all;

entity memory is
	generic (
		MEM_INIT      : memory_type(0 to 2**16-1) := (others => (others => '0'))
	);
	port (
		clock_i       :  in std_logic;

		address_i     :  in std_logic_vector(15 downto 0);

		writeEnable_i :  in std_logic;
		writeData_i   :  in std_logic_vector(7 downto 0);
		readData_o    : out std_logic_vector(7 downto 0)
	);
end entity memory;

architecture behavioral of memory is
    signal memory : memory_type(0 to 2**16-1) := MEM_INIT;
begin

    mem_proc: process (clock_i)
    begin
        if rising_edge(clock_i) then
            if writeEnable_i = '1' then
                memory(to_integer(unsigned(address_i))) <= writeData_i;
            end if;

            readData_o <= memory(to_integer(unsigned(address_i)));
        end if;
    end process;

end architecture behavioral;
