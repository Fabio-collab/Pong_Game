LIBRARY IEEE;
USE ieee.std_logic_1164.all;
-------------------------------------------------------------------------------------
ENTITY  logica_raquetas IS
	PORT(	rst	:	IN	STD_LOGIC;
			clk	:	IN	STD_LOGIC;
			raq_current : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			led1_c : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			led2_c : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			led3_c : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			joy	:	IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
			ena	:IN	STD_LOGIC);
END ENTITY logica_raquetas;
-------------------------------------------------------------------------------------
ARCHITECTURE state_machine	OF logica_raquetas IS
	TYPE state IS (down, up, idle);
	SIGNAL pr_state, nx_state : state;
	SIGNAL raq_next, raq_arr, raq_aba : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL sel_r :STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL raqueta_c : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL raq	: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL clk_racquet : STD_LOGIC;
	SIGNAL en_reg_raq : STD_LOGIC;
	SIGNAL led1_current, led1_next,led1_aba, led1_arr, led2_current, led2_next,led2_aba, led2_arr, led3_current, led3_next,led3_aba, led3_arr : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
led1_c <= led1_current;
led2_c <= led2_current;
led3_c <= led3_current;
raq_current <= raqueta_c;
			en_reg_raq <= '1';
--------------------------------Sequential section-----------------------------------
PROCESS (rst, clk_racquet)
BEGIN
	IF (rst = '1') THEN
		pr_state <= idle;
	ELSIF (rising_edge(clk_racquet)) THEN
		pr_state <= nx_state;
	END IF;
END PROCESS;
------------------------------Combinational section----------------------------------
flip_flop_raq: ENTITY work. my_tff
						GENERIC MAP(MAX_WIDTH => 8,
										INICIAL => "00111000")
						PORT MAP( clk => clk_racquet,
									 ena => en_reg_raq,
									 rst => rst,
									 d	  => raq_next,
									 q   => raqueta_c);
-------------------------------------------------------------------------------------
mux_raq:ENTITY work.mux2_1_with_select
					GENERIC MAP (	MAX_WIDTH	=>	8)
					PORT MAP( x1 => raqueta_c,
								 x2 => raq_arr,
								 x3 => raq_aba,
								 sel => sel_r,
								 y	=> raq_next);
-------------------------------------------------------------------------------------
barrel_shifter1:ENTITY work.shif_unit
						GENERIC MAP(N	=>	8)
						PORT MAP(shamt	=>	sel_r,
									dataa => raqueta_c,
									dataout => raq_arr);
-------------------------------------------------------------------------------------
barrel_shifter2:ENTITY work.shif_unit
						GENERIC MAP(N => 8)
						PORT MAP(shamt => sel_r,
									dataa => raqueta_c,
									dataout => raq_aba);
-------------------------------------------------------------------------------------
corrimiento_abajoled1: ENTITY work.adder_substractor
								PORT MAP (	a	=> led1_current,
												b => "0001",
												s	=> led1_aba,
												Cin0	=>	'0');
----------------------------------------------------------------------------
corrimiento_arribaled1: ENTITY work.adder_substractor
								PORT MAP (	a	=> led1_current,
												b => "1110",
												s	=> led1_arr,
												Cin0	=>	'1');
-----------------------------------------------------------------------------	
mux_led1: ENTITY work. mux2_1_with_select
							GENERIC MAP (	MAX_WIDTH	=>	4)
							PORT MAP ( x1	=>	led1_current,
										  x2	=> led1_arr,
										  x3	=> led1_aba,
										  sel => sel_r,
										  y	=> led1_next);
------------------------------------------------------------------------------------------
flip_flop_led1: ENTITY work. my_tff
						GENERIC MAP(MAX_WIDTH => 4,
										INICIAL(3 DOWNTO 0) => "0101",
										INICIAL(7 DOWNTO 4) => "0000")
						PORT MAP( clk => clk_racquet,
									 ena => en_reg_raq,
									 rst => rst,
									 d	  => led1_next,
									 q   => led1_current);
