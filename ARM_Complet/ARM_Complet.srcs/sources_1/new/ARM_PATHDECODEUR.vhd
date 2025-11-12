----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2025 07:10:34 PM
-- Design Name: 
-- Module Name: ARM_PATHDECODEUR - Behavioral
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

entity ARM_PATHDECODEUR is
  Port (
    Clk         : in  std_logic;
    Rst         : in  std_logic;
    Instruction : in  std_logic_vector(31 downto 0);
    R15_in      : in  std_logic_vector(31 downto 0);
    -- Flags de sortie
    N, Z, C, V  : out std_logic;
    -- Résultat final
    Result      : out std_logic_vector(31 downto 0);
    FlagW_out   : out std_logic_vector(1 downto 0)
  );
end ARM_PATHDECODEUR;

architecture Behavioral of ARM_PATHDECODEUR is

  -- Signaux de contrôle générés par datapath_decodeur
  signal Branch, MemtoReg, MemW, ALUSrc, RegW : std_logic;
  signal ImmSrc, RegSrc : std_logic_vector(1 downto 0);
  signal ALUControl     : std_logic_vector(1 downto 0);
  signal FlagW          : std_logic_vector(1 downto 0);

  -- Nouveaux signaux pour le décalage
  signal ShiftEn        : std_logic;
  signal ShType         : std_logic_vector(1 downto 0);
  signal ShAmount       : std_logic_vector(4 downto 0);

begin
  --------------------------------------------------------------------------
  -- INSTANCIATION 1 : datapath_decodeur
  --------------------------------------------------------------------------
  U_DECODEUR : entity work.datapath_decodeur
    port map (
      Instruction => Instruction,
      Branch      => Branch,
      MemtoReg    => MemtoReg,
      MemW        => MemW,
      ALUSrc      => ALUSrc,
      RegW        => RegW,
      ImmSrc      => ImmSrc,
      RegSrc      => RegSrc,
      ALUControl  => ALUControl,
      FlagW       => FlagW,
      ShiftEn     => ShiftEn,
      ShType      => ShType,
      ShAmount    => ShAmount
    );

  FlagW_out <= FlagW;

  --------------------------------------------------------------------------
  -- INSTANCIATION 2 : ARM (datapath complet)
  --------------------------------------------------------------------------
  U_ARM : entity work.ARM
    port map (
      Clk              => Clk,
      Rst              => Rst,
      RegWrite         => RegW,
      MemWrite         => MemW,
      MemToReg         => MemtoReg,
      ALUSrc           => ALUSrc,
      RegSrc           => RegSrc,
      ImmSrc           => ImmSrc,
      ALUOp            => ALUControl,
      R15_in           => R15_in,
      Instruction      => Instruction,
      N                => N,
      Z                => Z,
      C                => C,
      V                => V,
      Result_after_mem => Result,
      -- nouveaux signaux de décalage
      ShiftEn          => ShiftEn,
      ShType           => ShType,
      ShAmount         => ShAmount
    );

end Behavioral;
