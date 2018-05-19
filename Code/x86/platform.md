# Platform Specific Information

## Data Size

The terms used to refer size of data supported by processors
* Byte: 8-bit 
* Word: 2-bytes, 16-bits
* Dword: double word, 4-bytes, 32-bits
* Qword: quadruble word, 8-bytes, 64-bits

## Registers

A register is a quickly accessible location available to a processor. It is special storage used for several activities such as computation or tracking the execution of instruction.

* General purposes (32-bits)
    - Data Registers
        - EAX: Accumulator
        - EBX: Base / Address
        - ECX: Count
        - EDX: Data
    - Pointer Registers
        - ESP: Stack Pointer
        - EBP: Base Pointer
    - Index Registers
        - ESI: Source Index
        - EDI: Destination Index

    As for x86-64, we have additional registers: R8 to R15
* Status / Control Registers
    - Segment Registers (limited access)
        - CS: Code
        - DS: Data
        - SS: Stack
        - ES: Extra
        - FS: Extra
        - GS: Extra
    - Control Registers (limited access): CR0 to CR4
    - Debug Registers (limited access): DR0 to DR3
    - Other Registers (no direct access)
        - EIP: Instruction pointer
        - EFLAGS: Flags
* XMM Registers: XMM0 to XMM15

The x86 architecture has several registers that is divided into categories. A general purpose registers are a set of registers that can be used for storing anything for any purpose. But actually each of them has its own orignal purpose / function, but not strictly enforced. It can be broken down into three registers: the data registers, pointer registers, and index registers.

A 32-bit registers have prefix E, such as EAX. While 64-bits registers have prefix R, such as RAX. For some registers (EAX, EBX, ECX, EDX) we can access the lower half registers by eliminating the prefix. Thus,

- EAX (32-bit) -> AX (16-bit)
- EBX (32-bit) -> BX (16-bit)
- ECX (32-bit) -> CX (16-bit)
- EDX (32-bit) -> DX (16-bit)
    
Furthermore, we can also access the higher half or lower half of AX/BX/CX/DX by changing the X to H (Higher half) or L (Lower half). Thus, 

- AX (16-bit) = AH (8-bit) + AL (8-bit)
- BX (16-bit) = BH (8-bit) + BL (8-bit)
- CX (16-bit) = CH (8-bit) + CL (8-bit)
- DX (16-bit) = DH (8-bit) + DL (8-bit)

To sum it up, the register can be seen as something like this.

```
RAX                  EAX        AX
--------------------------------------------
|                     |          | AH | AL |
--------------------------------------------
64                   32         16    8    0
```

As for x86-64, we have additional registers R8 to R15. The R0 to R7 is a canonical name to existing registers

- R0 = RAX
- R1 = RCX
- R2 = RDX
- R3 = RBX
- R4 = RSP
- R5 = RBP
- R6 = RSI
- R7 = RDI

We can treat the lowest 32-bits of each registers as register itself by appending suffix D. The lower half of it can be access by suffix W. And the more of it is accessible by suffix B. This one can be an example:

```
R8                   R8D        R8W  R8B
--------------------------------------------
|                     |          |    |    |
--------------------------------------------
64                   32         16    8    0
```

Segment registers are set of register used for accessing memory segment. The segment itself is a region of memory, usually the size is multiple of page, that has certain functions.

Control registers are set of registers that changes or controls the general behavior of processor (core). Each control registers have specific purpose.

Debug registers are set of registers used by processor for hardware debugging. Actually there are six debug registers: DR0, DR1, DR2, DR3, DR4/DR6, DR5/DR7. The DR4 and DR5 are obsolete synonyms for DR6 and DR7. These registers allow programmers to selectively enable various debug conditions associated with a set of four debug addresses.

Another important register is EIP. EIP (or RIP for 64-bits) is an Instruction Pointer register. This register is used to point the current instruction that will be executed by processor.

The last one is EFLAGS. This register is a flag register. Many instructions involve comparisons and mathematical calculations and change the status of the flags. Some other conditional instructions test the value of these flags to take the control flow to other location. The common flags bits are:

    Flag:                              O    D    I    T    S    Z         A         P         C
                ---------------------------------------------------------------------------------
    Bit Flag    | 15 | 14 | 13 | 12 | 11 | 10 |  9 |  8 |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
                ---------------------------------------------------------------------------------

* Overflow Flag (O)
* Direction Flag (D)
* Interrupt Flag (I)
* Trap Flag (T)
* Sign Flag (S)
* Zero Flag (Z)
* Auxiliary Carry Flag (A)
* Parity Flag (P)
* Carry Flag (C)

#### MMX

Supplemental instruction set. Most of the instructions are SIMD (Single Instruction Multiple Data), meaning that single instruction work with multiple pieces of data in parallel.

There are 8 64-bits MMX registers, from MM0 to MM7. They were made overlap with the FPU register. This means the MMX instructions and FPU instructions cannot be used simultaneously.

The registers are 64-bits wide but can be broken down as follows:

* 2x 32-bit value
* 4x 16-bit value
* 8x  8-bit value

#### SSE (Streaming SIMD Extensions)

The SSE registers are register for floating point operations. The size of register is 128-bits. It also can be used to perform operations on a variety of data sizes and types. 

There are 8 128-bits SSE registers, from XMM0 to XMM7. Unlike MMX, the SSE registers do not overlap with the floating point stack.

The registers are 128-bits wide but can be broken down as follows:

* 2x  64-bit floating points (double-precision)
* 2x  64-bit integers
* 4x  32-bit floating points (single-precision)
* 4x  32-bit integers
* 8x  16-bit integers
* 16x  8-bit characters (bytes)

## Opcodes (Operation Codes)