-----------------------------------------------------------------------------------------------
corrimiento_abajoled2: ENTITY work.adder_substractor
								PORT MAP (	a	=> led2_current,
												b => "0001",
												s	=> led2_aba,
												Cin0	=>	'0');
----------------------------------------------------------------------------
corrimiento_arribaled2: ENTITY work.adder_substractor
								PORT MAP (	a	=> led2_current,
												b => "1110",
												s	=> led2_arr,
												Cin0	=>	'1');
-----------------------------------------------------------------------------	
mux_led2: ENTITY work. mux2_1_with_select
							GENERIC MAP (	MAX_WIDTH	=>	4)
							PORT MAP ( x1	=>	led2_current,
										  x2	=> led2_arr,
										  x3	=> led2_aba,
										  sel => sel_r,
										  y	=> led2_next);
------------------------------------------------------------------------------------------
flip_flop_led2: ENTITY work. my_tff
						GENERIC MAP(MAX_WIDTH => 4,
										INICIAL(3 DOWNTO 0) => "0100",
										INICIAL(7 DOWNTO 4) => "0000")
						PORT MAP( clk => clk_racquet,
									 ena => en_reg_raq,
									 rst => rst,
									 d	  => led2_next,
									 q   => led2_current);
-------------------------------------------------------------------------------------------
corrimiento_abajoled3: ENTITY work.adder_substractor
								PORT MAP (	a	=> led3_current,
												b => "0001",
												s	=> led3_aba,
												Cin0	=>	'0');
----------------------------------------------------------------------------
corrimiento_arribaled3: ENTITY work.adder_substractor
								PORT MAP (	a	=> led3_current,
												b => "1110",
												s	=> led3_arr,
												Cin0	=>	'1');
-----------------------------------------------------------------------------	
mux_led3: ENTITY work. mux2_1_with_select
							GENERIC MAP (	MAX_WIDTH	=>	4)
							PORT MAP ( x1	=>	led3_current,
										  x2	=> led3_arr,
										  x3	=> led3_aba,
										  sel => sel_r,
										  y	=> led3_next);
------------------------------------------------------------------------------------------
flip_flop_led3: ENTITY work. my_tff
						GENERIC MAP(MAX_WIDTH => 4,
										INICIAL(3 DOWNTO 0) => "0011",
										INICIAL(7 DOWNTO 4) => "0000")
						PORT MAP( clk => clk_racquet,
									 ena => en_reg_raq,
									 rst => rst,
									 d	  => led3_next,
									 q   => led3_current);
									 
--------------------------------------------------------------------------------
CLOCK:	ENTITY work.univ_bin_counter
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
					max_tick	=>	clk_racquet);
		


PROCESS(joy, pr_state, raqueta_c)
BEGIN
	CASE pr_state IS
		WHEN idle =>
			sel_r <= "00";
			IF (raqueta_c="00000111" AND joy = "10") THEN
				nx_state <= idle;
			ELSIF (joy = "10") THEN
				nx_state <= up;
			ELSIF (raqueta_c = "11100000" AND joy = "01") THEN
				nx_state <= idle;
			ELSIF (joy = "01") THEN 
				nx_state <= down;
			ELSE
				nx_state <= idle;
			END IF;
		WHEN down =>
			sel_r <= "10";
			IF (raqueta_c="00000111" AND joy = "10") THEN
				nx_state <= idle;
			ELSIF (joy = "10") THEN
				nx_state <= up;
			ELSIF (raqueta_c = "11100000" AND joy = "01") THEN
				nx_state <= idle;
			ELSIF (joy = "01") THEN 
				nx_state <= down;
			ELSE
				nx_state <= idle;
			END IF;
		WHEN up =>
			sel_r <= "01"; 
			IF (raqueta_c="00000111" AND joy = "10") THEN
				nx_state <= idle;
			ELSIF (joy = "10") THEN
				nx_state <= up;
			ELSIF (raqueta_c = "11100000" AND joy = "01") THEN
				nx_state <= idle;
			ELSIF (joy = "01") THEN 
				nx_state <= down;
			ELSE
				nx_state <= idle;
			END IF;
		END CASE;
	END PROCESS;
END ARCHITECTURE;
	
	
	
	