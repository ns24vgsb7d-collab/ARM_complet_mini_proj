----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2025 08:13:42 PM
-- Design Name: 
-- Module Name: PC_Register - Behavioral
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

entity PC_Register is
  Port (
    CLK   : in  std_logic;
    RST   : in  std_logic;
    PCSrc : in  std_logic_vector(31 downto 0); -- nouvelle valeur du PC
    PC    : out std_logic_vector(31 downto 0)  -- valeur actuelle
  );
end PC_Register;

architecture Behavioral of PC_Register is
  signal PC_reg : std_logic_vector(31 downto 0) := (others => '0');
begin
  process (RST, CLK)
  begin
    if RST = '1' then
      PC_reg <= (others => '0');
    elsif rising_edge(CLK) then
      PC_reg <= PCSrc;  -- ou PC_reg + 4 si séquentiel
    end if;
  end process;

  PC <= PC_reg;

end Behavioral;
