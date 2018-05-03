; HelloWorld.asm
; 
; Write "Hello, World!" on one line and then exits.
; This code is depend on libc (C library) of compiler
; so we will need extra thing for linking
;
; Compile:
;	$ nasm -felf64 -o hello-64b.o hello-64b.asm
;
; Linking:
;	(gcc and libc)
;   $ gcc -o hello-64b hello-64b.o
;
;-----------------------------------------------------

	global main
	extern printf

section .data
	message: db 'Hello, World!', 10, 0

section .text
main:
	; push message
	mov  	rdi, message
	call 	printf
	add esp, 8
	ret
	
