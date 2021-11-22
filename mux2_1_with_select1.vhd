LIBRARY IEEE;
USE ieee.std_logic_1164.all;
----------------------------------------------------------
ENTITY mux2_1_with_select1 IS
	PORT(	x1		:	IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
			x2		:	IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
			sel	:	IN	STD_LOGIC;
			y		:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0));
END ENTITY mux2_1_with_select1;
----------------------------------------------------------
ARCHITECTURE functional OF mux2_1_with_select1 IS
BEGIN
	WITH sel SELECT
		y	<=	x1	WHEN	'1',
				x2	WHEN OTHERS;
END ARCHITECTURE functional;