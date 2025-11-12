----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2025 09:07:43 PM
-- Design Name: 
-- Module Name: ARM_TOP_TB - sim
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


entity ARM_TOP_tb is
end ARM_TOP_tb;

architecture sim of ARM_TOP_tb is
  -- Déclaration du composant à tester
  component ARM_TOP
    port (
      CLK : in  std_logic;
      RST : in  std_logic
    );
  end component;

  -- Signaux de stimulation
  signal CLK : std_logic := '0';
  signal RST : std_logic := '1';

begin

  -- Instanciation du processeur ARM complet

  DUT : ARM_TOP
    port map (
      CLK => CLK,
      RST => RST
    );


  -- Génération de l’horloge (période = 10 ns)

  Clock_Gen : process
  begin
    while true loop
      CLK <= '0';
      wait for 5 ns;
      CLK <= '1';
      wait for 5 ns;
    end loop;
  end process;


  -- Signal de reset : actif pendant les 2 premières nanosecondes

  Reset_Gen : process
  begin
    RST <= '1';
    wait for 2 ns;
    RST <= '0';
    wait;
  end process;



end sim;