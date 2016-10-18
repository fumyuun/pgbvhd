library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity decoder is
	port (
        clock_i       : in std_logic;
        reset_i       : in std_logic;

        opcode_i      : in std_logic_vector(7 downto 0);

        regDest_o     : out std_logic_vector(2 downto 0);
        regWe_o       : out std_logic;

        opReady_i     : in std_logic;
        immReady_i    : in std_logic;

        requiresImm_o : out std_logic;
        ready_o       : out std_logic
    );
end entity decoder;

architecture behavioral of decoder is
	signal requiresImm_s : std_logic;
begin

	requiresImm_o <= requiresImm_s;

    -- mnem    opc  bits
    --              00xx x110
    -- LD B, n 0x06 0000 0110
    -- LD C, n 0x0E 0000 1110
    -- LD D, n 0x16 0001 0110
    -- LD E, n 0x1E 0001 1110
    -- LD H, n 0x26 0010 0110
    -- LD L, n 0x2E 0010 1110
    -- LD A, n 0x3E 0011 1110
    requiresImm_s <= '1' when ((opcode_i and "11000111") = "00000110") else '0';
    regWe_o        <= requiresImm_s;

    regDest_o <= opcode_i(5 downto 3);

    ready_o <= '1' when (opReady_i = '1' and requiresImm_s = '0') or immReady_i = '1'
          else '0';

end architecture behavioral;
