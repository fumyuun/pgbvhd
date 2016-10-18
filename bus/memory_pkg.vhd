library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package memory_pkg is
    type  memory_type is array (natural range <>) of std_logic_vector(7 downto 0);
end package memory_pkg;
