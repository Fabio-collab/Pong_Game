LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------
ENTITY my_tff	IS	
	GENERIC( MAX_WIDTH   : INTEGER:= 4;
				INICIAL		: STD_LOGIC_VECTOR(7 DOWNTO 0));
	PORT	(	clk	:	IN		STD_LOGIC;
				rst	:	IN		STD_LOGIC;
				ena	:	IN		STD_LOGIC;
				q		:	OUT	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				d		:	IN		STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0));
END ENTITY;
-------------------------------------------------------------------
ARCHITECTURE rtl OF my_tff IS 
BEGIN

	my_tff:	PROCESS(clk, ena, rst)
	BEGIN	
		IF(rst = '1')	THEN
			q <= INICIAL(MAX_WIDTH-1 DOWNTO 0);
		ELSIF	(rising_edge(clk)) THEN
			IF	(ena = '1') THEN
				q	<= d;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;
