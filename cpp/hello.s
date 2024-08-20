	.global _start

_start:
	LDR R1, =string		@ Load address of string label into R1
	MOV R3, #0x0		@ start offset count = 0

	@ Reference ASCII Table for Hex values

	MOV R0, #0x48		@ Put ascii 'H' in R0
	BL _storeByte
	MOV R0, #0x65		@ Put ascii 'e' in R0
	BL _storeByte
	MOV R0, #0x6C		@ Put ascii 'l' in R0
	BL _storeByte
	MOV R0, #0x6C		@ Put ascii 'l' in R0
	BL _storeByte
	MOV R0, #0x6F		@ Put ascii 'o' in R0
	BL _storeByte

	MOV R0, #0x20		@ Put ascii ' ' in R0
	BL _storeByte

	MOV R0, #0x57		@ Put ascii 'W' in R0
	BL _storeByte
	MOV R0, #0x6F		@ Put ascii 'o' in R0
	BL _storeByte
	MOV R0, #0x72		@ Put ascii 'r' in R0
	BL _storeByte
	MOV R0, #0x6C		@ Put ascii 'l' in R0
	BL _storeByte
	MOV R0, #0x64		@ Put ascii 'd' in R0
	BL _storeByte
	MOV R0, #0x21		@ Put ascii '!' in R0
	BL _storeByte

	MOV R0, #0xA		@ Put ascii '\n' (newline) in R0
	BL _storeByte

	BL _print			@ print out finished phrase
	B _exit

_storeByte:
	STRB R0, [R1, + R3]	@ store Byte R0 out to R1 + offset (R3)
	ADD R3, R3, #1		@ increment offset count

	MOV PC, LR			@ return from _storeByte

_print:
	MOV R7, #4			@ setup up registers for syscall print
	MOV R0, #1			@ use standard output (1) i.e. the screen
	MOV R2, #13			@ size of item to print is 13 bytes
	LDR R1, =string		@ load address of item to print
	SWI 0				@ execute syscall print

	MOV PC, LR			@ return from _print

_exit:
	MOV R7, #1			@ setup registers for syscall exit
	SWI 0				@ execute syscall exit


.data					@ assembler directive used for data section of assembly program

string:					@ label called string which has been given 13 bytes of space
.space 13				@ in memory to store our text
