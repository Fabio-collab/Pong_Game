LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------------
ENTITY ledMatrix_Controller_FSM IS 
	PORT ( clk   	: IN STD_LOGIC;
			 rst     : IN STD_LOGIC;
			 LED     : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
			 tick	   : IN STD_LOGIC;
			 PIN_1   : OUT STD_LOGIC;
			 PIN_2   : OUT STD_LOGIC;
			 PIN_3   : OUT STD_LOGIC;
			 PIN_4   : OUT STD_LOGIC;
			 PIN_5   : OUT STD_LOGIC;
			 PIN_6   : OUT STD_LOGIC;
			 PIN_7   : OUT STD_LOGIC;
			 PIN_8   : OUT STD_LOGIC;
			 PIN_9   : OUT STD_LOGIC;
			 PIN_10  : OUT STD_LOGIC;
			 PIN_11  : OUT STD_LOGIC;
			 PIN_12  : OUT STD_LOGIC;
			 PIN_13  : OUT STD_LOGIC;
			 PIN_14  : OUT STD_LOGIC;
			 PIN_15  : OUT STD_LOGIC;
			 PIN_16  : OUT STD_LOGIC;
			 PIN_17  : OUT STD_LOGIC;
			 PIN_18  : OUT STD_LOGIC;
			 PIN_19  : OUT STD_LOGIC;
			 PIN_20  : OUT STD_LOGIC;
			 PIN_21  : OUT STD_LOGIC;
			 PIN_22  : OUT STD_LOGIC;
			 PIN_23  : OUT STD_LOGIC;
			 PIN_24  : OUT STD_LOGIC;
			 PIN_25  : OUT STD_LOGIC;
			 PIN_26  : OUT STD_LOGIC;
			 PIN_27  : OUT STD_LOGIC;
			 PIN_28  : OUT STD_LOGIC;
			 PIN_29  : OUT STD_LOGIC;
			 PIN_30  : OUT STD_LOGIC;
			 PIN_31  : OUT STD_LOGIC;
			 PIN_32  : OUT STD_LOGIC);
			 
END ledMatrix_Controller_FSM;
-------------------------------------------------------------------------------------
ARCHITECTURE my_arch OF  ledMatrix_Controller_FSM IS
	TYPE state IS ( stby, LED_1,  LED_2,  LED_3,  LED_4,  LED_5,  LED_6,  LED_7, LED_8,  
								 LED_9,  LED_10, LED_11, LED_12, LED_13, LED_14, LED_15, LED_16, 
								 LED_17, LED_18, LED_19, LED_20, LED_21, LED_22, LED_23, LED_24,
								 LED_25, LED_26, LED_27, LED_28, LED_29, LED_30, LED_31, LED_32,
								 LED_33, LED_34, LED_35, LED_36, LED_37, LED_38, LED_39, LED_40,
								 LED_41, LED_42, LED_43, LED_44, LED_45, LED_46, LED_47, LED_48,
								 LED_49, LED_50, LED_51, LED_52, LED_53, LED_54, LED_55, LED_56,
								 LED_57, LED_58, LED_59, LED_60, LED_61, LED_62, LED_63, LED_64,
								 LED_65, LED_66, LED_67, LED_68, LED_69, LED_70, LED_71, LED_72,  
								 LED_73, LED_74, LED_75, LED_76, LED_77, LED_78, LED_79, LED_80, 
								 LED_81, LED_82, LED_83, LED_84, LED_85, LED_86, LED_87, LED_88,
								 LED_89, LED_90, LED_91, LED_92, LED_93, LED_94, LED_95, LED_96,
								 LED_97, LED_98, LED_99, LED_100, LED_101, LED_102, LED_103, LED_104, 
								 LED_105, LED_106, LED_107, LED_108, LED_109, LED_110, LED_111, LED_112, 
							    LED_113, LED_114, LED_115, LED_116, LED_117, LED_118, LED_119, LED_120, 
								 LED_121, LED_122, LED_123, LED_124, LED_125, LED_126, LED_127, LED_128);
	SIGNAL pr_state, nx_state: state;
	CONSTANT clk_freq : integer:= 12e6;
	SIGNAL clk_counter : integer;
	SIGNAL row_counter : unsigned(2 DOWNTO 0);
	
