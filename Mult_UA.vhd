LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY Mult_UA IS
	PORT (Clock	:	IN	STD_LOGIC ;
		  X1	:	IN	STD_LOGIC ;
		  X2	:	IN	STD_LOGIC ;
		  X2	:	IN	STD_LOGIC ;
		  X3    :   IN	STD_LOGIC ;
		  Load	:	OUT	STD_LOGIC ;
		  Shift	:	OUT	STD_LOGIC ;
		  Add	:	OUT	STD_LOGIC ;
		  StNorm	:	OUT	STD_LOGIC ;
		  Normtick	:	OUT	STD_LOGIC ;
		  Done	:	OUT	STD_LOGIC );

END Mult_UA ;

ARCHITECTURE Behavior OF Mult_UA IS
	TYPE State_type IS ( S000, S001, S010, S011, S100, S101);
	SIGNAL s : State_type;
	SIGNAL br: State_type;
BEGIN FSM_transitions: PROCESS (Clock, X1, X2, X3, X4 )
		BEGIN
			IF (Clock'EVENT AND Clock = '1') THEN
				CASE s IS
					WHEN S000=>
						IF X3 = '1' THEN
							s <= S001;
							br <= '0';
						ELSE
							s <= S000;
							br <= '0';
						END IF;
					WHEN S001 => 
						s <= S010;
						br <= '0';
					WHEN S010 =>
						s <= S011;
						IF X1 ='0' THEN
							br <= '0';
						ELSE
							br <= '1';
						END IF;
					WHEN S011 =>
						IF X2 ='0' THEN
							s <= S100;
							br <= '0';
						ELSE
							s <= S010;
							br <= '0';
						END IF;
					WHEN S100 =>
						IF X4 ='0' THEN
							s <= S000;
							br <= 1;
						ELSE
							s <= S101;
							br <= '0';
						END IF;
					WHEN S101 =>
						IF X4 ='0' THEN
							s <= S000;
							br <= 1;
						ELSE
							s <= S101;
							br <= '0';							
						END IF;
				END CASE;
			END IF;
	END PROCESS;
	
	
	
	FSM_outputs: PROCESS ( s, br )				
	BEGIN
		Load <= '0'; Add <= '0'; Shift <= '0'; StNorm <= '0'; Normtick <= '0'; Done <= '0';
		CASE s IS
			WHEN S000 =>
				IF br = '0' THEN
					
				ELSE
					Done <= '1';
				END IF;
			WHEN S001 =>
				IF br = '0' THEN
					Load = '1';
				ELSE
					
				END IF;
			WHEN S010 =>
				IF br = '0' THEN
					Shift <= '1';
				ELSE
					
				END IF;
			WHEN S011 =>
				IF br = '0' THEN
					
				ELSE
					Add <= '1';
				END IF;
			WHEN S100 =>
				IF br = '0' THEN
					StNorm <= '1';
				ELSE
					
				END IF;
			WHEN S101 =>
				IF br = '0' THEN
					Normtick <= '1';
				ELSE
					
				END IF;
		END CASE;
	END PROCESS;

END Behavior;