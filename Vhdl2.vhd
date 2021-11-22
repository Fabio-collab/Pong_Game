LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
---------------------------------------------------------
ENTITY cronometro IS
   GENERIC ( N		:	INTEGER   := 23;
				 MAX	:	INTEGER	:= 5000000);
	
	PORT    ( clk      :   IN   STD_LOGIC;
			    rst      :   IN   STD_LOGIC;
				 ena      :   IN   STD_LOGIC;
				 syn_clr  :   IN   STD_LOGIC;
				 max_tick :   OUT  STD_LOGIC;
				 counter  :   OUT  STD_LOGIC_VECTOR(N-1  DOWNTO 0));
END ENTITY;
-----------------------------------------------------------
ARCHITECTURE  rtl  OF cronometro IS 
   CONSTANT ONES    :   UNSIGNED (N-1  DOWNTO 0)  :=  (OTHERS  => '1');
   CONSTANT ZEROS   :   UNSIGNED (N-1  DOWNTO 0)  :=  (OTHERS  => '0');
   --SIGNED count_s :  INTEGER RANGE 0 to (2**N - 1);
   SIGNAL   count_s    :  UNSIGNED (N-1  DOWNTO 0);
	SIGNAL   count_next :  UNSIGNED (N-1  DOWNTO 0);
	SIGNAL	max_tick_s	:	STD_LOGIC;
	SIGNAL max_width_s : UNSIGNED (N-1 DOWNTO 0);
BEGIN 
   --NEXT STATE LOGIC
   count_next   <=   (OTHERS  => '0')  WHEN  syn_clr  =  '1'  OR max_tick_s = '1'      ELSE 
	                   count_s + 1      WHEN  (ena     =  '1' )      ELSE
							 count_s ;
PROCESS (clk,rst)
    VARIABLE temp    :  UNSIGNED (N-1  DOWNTO 0);
BEGIN 
    IF(rst = '1')  THEN
	    temp  := (OTHERS  =>  '0');
	 ELSIF  (rising_edge(clk)) THEN
	    IF  (ena   = '1') THEN
		      temp := count_next;
		 END IF;
    END IF; 
    counter  <=  STD_LOGIC_VECTOR(temp);
    count_s  <=  temp;
END PROCESS;
max_width_s <= to_unsigned(MAX,N);
 max_tick_s <=  '1'  when  count_s  =  max_width_s  ELSE '0';
 max_tick <= max_tick_s;
END ARCHITECTURE;
		 
