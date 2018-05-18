; segment.asm
;
; Learn the memory segmentation.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o segment.o segment.asm
;
;   (win32)
;   $ nasm -f win32 -o segment.o segment.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o segment segment.o
;
;   (windows)
;   $ ld -m i386pe -o segment segment.o
;
; This code snippet is for examples to topics
; and should not be run as an executable.
; 
;---------------------------------------------------

;---------------------------------------------------
; A segmented memory model divides the system memory into 
; groups of independent segments referenced by pointers 
; located in the segment registers.
; Each segment is used to contain a specific type of data.
; Either data, code, or stack.
; When thing goes out of segment boundary, you will get 
; the infamous message "segmentation fault"
;
; Segment is closely related but not same as section.
; A section will indicate section of data in object file or
; executable format. It will be a hint for OS to load
; correct thing to the correct place. While the segment is
; a runtime memory area that is reserved for a purpose.
;
; Segmentation can be implemented with/without paging. 
; 
; We can specify the various memory segments.
;---------------------------------------------------

    global _start

; Data segment
; Represented by .data section and the .bss section.
; See more declaration example on `declaration`
section .data
    immutable_data: db 10
section .bss 
    mutable_data: resb 1

; Code segment
; Represented commonly by .text section.
section .text
_start:
    hlt         ; Halt the execution

; Stack segment
; Not represent by any section
; Created by OS
; Can be accessed by SS:offset
; Contains values passed to functions and procedures
; within the program