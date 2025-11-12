----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/02/2025 09:12:39 AM
-- Design Name: 
-- Module Name: ALU_decodeur - Behavioral
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

entity ALU_decodeur is
   Port (
    ALUOp      : in  std_logic;
    Funct      : in  std_logic_vector(4 downto 0); -- [4:1]=opcode, [0]=S
    ALUControl : out std_logic_vector(1 downto 0);
    FlagW      : out std_logic_vector(1 downto 0)
   );
end ALU_decodeur;

architecture Behavioral of ALU_decodeur is
begin
process(ALUOp, Funct)
begin
  ALUControl <= "00";
  FlagW <= "00";

  if ALUOp = '1' then
    case Funct(4 downto 1) is
      when "0100" =>  -- ADD
        ALUControl <= "00";
        if Funct(0) = '1' then
          FlagW <= "11";
        end if;

      when "0010" =>  -- SUB
        ALUControl <= "01";
        if Funct(0) = '1' then
          FlagW <= "11";
        end if;

      when "1010" =>  -- CMP
        ALUControl <= "01";
        FlagW <= "11";

      when "0000" =>  -- AND
        ALUControl <= "10";
        if Funct(0) = '1' then
          FlagW <= "10";
        end if;

      when "1100" =>  -- ORR
        ALUControl <= "11";
        if Funct(0) = '1' then
          FlagW <= "10";
        end if;

      when others =>
        ALUControl <= "00";
        FlagW <= "00";
    end case;

  else
    
    ALUControl <= "00";
    FlagW <= "00";
  end if;
end process;

end Behavioral;
