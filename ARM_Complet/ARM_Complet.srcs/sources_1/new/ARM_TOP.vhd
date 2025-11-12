----------------------------------------------------------------------------------
-- Company: UQTR
-- Engineer: Daniel kabeya 
-- 
-- Create Date: 11/06/2025 09:03:50 PM
-- Design Name: 
-- Module Name: ARM_TOP - Structural
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

entity ARM_TOP is
  Port (
    CLK : in  std_logic;
    RST : in  std_logic
  );
end ARM_TOP;

architecture Structural of ARM_TOP is

  -- Signaux internes

  signal PC, PCNext, PCPlus4, PCPlus8 : std_logic_vector(31 downto 0);
  signal Instruction  : std_logic_vector(31 downto 0);
  signal Result       : std_logic_vector(31 downto 0);
  signal R15_in       : std_logic_vector(31 downto 0);

  -- Flags
  signal N, Z, C, V   : std_logic;
  signal ALUFlags     : std_logic_vector(3 downto 0);
  signal CondEx       : std_logic;
  signal FlagW_sig    : std_logic_vector(1 downto 0);
begin


  -- 1. Instruction Fetch : PC_Register + Instruction_Memory

  FETCH : entity work.Instruction_Fetch
    port map (
      CLK    => CLK,
      RST    => RST,
      PCNext => PCNext,
      Instr  => Instruction,
      PC     => PC
    );

 
  -- 2. Adder 1 : PC + 4

  ADD_PC4 : entity work.adder
    port map (
      a => PC,
      b => x"00000004",
      y => PCPlus4
    );


  -- 3. Adder 2 : PC + 8 (pour R15)

  ADD_PC8 : entity work.adder
    port map (
      a => PC,
      b => x"00000008",
      y => PCPlus8
    );

  -- PC s’incrémente de 4 à chaque cycle
  PCNext <= PCPlus4;

  -- PC + 8 est la valeur visible du registre R15
  R15_in <= PCPlus8;


  -- 4. ARM_PATHDECODEUR : décodeur + datapath complet

  CORE : entity work.ARM_PATHDECODEUR
    port map (
      Clk         => CLK,
      Rst         => RST,
      Instruction => Instruction,
      R15_in      => R15_in,
      N           => N,
      Z           => Z,
      C           => C,
      V           => V,
      Result      => Result,
      FlagW_out   => FlagW_sig   -- sortie FlagW 
    );


  -- 5. Condition Check : vérifie bits [31:28] vs flags NZCV
 
  ALUFlags <= N & Z & C & V;

  COND_CHECK : entity work.Condition_Check
    port map (
      Cond     => Instruction(31 downto 28),
      ALUFlags => ALUFlags,
      CondEx   => CondEx
    );

 
  -- 6. Flags Registers : stocke les flags selon FlagW et CondEx
 
  FLAGS_REG : entity work.Flags_regs
    port map (
      CLK       => CLK,
      RST       => RST,
      ALUFlags  => ALUFlags,
      FlagW     => FlagW_sig,  
      CondEx    => CondEx,
      Flags_out => open
    );

end Structural;

