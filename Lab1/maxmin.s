			.text
			.global _start

_start:		LDR R5, =MIN				//R5 points to the Min X location
			ADD R1, R5, #16				//First element of array First pointer
			MOV R3, R1
			LDR R6, [R5, #4]			//R6 gets N
			LDR R7, [R5, #8]			//R6 gets M
			LDR R8, [R5, #12]			//R7 to get size list
			MOV R0, #0					//initializes value of R10 and R11
			MOV R9, #0					//R9 is 0, also going to be SUM

SUM:		LDR R2, [R1]				//R2 holds the the value of R1, an element in the list
			ADD R9, R9, R2				//R9 is equal to the total sum of the list
			ADD R1, R1, #4				//R1 points to the next element in the list
			SUBS R8, R8,#1				//Decrement by 1
			BEQ RESET_LIST				//Continue until all elements have been added
			B SUM

RESET_LIST:	LDR R8, [R5, #12]			//R7 to get size list
			ADD R1, R5, #12				//First element before the list
			CMP R6, R7					//If n and m are equal to each other
			BEQ TWO
			B NEXT

TWO:		SUBS R8, R8, #1				// ONLY 3 combination if n = m  in an array length of 4
			ADD R1, R1, #4				//Points at the first element of the list
			B RESET

NEXT:		LDR R6, [R5, #4]			//R6 gets N
			LDR R7, [R5, #8]			//R6 gets M
			CMP R6, R7					// if N and m = 2 continue normally
			BEQ RESET
			ADD R1, R1, #4				//Points to element in list
			B RESET

RESET:		CMP R8, #0					//Stop when all posible combinations have been tried
			BEQ END
			LDR R4, [R1]				//R4 takes the value of first pointer 
//if n and m are not equal to each other
			CMP R6, R7					
			BLE ADDITION
			MOV R12, R6					//Assign R12 to be temporary holder for R6
			MOV R6, R7					// Assign N to be the smaller of the two
			MOV R7, R12`				// Assign M to be the bigger of the two
			B ADDITION	

ADDITION:   SUBS R6, R6, #1				//Continues depending on N
			BEQ COMPARE				
			ADD R3, R3, #4				//points to the next element
			LDR R2, [R3]				//holds the value of R3
			ADD R4, R2, R4				//R4 adds itself, the value of R1, and the value of R3
			B ADDITION
			
COMPARE:	MOV R2, R4					//R2 takes value of R4 = X
			SUB R4, R9, R2				//R4 is now S-X
			MUL R2, R2, R4				//R2 = X*(S-X)
			CMP R0, #0					//Initializes comparison, only done once
			BEQ INIT				
			CMP R2, R10					//if R2 is bigger than R10, swap R10
			BGE MAXI
			CMP R2, R11					//if R2 is smaller than R11, swap R11
			BLE MINI
			SUBS R8, R8, #1
			B NEXT

INIT: 		MOV R10, R2					//R10 holds value of R2
			MOV R11, R2					//R11 holds value of R2
			MOV R0, #1					//Change R0 to #1, since this operation only runs once
			SUBS R8, R8, #1				//Decrement, since this combination has been explored
			B NEXT

MAXI:		MOV R10, R2					//R10 takes value of R2, since it is smaller than R2
			SUBS R8, R8, #1				//Decrement, since this combination has been explored
			B NEXT
			
MINI:		MOV R11, R2					//R11 takes value of R2, since it is bigger than R2
			SUBS R8, R8, #1				//Decrement, since this combination has been explored
			B NEXT

END: 		STR R10, [R4]				//Store the biggest value in R4
			STR R11, [R5]				//Store smallest value in R5
			B END

MAX:    	.word 	0
MIN:		.word	0
N:			.word	3
M:			.word 	1
SIZE:		.word	4
NUMBERS:	.word	1, 2, 3, 4

