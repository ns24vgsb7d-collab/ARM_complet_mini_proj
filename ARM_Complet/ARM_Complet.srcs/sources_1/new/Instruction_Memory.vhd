----------------------------------------------------------------------------------
-- Company: UQTR
-- Engineer: Daniel kabeya
-- 
-- Create Date: 11/06/2025 08:11:28 PM
-- Design Name: 
-- Module Name: Instruction_Memory - Behavioral
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

entity Instruction_Memory is
  Port (
    A  : in  std_logic_vector(4 downto 0);   -- PC(6 downto 2)
    RD : out std_logic_vector(31 downto 0)   -- Instruction lue
  );
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is
  type mem_type is array (0 to 31) of std_logic_vector(31 downto 0);
  signal ROM : mem_type := (
    0  => "11100011010000000000000000000000",
    1  => "11100010100000010001000000000100",
    2  => "11100000100000010010000010000000",
    3  => "11100000100100100011000000100001",
    4  => "11100010101000100000000000000011",
    5  => "11100010100000110001000000000100",
    others => (others => '0')
  );
begin
  RD <= ROM(to_integer(unsigned(A)));
end Behavioral;

