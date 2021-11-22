LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
---------------------------------------------------------------
ENTITY adder_substractor IS
	PORT(		a		    :	IN		STD_LOGIC_VECTOR (3 DOWNTO 0);
				b		    :	IN		STD_LOGIC_VECTOR (3 DOWNTO 0);
            s		    :	OUT	STD_LOGIC_VECTOR  (3 DOWNTO 0);
				Cin0 	    :	IN		STD_LOGIC);
END ENTITY adder_substractor;
---------------------------------------------------------------
ARCHITECTURE gateLevel OF adder_substractor IS
	SIGNAL	C0out  :	STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN
	adder_0: ENTITY work.full_adder
	PORT MAP (	A_B_Cin(0)	=> Cin0,
					A_B_Cin(1)	=> a(0),
					A_B_Cin(2)   => b(0),
					s_Cout(1)	=> s(0),
					s_Cout(0) 	=> C0out(0));
					
	adder_1: ENTITY work.full_adder
	PORT MAP(	A_B_Cin(0)	=> C0out(0),
					A_B_Cin(1)		=> a(1),
					A_B_Cin(2)    => b(1),
					s_Cout(1)		=> s(1),
					s_Cout(0)	=> C0out(1));
	
	adder_2:ENTITY work.full_adder
	PORT MAP (	A_B_Cin(0)	=> C0out(1),
					A_B_Cin(1)		=> a(2),
					A_B_Cin(2)	   => b(2),
					s_Cout(1)		=> s(2),
					s_Cout(0)	=> C0out(2));
					
	adder_3:ENTITY work.full_adder
	PORT MAP (	A_B_Cin(0)	=> C0out(2),
					A_B_Cin(1)		=> a(3),
					A_B_Cin(2)	   => b(3),
					s_Cout(1)		=> s(3),
					s_Cout(0)	=> C0out(3));	

END ARCHITECTURE gateLevel; 