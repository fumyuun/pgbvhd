library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package arith_pkg is
    function increment(n : std_logic_vector) return std_logic_vector;
end package arith_pkg;

package body arith_pkg is

    function increment(n : std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(to_unsigned(to_integer(unsigned(n) + 1), n'length));
    end function;

end package body arith_pkg;