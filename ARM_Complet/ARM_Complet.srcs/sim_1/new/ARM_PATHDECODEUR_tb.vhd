----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2025 07:19:11 PM
-- Design Name: 
-- Module Name: ARM_PATHDECODEUR_tb - Behavioral
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
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;

entity ARM_PATHDECODEUR_tb is
end ARM_PATHDECODEUR_tb;

architecture sim of ARM_PATHDECODEUR_tb is
  constant CLK_PERIOD : time := 10 ns;
  
  signal Clk         : std_logic := '0';
  signal Rst         : std_logic := '0';  
  signal Instruction : std_logic_vector(31 downto 0) := (others => '0');
  signal R15_in      : std_logic_vector(31 downto 0) := (others => '0');
  signal N, Z, C, V  : std_logic;
  signal Result      : std_logic_vector(31 downto 0);
  
  file TB_Input  : text;
  file TB_Output : text;
  
begin
  -- Génération de l'horloge
  clk_gen : process
  begin
    Clk <= '0'; 
    wait for CLK_PERIOD/2;
    Clk <= '1'; 
    wait for CLK_PERIOD/2;
  end process;
  
  -- Instanciation du DUT (Device Under Test)
  DUT : entity work.ARM_PATHDECODEUR
    port map (
      Clk         => Clk,
      Rst         => Rst,
      Instruction => Instruction,
      R15_in      => R15_in,
      N           => N,
      Z           => Z,
      C           => C,
      V           => V,
      Result      => Result
    );
  
  -- Processus de test principal
  process
    variable L, L_out : line;
    variable dummy : character;
    variable v_instr, v_expALU, v_expData : std_logic_vector(31 downto 0);
    variable verdict : string(1 to 4);
    variable test_id : integer := 0;
  begin
    -- Ouverture des fichiers
    FILE_OPEN(TB_Input,  "C:/Users/Daniel/Desktop/aut25/Architecture/ARM_complet/Data.txt", READ_MODE);
    FILE_OPEN(TB_Output, "C:/Users/Daniel/Desktop/aut25/Architecture/ARM_complet/Data_out.txt", WRITE_MODE);
    
    -- Reset initial
    Rst <= '1';
    wait for 20 ns;
    Rst <= '0';
    wait for 10 ns;
    
    -- Lecture et exécution des instructions
    while not endfile(TB_Input) loop
      readline(TB_Input, L);
      
      -- Lecture de l'instruction et des valeurs attendues
      read(L, v_instr);    -- Instruction 32 bits
      read(L, dummy);      -- Séparateur '_'
      read(L, v_expALU);   -- Résultat attendu (ALU)
      read(L, dummy);      -- Séparateur '_'
      read(L, v_expData);  -- Résultat attendu (après mémoire)
      
      -- Application de l'instruction
      wait until rising_edge(Clk);
      Instruction <= v_instr;
      
      -- Attendre la fin du cycle pour vérifier le résultat
      wait until falling_edge(Clk);
      
      -- Vérification du résultat
      if Result = v_expALU then
        verdict := "PASS";
      else
        verdict := "FAIL";
      end if;
      
      -- Écriture du résultat dans le fichier de sortie
      test_id := test_id + 1;
      write(L_out, string'("Test "));
      write(L_out, test_id);
      write(L_out, string'(": "));
      write(L_out, v_instr);           -- Instruction
      write(L_out, string'("_"));
      write(L_out, Result);             -- Résultat obtenu
      write(L_out, string'("_"));
      write(L_out, v_expALU);           -- Résultat attendu (ALU)
      write(L_out, string'("_"));
      write(L_out, verdict);            -- PASS/FAIL
      writeline(TB_Output, L_out);
      
    end loop;
    
    -- Fermeture des fichiers
    file_close(TB_Input);
    file_close(TB_Output);
    
    report "===== Simulation terminée. Consultez Data_out.txt pour les résultats. =====" severity note;
    wait;
  end process;

end architecture;