LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE std.standard.all;
-------------------------------------------------------------------------------------
ENTITY  logica_marcador IS
	PORT(	clk		:	IN	STD_LOGIC;
			rst		:	IN	STD_LOGIC;
			ena		:	IN	STD_LOGIC;
			sseg1	:	OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
			sseg2	:	OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
			goal_player1	:	IN STD_LOGIC;
			goal_player2	:	IN STD_LOGIC);
END ENTITY logica_marcador;
--------------------------------------------------------------------------------------
ARCHITECTURE functional	OF logica_marcador IS
	SIGNAL marcador1_goal	:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL marcador2_goal	:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL marcador1_next	:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL marcador2_next	:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL marcador1	:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL marcador2   :	STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	suma1: ENTITY work.adder_substractor
							PORT MAP(	a => marcador1,
											b => "0001",
											Cin0 => '0',
											s	=> marcador1_goal);
	suma2: ENTITY work.adder_substractor
							PORT MAP(	a => marcador2,
											b => "0001",
											Cin0 => '0',
											s	=> marcador2_goal);
	
	mux_goal1: ENTITY work.mux2_1_with_select1
								PORT MAP (	x1	=> marcador1_goal,
												x2 => marcador1,
												sel => goal_player1,
												y => marcador1_next);
	mux_goal2: ENTITY work.mux2_1_with_select1
								PORT MAP (	x1	=> marcador2_goal,
												x2 => marcador2,
												sel => goal_player2,
												y => marcador2_next);
	flip_flop_goal1: ENTITY work.my_tff1
								PORT MAP (	clk => clk,
												rst => rst,
												ena => ena,
												q => marcador1,
												d => marcador1_next);
	flip_flop_goal2: ENTITY work.my_tff1
								PORT MAP (	clk => clk,
												rst => rst,
												ena => ena,
												q => marcador2,
												d => marcador2_next);
	Pantalla: ENTITY work.segmentos7
								PORT MAP (	bin_0 => marcador1,
												bin_1 => marcador2,
												sseg_x0 => sseg1,
												sseg_x1 => sseg2);
END ARCHITECTURE;												