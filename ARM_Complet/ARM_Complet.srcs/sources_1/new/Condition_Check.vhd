----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2025 08:06:51 PM
-- Design Name: 
-- Module Name: Condition_Check - Behavioral
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

entity Condition_Check is
  Port (
    Cond      : in  std_logic_vector(3 downto 0);  -- bits 31..28 de l’instruction
    ALUFlags  : in  std_logic_vector(3 downto 0);  -- {N,Z,C,V}
    CondEx    : out std_logic                      -- 1 si la condition est vraie
  );
end Condition_Check;

architecture behavioral of Condition_Check is
  signal N, Z, C, V : std_logic;
begin
  -- Assignation des flags pour plus de lisibilité
  N <= ALUFlags(3);
  Z <= ALUFlags(2);
  C <= ALUFlags(1);
  V <= ALUFlags(0);

  process (Cond, N, Z, C, V)
    variable result : std_logic;
  begin
    case Cond is
      when "0000" => result := Z;                     -- EQ
      when "0001" => result := not Z;                 -- NE
      when "0010" => result := C;                     -- CS/HS
      when "0011" => result := not C;                 -- CC/LO
      when "0100" => result := N;                     -- MI
      when "0101" => result := not N;                 -- PL
      when "0110" => result := V;                     -- VS
      when "0111" => result := not V;                 -- VC
      when "1000" => result := C and (not Z);         -- HI
      when "1001" => result := (not C) or Z;          -- LS
      when "1010" => result := (N xnor V);            -- GE
      when "1011" => result := (N xor V);             -- LT
      when "1100" => result := (not Z) and (N xnor V);-- GT
      when "1101" => result := Z or (N xor V);        -- LE
      when "1110" => result := '1';                   -- AL (toujr)
      when others => result := '0';                   -- non défini
    end case;

    CondEx <= result;
  end process;
end behavioral;
