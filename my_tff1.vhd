LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------
ENTITY my_tff1	IS	
	PORT	(	clk	:	IN		STD_LOGIC;
				rst	:	IN		STD_LOGIC;
				ena	:	IN		STD_LOGIC;
				q		:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
				d		:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0));
END ENTITY;
-------------------------------------------------------------------
ARCHITECTURE rtl OF my_tff1 IS 
BEGIN

	my_tff:	PROCESS(clk, ena, rst)
	BEGIN	
		IF(rst = '1')	THEN
			q <= "0000";
		ELSIF	(rising_edge(clk)) THEN
			IF	(ena = '1') THEN
				q	<= d;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;