; Hello-32b.asm
; 
; Write "Hello, World!" on one line and then exits.
; This code is depend on libc (C library) of compiler
; so we will need extra thing for linking
;
; Compile:
;	$ nasm -felf32 -o hello-32b.o hello-32b.asm
;
; Linking:
;	(gcc and libc)
;   $ gcc -m32 -o hello-32b hello-32b.o
;
;-----------------------------------------------------

	global main
	extern printf

section .data
	message: db 'Hello, World!', 10, 0	

section .text
main:
	push 	message
	call 	printf
	add esp, 4

	mov 	eax, 0
	
	ret
	
