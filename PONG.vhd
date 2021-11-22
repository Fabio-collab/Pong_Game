LIBRARY IEEE;
USE ieee.std_logic_1164.all;
---------------------------------------------------------------------
ENTITY  PONG IS
	PORT(	rst	:	IN	STD_LOGIC;
			clk	:	IN	STD_LOGIC;
			ena	:	IN	STD_LOGIC;
			joy1	:	IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
			joy2	:	IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			sseg1	:	OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
			sseg2	:	OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
			M2		:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0));
END ENTITY PONG;
------------------------------------------------------------------------
ARCHITECTURE functional	OF PONG IS
	SIGNAL goal_player1, goal_player2 : STD_LOGIC;
	SIGNAL raq1, raq2	:	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL led1_raq1, led2_raq1, led3_raq1, led1_raq2, led2_raq2, led3_raq2 : STD_LOGIC_VECTOR (3 DOWNTO 0);
	SIGNAL x_bola, y_bola : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL matrix :	STD_LOGIC_VECTOR(127 DOWNTO 0);
	SIGNAL display	:	STD_LOGIC_VECTOR(127 DOWNTO 0);
	SIGNAL clk_fps	:	STD_LOGIC;
	
BEGIN
	raqueta1: ENTITY work.logica_raquetas
						PORT MAP(	joy => joy1,
										raq_current => raq1,
										led1_c => led1_raq1,
										led2_c => led2_raq1,
										led3_c => led3_raq1,
										clk	=> clk,
										rst => rst,
										ena => ena);
	raqueta2: ENTITY work.logica_raquetas
						PORT MAP(	joy => joy2,
										raq_current => raq2,
										led1_c => led1_raq2,
										led2_c => led2_raq2,
										led3_c => led3_raq2,
										clk	=> clk,
										rst => rst,
										ena => ena);
	bola: ENTITY work.logica_bola
							PORT MAP(	Raquet1_led1 => led1_raq1,
											Raquet1_led2 => led2_raq1,
											Raquet1_led3 => led3_raq1,
											Raquet2_led1 => led1_raq2,
											Raquet2_led2 => led2_raq2,
											Raquet2_led3 => led3_raq2,
											y_c => y_bola,
											x_c => x_bola,
											goal_player1	=> goal_player1,
											goal_player2 	=> goal_player2,
											clk	=> clk,
											rst => rst,
											ena => ena);
	marcador: ENTITY work.logica_marcador
						PORT MAP(	goal_player1 => goal_player1,
										goal_player2 => goal_player2,
										sseg1 => sseg1,
										sseg2 => sseg2,
										clk => clk,
										rst => rst,
										ena => ena);
	matriz: ENTITY work.game_to_matrix
						PORT MAP(	xb => x_bola,
										yb => y_bola,
										raq1 => raq1,
										raq2 => raq2,
										matrix => matrix);
	registro: ENTITY work.register_file
						PORT MAP( clk => clk,
									 rst => rst,
									 wr_data => matrix,
									 rd_data => display);
	FSM_display: ENTITY work.ledMatrix_Controller_FSM
						PORT MAP( clk => clk,
									 rst => rst,
									 LED => display,
									 tick => clk_fps,
									 PIN_1   => M2(0),
									 PIN_2   => M2(1),
									 PIN_3   => M2(2),
									 PIN_4   => M2(3),
									 PIN_5   => M2(4),
									 PIN_6   => M2(5),
									 PIN_7   => M2(6),
									 PIN_8   => M2(7),
									 PIN_9   => M2(8),
									 PIN_10  => M2(9),
									 PIN_11  => M2(10),
									 PIN_12  => M2(11),
									 PIN_13  => M2(12),
									 PIN_14  => M2(13),
									 PIN_15  => M2(14),
									 PIN_16  => M2(15),
									 PIN_17  => M2(16),
									 PIN_18  => M2(17),
									 PIN_19  => M2(18),
									 PIN_20  => M2(19),
									 PIN_21  => M2(20),
									 PIN_22  => M2(21),
									 PIN_23  => M2(22),
									 PIN_24  => M2(23),
									 PIN_25  => M2(24),
									 PIN_26  => M2(25),
									 PIN_27  => M2(26),
									 PIN_28  => M2(27),
									 PIN_29  => M2(28),
									 PIN_30  => M2(29),
									 PIN_31  => M2(30),
									 PIN_32  => M2(31));
	counter_fps: ENTITY work.univ_bin_counter
		GENERIC MAP(N => 16)
		PORT MAP(
					clk		=> clk,
					rst		=> rst,
					ena		=> ena,
					syn_clr	=> '0',
					load		=> '0',
					up			=> '1',
					d			=> "0100010001011100",
					lim_max	=>	"0100010001011100",
					max_tick	=>	clk_fps);
	
END ARCHITECTURE;
	