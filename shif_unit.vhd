--Shamt:
-- 00 - No Shift
-- 01 - shift right logical (SLR)
-- 10 - shift left logical (SLL)
-- 11 - Not used
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY shif_unit IS
    GENERIC (N : INTEGER :=8);
	 PORT (shamt : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	       dataa : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			 dataout : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY;
-----------------------------------------------------------------------
ARCHITECTURE rtl OF shif_unit IS
BEGIN
	WITH shamt SELECT
	dataout <= dataa WHEN "00",
	           '0' & dataa(N-1 DOWNTO 1) WHEN "01", 
	              dataa(N-2 DOWNTO 0) & '0'   WHEN "10", 
	               (OTHERS => '0')            WHEN OTHERS;      
END ARCHITECTURE;