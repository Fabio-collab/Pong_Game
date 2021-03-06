LIBRARY IEEE;
USE ieee.std_logic_1164.all;
---------------------------------------------------------------------
ENTITY  logica_bola IS
	PORT(	rst	:	IN	STD_LOGIC;
			clk	:	IN	STD_LOGIC;
			ena	:	IN	STD_LOGIC;
			Raquet1_led1 :	IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
			Raquet1_led2 :	IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
			Raquet1_led3 :	IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
			Raquet2_led1 :	IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
			Raquet2_led2 :	IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
			Raquet2_led3 :	IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
			y_c			: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			x_c 			: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			goal_player1		: OUT STD_LOGIC;
			goal_player2		: OUT STD_LOGIC);
END ENTITY logica_bola;
---------------------------------------------------------------------
ARCHITECTURE state_machine	OF logica_bola IS
	TYPE state IS (arriba_izq, arriba_der, abajo_izq, abajo_der, inicial);
	SIGNAL pr_state, nx_state : state;
	SIGNAL left_colision1, left_colision2, left_colision3, right_colision1, right_colision2, right_colision3, top_colision, bottom_colision : STD_LOGIC;
	SIGNAL x_current, y_current, x_next, y_next, x_der, x_izq, y_aba, y_arr : STD_LOGIC_VECTOR (3 DOWNTO 0);
	SIGNAL sel_x, sel_y : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL clk_bola	: STD_LOGIC;
BEGIN
	y_c <= y_current;
	x_c <= x_current;
	
--------------------Sequential section--------------------------------
PROCESS (rst, clk_bola)
BEGIN
	IF (rst = '1') THEN
		pr_state <= inicial;
	ELSIF (rising_edge(clk)) THEN
		pr_state <= nx_state;
	END IF;
END PROCESS;
----------------------Combinational section---------------------------------
Comparador_top: ENTITY work.Comparador
								GENERIC MAP (	MAX_WIDTH	=>	4)
								PORT MAP (	x	=> y_current,
												y	=> "0000",
												eq => top_colision);
-----------------------------------------------------------------------------
Comparador_bottom: ENTITY work.Comparador
								GENERIC MAP (	MAX_WIDTH	=>	4)
								PORT MAP (	x	=> y_current,
												y	=> "1000",
												eq => bottom_colision);	
-----------------------------------------------------------------------------
Comparador_left1: ENTITY work.Comparador
								GENERIC MAP (	MAX_WIDTH	=>	4)
								PORT MAP (	x	=> Raquet1_led1,
												y	=> x_current,
												eq => left_colision1);
-----------------------------------------------------------------------------
Comparador_left2: ENTITY work.Comparador
								GENERIC MAP (	MAX_WIDTH	=>	4)
								PORT MAP (	x	=> Raquet1_led2,
												y	=> x_current,
												eq => left_colision2);
-----------------------------------------------------------------------------
Comparador_left3: ENTITY work.Comparador
								GENERIC MAP (	MAX_WIDTH	=>	4)
								PORT MAP (	x	=> Raquet1_led3,
												y	=> x_current,
												eq => left_colision3);
-----------------------------------------------------------------------------
Comparador_goal1: ENTITY work.Comparador
								GENERIC MAP (	MAX_WIDTH	=>	4)
								PORT MAP (	x	=> x_current,
												y	=> "1111",
												eq => goal_player1);
-----------------------------------------------------------------------------
Comparador_goal2: ENTITY work.Comparador
								GENERIC MAP (	MAX_WIDTH	=>	4)
								PORT MAP (	x	=> x_current,
												y	=> "0000",
												eq => goal_player2);	
-----------------------------------------------------------------------------
Comparador_right1: ENTITY work.Comparador
								GENERIC MAP (	MAX_WIDTH	=>	4)
								PORT MAP (	x	=> x_current,
												y	=> Raquet2_led1,
												eq => right_colision1);	
----------------------------------------------------------------------------
Comparador_right2: ENTITY work.Comparador
								GENERIC MAP (	MAX_WIDTH	=>	4)
								PORT MAP (	x	=> x_current,
												y	=> Raquet2_led2,
												eq => right_colision2);
----------------------------------------------------------------------------
Comparador_right3: ENTITY work.Comparador
								GENERIC MAP (	MAX_WIDTH	=>	4)
								PORT MAP (	x	=> x_current,
												y	=> Raquet2_led3,
												eq => right_colision3);
----------------------------------------------------------------------------
corrimiento_derecha: ENTITY work.adder_substractor
								PORT MAP (	a	=> x_current,
												b => "0001",
												s	=> x_der,
												Cin0	=>	'0');
