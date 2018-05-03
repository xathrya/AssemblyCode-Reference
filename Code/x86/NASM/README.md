# NASM Codes Repository
---

While we are trying to make the codes os-agnostic, we realize that at some point it is necessary to demonstrate the specific code. For this purpose, we divide the code to directories corresponding to their OS. The common code can be found on `src` directory.

## How to install NASM?

Go to [nasm site](http://nasm.us) and follow the instruction for downloading or building nasm.

## About linker

NASM is just an assembler. It converts the source code in assembly to object code. Therefore, we need another tool called linker to link and produce the executable binary.

## Commands

If nothing specified, these following commands are used:

Compile:
    (nasm-linux)
    $ nasm -f elf32 -o code.o code.asm

    (nasm-win32)
    $ nasm -f win32 -o code.obj code.asm

Linking:
    (gcc)
    $ gcc -m32 -o code code.o

## Test Machine

The following machine are used for testing and verified the codes:
- Windows 10 x64
- Debian 9 x64

If you have different machine and have different result, please gives information.

## Resources

NASM is awesome assembler. If you need details and something that are not covered in this repository, you should consult:
- [NASM Manual](http://www.nasm.us/doc/) or this [file](nasmdoc-2.10rc4.pdf)
- [Intel Processor Manuals](http://www.intel.com/content/www/us/en/processors/architectures-software-developer-manuals.html)