; Listing generated by Microsoft (R) Optimizing Compiler Version 19.10.25019.0 

include listing.inc

INCLUDELIB LIBCMT
INCLUDELIB OLDNAMES

PUBLIC	f
PUBLIC	__real@40400000
EXTRN	_fltused:DWORD
pdata	SEGMENT
$pdata$f DD	imagerel $LN3
	DD	imagerel $LN3+35
	DD	imagerel $unwind$f
pdata	ENDS
;	COMDAT __real@40400000
CONST	SEGMENT
__real@40400000 DD 040400000r			; 3
CONST	ENDS
xdata	SEGMENT
$unwind$f DD	010401H
	DD	02204H
xdata	ENDS
; Function compile flags: /Odtp
_TEXT	SEGMENT
c$ = 0
i$ = 4
f$ = 8
f	PROC
; File e:\repo\myrepo\xathrya\assemblycode-reference\mapping\x86\c\src\003.function-vars.c
; Line 9
$LN3:
	sub	rsp, 24
; Line 10
	mov	BYTE PTR c$[rsp], 1
; Line 11
	mov	DWORD PTR i$[rsp], 2
; Line 12
	movss	xmm0, DWORD PTR __real@40400000
	movss	DWORD PTR f$[rsp], xmm0
; Line 13
	add	rsp, 24
	ret	0
f	ENDP
_TEXT	ENDS
END