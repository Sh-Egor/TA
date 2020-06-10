LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY gen_vhdl IS
	PORT (Clock	:	IN	STD_LOGIC ;
		  X1	:	IN	STD_LOGIC ;
		  X2	:	IN	STD_LOGIC ;
		  X3	:	IN	STD_LOGIC ;
		  X4    :   IN	STD_LOGIC ;
		  Load	:	OUT	STD_LOGIC ;
		  Shift	:	OUT	STD_LOGIC ;
		  Add	:	OUT	STD_LOGIC ;
		  StNorm	:	OUT	STD_LOGIC ;
		  Normtick	:	OUT	STD_LOGIC ;
		  Done	:	OUT	STD_LOGIC );

END gen_vhdl ;

ARCHITECTURE Behavior OF gen_vhdl IS
	TYPE State_type IS ( S000, S001, S010, S011, S100, S101, S110);
	SIGNAL s : State_type;
BEGIN FSM_transitions: PROCESS (Clock, X1, X2, X3, X4 )
		BEGIN
			IF (Clock'EVENT AND Clock = '1') THEN
				CASE s IS
					WHEN S000=>
						IF X3 = '1' THEN
							s <= S001;
						ELSE
							s <= S000;
						END IF;
					WHEN S001 => 
						s <= S010;
					WHEN S010 =>
						s <= S011;
						IF X1 ='0' THEN
							s <= S100;
						ELSE
							s <= S011;
						END IF;
					WHEN S011 =>
						IF X2 ='0' THEN
							s <= S101;
						ELSE
							s <= S010;
						END IF;
					WHEN S100 =>
						IF X2 ='0' THEN
							s <= S101;
						ELSE
							s <= S010;
						END IF;
					WHEN S101 =>
						IF X4 ='0' THEN
							s <= S000;
						ELSE
							s <= S110;					
						END IF;
					WHEN S110 =>
						IF X4 ='0' THEN
							s <= S000;
						ELSE
							s <= S110;					
						END IF;
				END CASE;
			END IF;
	END PROCESS;



	FSM_outputs: PROCESS ( s )				
	BEGIN
		Load <= '0'; Add <= '0'; Shift <= '0'; StNorm <= '0'; Normtick <= '0'; Done <= '0';
		CASE s IS
			WHEN S000 =>
				Done <= '1';
			WHEN S001 =>
				Load <= '1';
			WHEN S010 =>
				Shift <= '1';
			WHEN S011 =>
				Add <= '1';
			WHEN S100 =>
				Add <= '0';
			WHEN S101 =>
				StNorm <= '1';
			WHEN S110 =>
				Normtick <= '1';
		END CASE;
	END PROCESS;

END Behavior;