----------------------------------------------------------------------------
corrimiento_izquierda: ENTITY work.adder_substractor
								PORT MAP (	a	=> x_current,
												b => "1110",
												s	=> x_izq,
												Cin0	=>	'1');
-----------------------------------------------------------------------------	
corrimiento_abajo: ENTITY work.adder_substractor
								PORT MAP (	a	=> y_current,
												b => "0001",
												s	=> y_aba,
												Cin0	=>	'0');
----------------------------------------------------------------------------
corrimiento_arriba: ENTITY work.adder_substractor
								PORT MAP (	a	=> x_current,
												b => "1110",
												s	=> y_arr,
												Cin0	=>	'1');
-----------------------------------------------------------------------------	
mux_x: ENTITY work. mux2_1_with_select
							GENERIC MAP (	MAX_WIDTH	=>	4)
							PORT MAP ( x1	=>	x_current,
										  x2	=> x_der,
										  x3	=> x_izq,
										  sel => sel_x,
										  y	=> x_next);
------------------------------------------------------------------------------
mux_y: ENTITY work. mux2_1_with_select
							GENERIC MAP (	MAX_WIDTH	=>	4)
							PORT MAP ( x1	=>	y_current,
										  x2	=> y_aba,
										  x3	=> y_arr,
										  sel => sel_y,
										  y	=> y_next);
-------------------------------------------------------------------------------
flip_flop_x: ENTITY work. my_tff1
						PORT MAP( clk => clk_bola,
									 ena => ena,
									 rst => rst,
									 d	  => x_next,
									 q   => x_current);
-------------------------------------------------------------------------------
flip_flop_y: ENTITY work. my_tff1
						PORT MAP( clk => clk_bola,
									 ena => ena,
									 rst => rst,
									 d	  => y_next,
									 q   => y_current);
---------------------------------------------------------------------------------
CLOCK:ENTITY work.univ_bin_counter
		GENERIC MAP(N => 24)
		PORT MAP(
					clk		=> clk,
					rst		=> rst,
					ena		=> ena,
					syn_clr	=> '0',
					load		=> '0',
					up			=> '1',
					d			=> "100110001001011010000000",
					lim_max	=>	"100110001001011010000000",
					max_tick	=>	clk_bola);
										 
PROCESS(left_colision1, left_colision2, left_colision3, right_colision1, right_colision2, right_colision3, top_colision, bottom_colision, pr_state)
BEGIN
	CASE pr_state IS
		WHEN inicial =>
			sel_x <= "00";
			sel_y <= "00";
			IF (rst = '0') THEN
				nx_state <= arriba_izq;
			ELSE
				nx_state <= inicial;
			END IF;
		WHEN arriba_izq =>
			sel_x <= "10";
			sel_y <= "01";
			IF (left_colision2 = '1') THEN
				nx_state <= arriba_der;
			ELSIF (top_colision = '1') THEN 
				nx_state <= abajo_izq;
			ELSIF (left_colision3 = '1' OR left_colision1 = '1') THEN
				nx_state <= abajo_der;
			ELSE
				nx_state <= arriba_izq;
			END IF;
		WHEN arriba_der =>
			sel_x <= "01";
			sel_y <= "10";
			IF (top_colision = '1') THEN
				nx_state <= abajo_der;
			ELSIF (right_colision3 = '1' OR right_colision1 = '1') THEN
				nx_state <= abajo_izq;
			ELSE
				nx_state <= arriba_der;
			END IF;
		WHEN abajo_izq =>
			sel_x <= "10";
			sel_y <= "01";
			IF (bottom_colision = '1') THEN
				nx_state <= arriba_izq;
			ELSIF (left_colision2 = '1') THEN 
				nx_state <= abajo_der;
			ELSIF (left_colision3 = '1' OR left_colision1 = '1') THEN
				nx_state <= arriba_der;
			ELSE
				nx_state <= abajo_izq;
			END IF;
		WHEN abajo_der =>
			sel_x <= "01";
			sel_y <= "01";
			IF (bottom_colision = '1') THEN
				nx_state <= arriba_der;
			ELSIF (right_colision2 = '1') THEN 
				nx_state <= abajo_izq;
			ELSIF (right_colision3 = '1' OR right_colision1 = '1') THEN
				nx_state <= arriba_izq;
			ELSE
				nx_state <= abajo_der;
		END IF;
		END CASE;
	END PROCESS;
END ARCHITECTURE;
	
	