LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY UA_vhdl IS
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

END UA_vhdl;

ARCHITECTURE Behavior OF UA_vhdl IS
	TYPE State_type IS ( S000, S001, S010, S011, S100, S101);
	TYPE br_type IS (B0, B1);
	SIGNAL s : State_type;
	SIGNAL br: br_type;
BEGIN FSM_transitions: PROCESS (Clock, X1, X2, X3, X4 )
		BEGIN
			IF (Clock'EVENT AND Clock = '1') THEN
				CASE s IS
					WHEN S000=>
						IF X3 = '1' THEN
							s <= S001;
							br <= B0;
						ELSE
							s <= S000;
							br <= B0;
						END IF;
					WHEN S001 => 
						s <= S010;
						br <= B0;
					WHEN S010 =>
						s <= S011;
						IF X1 ='0' THEN
							br <= B0;
						ELSE
							br <= B1;
						END IF;
					WHEN S011 =>
						IF X2 ='0' THEN
							s <= S100;
							br <= B0;
						ELSE
							s <= S010;
							br <= B0;
						END IF;
					WHEN S100 =>
						IF X4 ='0' THEN
							s <= S000;
							br <= B1;
						ELSE
							s <= S101;
							br <= B0;
						END IF;
					WHEN S101 =>
						IF X4 ='0' THEN
							s <= S000;
							br <= B1;
						ELSE
							s <= S101;
							br <= B0;							
						END IF;
				END CASE;
			END IF;
	END PROCESS;
	
	
	
	FSM_outputs: PROCESS ( s, br )				
	BEGIN
		Load <= '0'; Add <= '0'; Shift <= '0'; StNorm <= '0'; Normtick <= '0'; Done <= '0';
		CASE s IS
			WHEN S000 =>
				IF br = B0 THEN
					
				ELSE
					Done <= '1';
				END IF;
			WHEN S001 =>
				IF br = B0 THEN
					Load <= '1';
				ELSE
					
				END IF;
			WHEN S010 =>
				IF br = B0 THEN
					Shift <= '1';
				ELSE
					
				END IF;
			WHEN S011 =>
				IF br = B0 THEN
					
				ELSE
					Add <= '1';
				END IF;
			WHEN S100 =>
				IF br = B0 THEN
					StNorm <= '1';
				ELSE
					
				END IF;
			WHEN S101 =>
				IF br = B0 THEN
					Normtick <= '1';
				ELSE
					
				END IF;
		END CASE;
	END PROCESS;

END Behavior;