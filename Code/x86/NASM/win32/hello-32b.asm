; Hello-32b.asm
; 
; Write "Hello, World!" on one line and then exits.
; This code is depend on libc (C library) of compiler so we will need 
; extra thing for linking
;
; Compile:
;	$ nasm -fwin32 -o hello-32b.obj hello-32b.asm
;
; Linking:
;	(gcc and libc)
;   $ gcc -m32 -o hello-32b.exe hello-32b.obj
;
;-----------------------------------------------------

; GCC in windows version has underscore prefix
	global _main
	extern _printf

section .data
	message: db 'Hello, World!', 10, 0	

section .text
_main:
	push message
	call _printf
	add esp, 4
	ret
	
