# Assembly Code Reference

Introduction to assembly language and this repository.

## What is Assembly language?

Every device or computer is managed by a special chip called microprocessor, or processor for short. The processor is the one responsible for computation, the brain of the device. There are many different families of processor. Each offers technology and used for different situation. The one you might often heard are x86 processor (intel/amd) for PC and ARM processor for smartphone. But other than that, there are many families that you might not heard before.

Each family of processor has its own set of instructions for handling various operations. This instruction set is coded as series of binary number which only meaningful for them. It's hard for us to understand the flow of 1's and 0's stream, but it's perfectly fine for processor. Thus we represent each instruction with meaningful english word. The represented word is called `mnemonic` and the set of mnemonics and rules for it is called `assembly`.

In simple term, assembly language is a low-level language designed for specific family of processors that represents various instructions in symbolic code.

## Advantages 

Having an understanding of assembly language gives advantages, not only for reverse engineer but also for developer. To sum it up, gaining knowledge of assembler gives you understanding of:

* how processor accesses and executes instructions;
* how instructions access and process data;
* how data is represented in memory;
* how program interact with OS, processor, and devices.

## Data Size

The processor operates in fixed-size data, represented in the unit of multiple bytes. The size is differ for each processor. You might heard something like `64-bits processor` or `32-bits processor`. This exactly gives you an idea about the size of data that can be operated on each cycle.

In general, we use several terms to refer a chunk of data.
* Byte: 8-bits
* Word: 2-bytes (16-bits)
* Dword: double word, 4-bytes (32-bits)
* Qword: quadruble word, 8-bytes (64-bits)

## Execution Cycle

Although it might be differ for each processor, when a single instruction is executed from memory typically there are several steps happen. The process is called `execution cycle` and can be divided into:

* fetch, fetching the instruction from memory.
* decode, decoding or identifying the instruction.
* execute, executing the instruction.

Processor may access one or more bytes of memory at a time. 