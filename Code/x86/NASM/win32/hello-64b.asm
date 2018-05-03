; HelloWorld.asm
; 
; Write "Hello, World!" on one line and then exits. 
; This code is depend on libc (C library) of compiler so we will n
; eed extra thing for linking.
;
; Compile:
;	$ nasm -fwin64 -o hello-64b.obj hello-64b.asm
;
; Linking:
;	(gcc and libc)
;   $ gcc -o hello-64b.exe hello-64b.obj
;
; PS: the segmentation fault at the end of execution is because
;	we don't use CRT, so after returning from main(), the processor
;   will attempt to execute instruction at address 0x0
;
;-----------------------------------------------------

	global main
	extern printf

section .data
	message: db 'Hello, World!', 13, 10, 0	

section .text
main:
	mov 	rcx, qword message 
	call 	printf
	ret
	
