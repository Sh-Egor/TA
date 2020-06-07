LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY UA_mult IS
	PORT (Clock	:	IN	STD_LOGIC ;
		  X1	:	IN	STD_LOGIC ;
		  X2	:	IN	STD_LOGIC ;
		  X3	:	IN	STD_LOGIC ;
		  X4    :   IN	STD_LOGIC ;
		  Load	:	OUT	STD_LOGIC ;
		  Shift	:	OUT	STD_LOGIC ;
		  Add	:	OUT	STD_LOGIC ;
		  StartNorm	:	OUT	STD_LOGIC ;
		  Normtakt	:	OUT	STD_LOGIC ;
		  Done	:	OUT	STD_LOGIC );

END UA_mult;

ARCHITECTURE Behavior OF UA_mult IS
	TYPE State_type IS ( S000, S001, S010, S011, S100, S101, S110);
	SIGNAL s : State_type;
BEGIN FSM_transitions: PROCESS (Clock, X1, X2, X3, X4)
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
						IF X1 = '1' THEN
							s <= S010;
						ELSE
							s <= S011;
						END IF;
					WHEN S010 =>
						s <= S100;
					WHEN S011 =>
						s <= S100;
					WHEN S100 =>
						IF X2 = '1' THEN
							IF X1 = '1' THEN
								s <= S010;
							ELSE
								s <= S011;
							END IF;
						ELSE
							s <= S101;
						END IF;
					WHEN S101 =>
						IF X4 = '1' THEN
							s <= S110;
						ELSE
							s <= S000;
						END IF;
					WHEN S110 =>
						IF X4 = '1' THEN
							s <= S110;
						ELSE
							s <= S000;
						END IF;
				END CASE;
			END IF;
	END PROCESS;
	
	
	
	FSM_outputs: PROCESS ( s)				
	BEGIN
		Load <= '0'; Add <= '0'; Shift <= '0'; StartNorm <= '0'; Normtakt <= '0'; Done <= '0';
		CASE s IS
			WHEN S000 =>
				Done <= '1';
			WHEN S001 =>
				Load <= '1';
			WHEN S010 =>
				Add <= '1';
			WHEN S011 =>
				Add <= '0';
			WHEN S100 =>
				Shift <= '1';
			WHEN S101 =>
				StartNorm <= '1';
			WHEN S110 =>
				Normtakt <= '1';
		END CASE;
	END PROCESS;

END Behavior;