LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------------
ENTITY register_file IS
	PORT (	clk		 :		IN 	STD_LOGIC;
				rst		 : 	IN 	STD_LOGIC;
				wr_data	 :    IN    STD_LOGIC_VECTOR(127 DOWNTO 0);
				rd_data	 :    OUT   STD_LOGIC_VECTOR(127 DOWNTO 0));
END ENTITY;
-------------------------------------------------------------------------------------------------
ARCHITECTURE rtl OF register_file IS
	TYPE mem_2d_type IS ARRAY (1 DOWNTO 0) OF STD_LOGIC_VECTOR(127 DOWNTO 0);
	SIGNAL array_reg: mem_2d_type;
BEGIN
	--WRITE PROCESS
	write_procces: PROCESS(clk)
	BEGIN
		IF(rising_edge(clk)) THEN
				array_reg(0)<= wr_data;
		END IF;
	END PROCESS;
	
	rd_data <= array_reg(0);

END ARCHITECTURE;