----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2025 02:41:26 PM
-- Design Name: 
-- Module Name: Shifter - Behavioral
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



entity Shifter is
    Port ( 
    
    Data_in  : in  std_logic_vector(31 downto 0);
    ShType   : in  std_logic_vector(1 downto 0);  -- type de décalage (LSL, LSR, ASR, ROR)
    ShAmount : in  std_logic_vector(4 downto 0);  -- nombre de bits à décaler
    Data_out : out std_logic_vector(31 downto 0)   
        
    );
end Shifter;



architecture Behavioral of Shifter is
begin
  process(Data_in, ShType, ShAmount)
    variable temp : std_logic_vector(31 downto 0);
  begin
    case ShType is
      -- LSL : Logical Shift Left
      when "00" =>
        temp := std_logic_vector(shift_left(unsigned(Data_in), to_integer(unsigned(ShAmount))));

      -- LSR : Logical Shift Right
      when "01" =>
        temp := std_logic_vector(shift_right(unsigned(Data_in), to_integer(unsigned(ShAmount))));

      -- ASR : Arithmetic Shift Right (préserve le signe)
      when "10" =>
        if Data_in(31) = '1' then
          temp := std_logic_vector(shift_right(signed(Data_in), to_integer(unsigned(ShAmount))));
        else
          temp := std_logic_vector(shift_right(unsigned(Data_in), to_integer(unsigned(ShAmount))));
        end if;

      -- ROR : Rotate Right
      when others =>
        temp := std_logic_vector( (unsigned(Data_in) ror to_integer(unsigned(ShAmount))) );
    end case;

    Data_out <= temp;
  end process;
end Behavioral;
