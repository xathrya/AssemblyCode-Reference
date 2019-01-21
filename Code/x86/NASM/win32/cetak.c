/**
 * hello-extern.c
 * 
 * Call external function cetak() and then exits.
 * The function will write "Hello, World!".
 *
 * Compile:
 *	$ gcc -c -o cetak.o cetak.c
 * 
 */
#include <stdio.h>

extern int cetak();

int cetak()
{
    printf("Hello, World\n");
    return 0;
}