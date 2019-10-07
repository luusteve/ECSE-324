			.text
			.global _start
_start:
			LDR R4, =MAX				//R4 points to the Max location
			LDR R5,	=MIN				//R5 points to the Min location
			LDR R2,	[R4, #12]			//R2 holds the number of elements in the list
			ADD R3,	R4,	#16				//R3 points to the first number
			LDR R0,	[R3]				//R0 holds the first number in the list, for biggest number
			LDR R6, [R3]				//R6 holds the first number in the list, for smallest number

LOOP:		SUBS R2, R2, #1				//decrement loop counter
			BEQ DONE					//end loop if counter has reached 0
			ADD R3, R3, #4				//R3 points to next number in the list
			LDR R1, [R3]				//R1 holds the next number in the list
			CMP R1, R0					//Compares R0 with R1
			BGE	MAXI					//if R0 is bigger than R1, go to MAXI
			CMP	R1,	R6					//Compares R6 with R1
			BLE MINI					//if R6 is smaller than R1, go to MINI
			B LOOP

MINI:		MOV R6, R1
			B LOOP
MAXI:		MOV R0, R1
			B LOOP

DONE:		STR R0, [R4]
			STR R6,	[R5]
			LDR R7, =RESULT 
			SUB R7, R0, R6
			
END: 		B END

MAX:    	.word 	0
MIN:		.word	0
RESULT:		.word	0
N:			.word	7
NUMBERS:	.word	4, 5, 3, 6
			.word	1, 8, 2
