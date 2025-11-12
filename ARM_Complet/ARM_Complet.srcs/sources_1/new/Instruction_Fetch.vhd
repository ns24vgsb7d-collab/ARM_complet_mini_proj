----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2025 08:24:59 PM
-- Design Name: 
-- Module Name: Instruction_Fetch - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Instruction_Fetch is
  Port (
    CLK     : in  std_logic;
    RST     : in  std_logic;
    PCNext  : in  std_logic_vector(31 downto 0);  -- vient du module ADD
    Instr   : out std_logic_vector(31 downto 0);
    PC      : out std_logic_vector(31 downto 0)
  );
end Instruction_Fetch;

architecture behavioral of Instruction_Fetch is
  signal PC_registr : std_logic_vector(31 downto 0);
begin
  -- Registre du PC
  PC_Reg : entity work.PC_Register
    port map (
      CLK   => CLK,
      RST   => RST,
      PCSrc => PCNext,
      PC    => PC_registr
    );

  -- Mémoire d’instructions
  Instr_Mem : entity work.Instruction_Memory
    port map (
      A  => PC_registr(6 downto 2),
      RD => Instr
    );

  -- Sortie du module
  PC <= PC_registr;

end behavioral;

