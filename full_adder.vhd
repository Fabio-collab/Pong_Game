LIBRARY IEEE;
USE ieee.std_logic_1164.all;
---------------------------------------------------
ENTITY full_adder IS
	PORT(		A_B_Cin	:	IN		STD_LOGIC_VECTOR(2 DOWNTO 0);
				s_Cout	:	OUT	STD_LOGIC_VECTOR(1 DOWNTO 0));
END ENTITY full_adder;
---------------------------------------------------
ARCHITECTURE functional OF full_adder IS
BEGIN
	s_Cout <=	"00"	WHEN A_B_Cin = "000"	ELSE
		         "10"	WHEN A_B_Cin = "001" ELSE
					"10"	WHEN A_B_Cin = "010" ELSE
					"01"	WHEN A_B_Cin = "011" ELSE
					"10"	WHEN A_B_Cin = "100" ELSE
					"01"	WHEN A_B_Cin = "101" ELSE
					"01"	WHEN A_B_Cin = "110" ELSE
					"11";
		  
END ARCHITECTURE functional;