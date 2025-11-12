----------------------------------------------------------------------------------
-- Company: UQTR
-- Student : Daniel kabeya 
-- 
-- Create Date: 11/06/2025 08:03:48 PM
-- Design Name: 
-- Module Name: Flags_regs - Behavioral
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

entity Flags_regs is
  Port (
    CLK       : in  std_logic;
    RST       : in  std_logic;                         -- reset asynchrone actif à 1
    ALUFlags  : in  std_logic_vector(3 downto 0);      -- {N,Z,C,V} de l’ALU
    FlagW     : in  std_logic_vector(1 downto 0);      -- contrôle d’écriture
    CondEx    : in  std_logic;                         -- exécution conditionnelle
    Flags_out : out std_logic_vector(3 downto 0)       -- flags enregistrés
  );
end Flags_regs;

architecture behavioral of Flags_regs is
  signal Flags : std_logic_vector(3 downto 0) := (others => '0');
  signal FlagWrite : std_logic;
begin
  -- condition d’écriture : FlagW(1) ou FlagW(0) actif et CondEx = 1
  FlagWrite <= (FlagW(1) or FlagW(0)) and CondEx;

  process (RST, CLK)
  begin
    if RST = '1' then
      Flags <= (others => '0');                         -- reset asynchrone
    elsif rising_edge(CLK) then
      if FlagWrite = '1' then
        Flags <= ALUFlags;
      end if;
    end if;
  end process;

  Flags_out <= Flags;
end behavioral;
