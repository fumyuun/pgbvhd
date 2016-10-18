library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.common_pkg.all;

entity decoder is
	port (
        clock_i       : in std_logic;
        reset_i       : in std_logic;

        opcode_i      : in std_logic_vector(7 downto 0);

        regDest_o     : out std_logic_vector(2 downto 0);
        regSrc_o      : out std_logic_vector(2 downto 0);

        instType_o    : out instruction_type;
        destType_o    : out destination_type;
        srcType_o     : out source_type;

        opReady_i     : in std_logic;
        immReady_i    : in std_logic;

        ready_o       : out std_logic
    );
end entity decoder;

architecture behavioral of decoder is
    signal srcType_s : source_type;
begin

	srcType_o <= srcType_s;

    -- mnem         bits
    -- LD r8, n     00dd d110  nnnn nnnn
    -- LD r8, r8    01dd dsss


    instType_o    <= INST_MOVE;
    destType_o    <= DEST_REGISTER;
    srcType_s     <= SRC_IMMEDIATE when ((opcode_i and "11000111") = "00000110") else SRC_REGISTER;

    regDest_o <= opcode_i(5 downto 3);
    regSrc_o  <= opcode_i(2 downto 0);

    ready_o <= '1' when (opReady_i = '1' and srcType_s = SRC_REGISTER) or (immReady_i = '1' and srcType_s = SRC_IMMEDIATE)
          else '0';

end architecture behavioral;