BEGIN
	
	COUNTER_PROC : PROCESS(clk)
	BEGIN
		IF rising_edge(clk) THEN
		
			IF clk_counter = clk_freq - 1 THEN
			  clk_counter <= 0;
			  
			  row_counter <= row_counter +1;
			  
			ELSE 
			  clk_counter <= clk_counter + 1;
			END IF;
			
		END IF;
	END PROCESS; -- COUNTER_PROC
	
	--CombinationalSection-------------------------------------------------------------
	
	PROCESS (rst, clk)
	BEGIN
	
		IF (rst='1') THEN
			pr_state <= stby;
			ELSIF (rising_edge(clk)) THEN
			pr_state <= nx_state;
		END IF;
		
	END PROCESS;
	
	--UpperSection-------------------------------------------------------------
	
	PROCESS (LED, tick, pr_state)
	BEGIN
	
		CASE pr_state IS
		WHEN stby =>
		-- Columns_Assignment_Matrix_1----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows_Assignment_Matrix_1-------------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			IF (tick='1') THEN
				nx_state <= LED_1;
			ELSE 
				nx_state <= stby;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_1 =>
		-- Columns Assignment ----------
			PIN_13 <= LED(0);	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '0';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_2;
			ELSE 
				nx_state <= LED_1;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_2 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= LED(1);			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '0';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_3;
			ELSE 
				nx_state <= LED_2;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_3 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= LED(2);		 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '0';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_4;
			ELSE 
				nx_state <= LED_3;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_4 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= LED(3);		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '0';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_5;
			ELSE 
				nx_state <= LED_4;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_5 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	       PIN_6 <= LED(4);
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '0';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_6;
			ELSE 
				nx_state <= LED_5;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_6 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= LED(5);
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '0';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_7;
			ELSE 
				nx_state <= LED_6;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_7 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= LED(6);
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '0';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			IF (tick='1') THEN
				nx_state <= LED_8;
			ELSE 
				nx_state <= LED_7;
			END IF; 
	------------------------------------------------------------------------------
		WHEN LED_8 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= LED(7);	
		-- Rows Assignment ----------
			PIN_9 <= '0';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_9;
			ELSE 
				nx_state <= LED_8;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_9 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= LED(8);	    PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '0';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_10;
			ELSE 
				nx_state <= LED_9;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_10 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= LED(9);		 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '0';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_11;
			ELSE 
				nx_state <= LED_10;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_11 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= LED(10);    PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '0';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	    PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_12;
			ELSE 
				nx_state <= LED_11;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_12 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';	       PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= LED(11);	 PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '0';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_13;
			ELSE 
				nx_state <= LED_12;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_13 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= LED(12);
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '0';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_14;
			ELSE 
				nx_state <= LED_13;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_14 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= LED(13);
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '0';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_15;
			ELSE 
				nx_state <= LED_14;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_15 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= LED(14);
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '0';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			IF (tick='1') THEN
				nx_state <= LED_16;
			ELSE 
				nx_state <= LED_15;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_16 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= LED(15);	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '0';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_17;
			ELSE 
				nx_state <= LED_16;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_17 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= LED(16);	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '0';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_18;
			ELSE 
				nx_state <= LED_17;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_18 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= LED(17);	    PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '0';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_19;
			ELSE 
				nx_state <= LED_18;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_19 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= LED(18);		 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '0';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_20;
			ELSE 
				nx_state <= LED_19;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_20 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= LED(19);	 PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '0';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_21;
			ELSE 
				nx_state <= LED_20;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_21 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= LED(20);
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '0';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_22;
			ELSE 
				nx_state <= LED_21;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_22 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= LED(21);
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '0';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_23;
			ELSE 
				nx_state <= LED_22;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_23 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= LED(22);
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '0';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_24;
			ELSE 
				nx_state <= LED_23;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_24 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= LED(23);	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '0';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_25;
			ELSE 
				nx_state <= LED_24;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_25 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= LED(24);	 PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '0';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_26;
			ELSE 
				nx_state <= LED_25;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_26 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= LED(25);			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '0';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_27;
			ELSE 
				nx_state <= LED_26;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_27 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= LED(26);			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '0';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_28;
			ELSE 
				nx_state <= LED_27;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_28 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= LED(27);	 PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '0';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_29;
			ELSE 
				nx_state <= LED_28;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_29 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= LED(28);
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '0';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_30;
			ELSE 
				nx_state <= LED_29;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_30 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= LED(29);
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '0';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_31;
			ELSE 
				nx_state <= LED_30;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_31 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= LED(30);
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '0';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_32;
			ELSE 
				nx_state <= LED_31;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_32 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= LED(31);	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '0';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_33;
			ELSE 
				nx_state <= LED_32;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_33 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= LED(32);	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '0';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_34;
			ELSE 
				nx_state <= LED_33;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_34 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= LED(33);			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '0';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_35;
			ELSE 
				nx_state <= LED_34;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_35 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= LED(34);			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '0';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_36;
			ELSE 
				nx_state <= LED_35;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_36 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= LED(35);	 PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '0';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_37;
			ELSE 
				nx_state <= LED_36;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_37 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= LED(36);
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '0';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_38;
			ELSE 
				nx_state <= LED_37;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_38 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';   	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= LED(37);
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '0';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_39;
			ELSE 
				nx_state <= LED_38;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_39 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= LED(38);
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '0';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_40;
			ELSE 
				nx_state <= LED_39;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_40 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= LED(39);	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '0';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_41;
			ELSE 
				nx_state <= LED_40;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_41 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= LED(40);	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '0';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_42;
			ELSE 
				nx_state <= LED_41;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_42 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= LED(41);			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '0';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_43;
			ELSE 
				nx_state <= LED_42;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_43 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= LED(42);			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '0';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_44;
			ELSE 
				nx_state <= LED_43;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_44 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= LED(43);		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '0';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_45;
			ELSE 
				nx_state <= LED_44;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_45 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= LED(44);
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '0';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_46;
			ELSE 
				nx_state <= LED_45;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_46 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= LED(45);
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '0';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_47;
			ELSE 
				nx_state <= LED_46;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_47 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= LED(46);
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '0';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_48;
			ELSE 
				nx_state <= LED_47;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_48 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= LED(47);	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '0';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_49;
			ELSE 
				nx_state <= LED_48;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_49 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= LED(48);	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '0';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_50;
			ELSE 
				nx_state <= LED_49;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_50 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= LED(49);			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '0';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_51;
			ELSE 
				nx_state <= LED_50;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_51 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= LED(50);			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '0';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_52;
			ELSE 
				nx_state <= LED_51;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_52 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= LED(51);		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '0';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_53;
			ELSE 
				nx_state <= LED_52;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_53 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= LED(52);
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '0';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_54;
			ELSE 
				nx_state <= LED_53;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_54 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= LED(53);
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '0';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_55;
			ELSE 
				nx_state <= LED_54;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_55 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= LED(54);
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '0';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_56;
			ELSE 
				nx_state <= LED_55;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_56 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= LED(55);	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '0';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_57;
			ELSE 
				nx_state <= LED_56;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_57 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1;	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= LED(56);	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '0';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_58;
			ELSE 
				nx_state <= LED_57;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_58=>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= LED(57);			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '0';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_59;
			ELSE 
				nx_state <= LED_58;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_59 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= LED(58);			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '0';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_60;
			ELSE 
				nx_state <= LED_59;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_60 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= LED(59);		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '0';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_61;
			ELSE 
				nx_state <= LED_60;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_61 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= LED(60);
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '0';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_62;
			ELSE 
				nx_state <= LED_61;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_62 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= LED(61);
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '0';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_63;
			ELSE 
				nx_state <= LED_62;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_63 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= LED(62);
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '0';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_62;
			ELSE 
				nx_state <= LED_63;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_64 =>
		-- Columns_Assignment_Matrix_1 ----------
			PIN_13 <= '0';	    PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment_Matrix_1 ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
		-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= LED(63);	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '0';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_63;
			ELSE 
				nx_state <= LED_64;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_65 =>
		-- Columns Assignment ----------
			PIN_13 <= LED(64);	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '0';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_64;
			ELSE 
				nx_state <= LED_65;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_66 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= LED(65);			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '0';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_67;
			ELSE 
				nx_state <= LED_66;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_67 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= LED(66);			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '0';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_68;
			ELSE 
				nx_state <= LED_67;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_68 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= LED(67);		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '0';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_69;
			ELSE 
				nx_state <= LED_68;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_69 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= LED(68);
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '0';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_70;
			ELSE 
				nx_state <= LED_69;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_70 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= LED(69);
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '0';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_71;
			ELSE 
				nx_state <= LED_70;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_71 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= LED(70);
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '0';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			IF (tick='1') THEN
				nx_state <= LED_72;
			ELSE 
				nx_state <= LED_71;
			END IF; 
	------------------------------------------------------------------------------
		WHEN LED_72 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= LED(71);	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '0';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_73;
			ELSE 
				nx_state <= LED_72;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_73 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= LED(72);	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '0';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_74;
			ELSE 
				nx_state <= LED_73;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_74 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= LED(73);			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '0';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_75;
			ELSE 
				nx_state <= LED_74;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_75 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= LED(74);			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '0';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_76;
			ELSE 
				nx_state <= LED_75;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_76 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	       PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= LED(7);		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '0';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_77;
			ELSE 
				nx_state <= LED_76;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_77 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= LED(76);
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '0';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_78;
			ELSE 
				nx_state <= LED_77;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_78 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= LED(77);
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '0';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_79;
			ELSE 
				nx_state <= LED_78;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_79 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= LED(78);
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '0';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			IF (tick='1') THEN
				nx_state <= LED_80;
			ELSE 
				nx_state <= LED_79;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_80 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= LED(79);	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '0';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_81;
			ELSE 
				nx_state <= LED_80;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_81 =>
		-- Columns Assignment ----------
			PIN_13 <= LED(80);	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '0';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_82;
			ELSE 
				nx_state <= LED_81;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_82 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= LED(81);			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '0';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_83;
			ELSE 
				nx_state <= LED_82;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_83 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= LED(82);			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '0';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_84;
			ELSE 
				nx_state <= LED_83;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_84 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= LED(83);		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '0';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_85;
			ELSE 
				nx_state <= LED_84;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_85 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= LED(84);
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '0';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_86;
			ELSE 
				nx_state <= LED_85;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_86 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= LED(85);
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '0';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_87;
			ELSE 
				nx_state <= LED_86;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_87 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= LED(86);
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '0';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_88;
			ELSE 
				nx_state <= LED_87;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_88 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= LED(87);	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '0';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_89;
			ELSE 
				nx_state <= LED_88;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_89 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= LED(88);	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '0';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_90;
			ELSE 
				nx_state <= LED_89;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_90 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= LED(89);			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '0';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_91;
			ELSE 
				nx_state <= LED_90;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_91 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= LED(90);			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '0';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_92;
			ELSE 
				nx_state <= LED_91;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_92 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= LED(91);		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '0';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_93;
			ELSE 
				nx_state <= LED_92;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_93 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= LED(92);
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '0';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_94;
			ELSE 
				nx_state <= LED_93;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_94 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= LED(93);
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '0';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_95;
			ELSE 
				nx_state <= LED_94;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_95 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	 PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= LED(94);
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '0';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_96;
			ELSE 
				nx_state <= LED_95;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_96 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= LED(95);	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '0';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_97;
			ELSE 
				nx_state <= LED_96;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_97 =>
		-- Columns Assignment ----------
			PIN_13 <= LED(96);	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '0';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_98;
			ELSE 
				nx_state <= LED_97;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_98 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= LED(97);			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '0';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_99;
			ELSE 
				nx_state <= LED_98;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_99 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= LED(98);			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '0';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_100;
			ELSE 
				nx_state <= LED_99;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_100 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= LED(99);		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '0';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_101;
			ELSE 
				nx_state <= LED_100;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_101 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= LED(100);
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '0';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_102;
			ELSE 
				nx_state <= LED_101;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_102 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= LED(101);
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '0';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			IF (tick='1') THEN
				nx_state <= LED_103;
			ELSE 
				nx_state <= LED_102;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_103 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= LED(102);
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '0';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_104;
			ELSE 
				nx_state <= LED_103;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_104 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= LED(103);	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '0';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_105;
			ELSE 
				nx_state <= LED_104;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_105 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= LED(104);	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '0';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_106;
			ELSE 
				nx_state <= LED_105;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_106 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= LED(105);			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '0';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_107;
			ELSE 
				nx_state <= LED_106;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_107 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= LED(106);			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '0';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_108;
			ELSE 
				nx_state <= LED_107;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_108 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= LED(107);		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '0';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_109;
			ELSE 
				nx_state <= LED_108;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_109 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= LED(108);
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '0';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_110;
			ELSE 
				nx_state <= LED_109;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_110 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= LED(109);
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '0';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_111;
			ELSE 
				nx_state <= LED_110;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_111 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= LED(110);
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '0';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_112;
			ELSE 
				nx_state <= LED_111;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_112 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= LED(111);	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '0';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_113;
			ELSE 
				nx_state <= LED_112;
			END IF;
	------------------------------------------------------------------------------
	WHEN LED_113 =>
		-- Columns Assignment ----------
			PIN_13 <= LED(112);	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '0';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_114;
			ELSE 
				nx_state <= LED_113;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_114 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= LED(113);			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '0';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_115;
			ELSE 
				nx_state <= LED_114;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_115 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= LED(114);			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '0';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_116;
			ELSE 
				nx_state <= LED_115;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_116 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= LED(115);		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '0';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_117;
			ELSE 
				nx_state <= LED_116;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_117 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= LED(116);
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '0';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_118;
			ELSE 
				nx_state <= LED_117;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_118 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= LED(117);
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '0';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_119;
			ELSE 
				nx_state <= LED_118;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_119 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= LED(118);
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '0';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_120;
			ELSE 
				nx_state <= LED_119;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_120 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= LED(119);	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '0';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '1';
			
			IF (tick='1') THEN
				nx_state <= LED_121;
			ELSE 
				nx_state <= LED_120;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_121 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= LED(120);	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '0';
			
			IF (tick='1') THEN
				nx_state <= LED_122;
			ELSE 
				nx_state <= LED_121;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_122=>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= LED(121);			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '0';
			
			IF (tick='1') THEN
				nx_state <= LED_123;
			ELSE 
				nx_state <= LED_122;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_123 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= LED(122);			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '0';
			
			IF (tick='1') THEN
				nx_state <= LED_124;
			ELSE 
				nx_state <= LED_123;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_124 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= LED(123);		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '0';
			
			IF (tick='1') THEN
				nx_state <= LED_125;
			ELSE 
				nx_state <= LED_124;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_125 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= LED(124);
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '0';
			
			IF (tick='1') THEN
				nx_state <= LED_126;
			ELSE 
				nx_state <= LED_125;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_126 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= LED(125);
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '0';
			
			IF (tick='1') THEN
				nx_state <= LED_127;
			ELSE 
				nx_state <= LED_126;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_127 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	 PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= LED(126);
			PIN_26 <= '0';		    PIN_32 <= '0';	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '0';
			
			IF (tick='1') THEN
				nx_state <= LED_128;
			ELSE 
				nx_state <= LED_127;
			END IF;
	------------------------------------------------------------------------------
		WHEN LED_128 =>
		-- Columns Assignment ----------
			PIN_13 <= '0';	 PIN_6 <= '0';
			PIN_3 <= '0';			 PIN_11 <= '0';
			PIN_4 <= '0';			 PIN_15 <= '0';
			PIN_10 <= '0';		    PIN_16 <= '0';	
		-- Rows Assignment ----------
			PIN_9 <= '1';			 PIN_1 <= '1';
			PIN_14 <= '1';		    PIN_7 <= '1';
			PIN_8 <= '1';			 PIN_2 <= '1';
			PIN_12 <= '1';	       PIN_5 <= '1';
			-- Columns_Assignment_Matrix_2----------
			PIN_29 <= '0';	       PIN_22 <= '0';
			PIN_19 <= '0';			 PIN_27 <= '0';
			PIN_20 <= '0';			 PIN_31 <= '0';
			PIN_26 <= '0';		    PIN_32 <= LED(127);	
		-- Rows_Assignment_Matrix_2-------------
			PIN_25 <= '1';			 PIN_17 <= '1';
			PIN_30 <= '1';		    PIN_23 <= '1';
			PIN_24 <= '1';			 PIN_18 <= '1';
			PIN_28 <= '1';	       PIN_21 <= '0';
			
			IF (tick='1') THEN
				nx_state <= stby;
			ELSE 
				nx_state <= LED_128;
			END IF;
		END CASE;
	END PROCESS;
END ARCHITECTURE my_arch;