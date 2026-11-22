# AVR command-line workflow

The following sections describe the original workflow using raw AVR tools.

## Build an exercise

From the project root, compile an assembly source file with debug information:

```sh
avr-gcc -mmcu=atmega328p -x assembler -nostdlib -g \
  -o chapter-03/exercise-01.elf \
  chapter-03/exercise-01.asm
```

The important options are:

- `-mmcu=atmega328p` selects the target AVR device.
- `-x assembler` treats the input as assembly source.
- `-nostdlib` avoids linking the standard libraries.
- `-g` includes source-level debug information.
- With no startup library or explicit entry option, the first instruction is
  placed at address `0`, the AVR reset-vector address.

## Run the simulator

In a second terminal, start `simavr` in GDB-server mode:

```sh
simavr -g -m atmega328p -f 16000000 chapter-03/exercise-01.elf
```

The `-g` option makes simavr wait for a GDB client, normally on
`localhost:1234`. Leave this terminal running while debugging.

## Connect with GDB

In a third terminal, open the ELF file in AVR-GDB:

```sh
avr-gdb chapter-03/exercise-01.elf
```

Connect GDB to the simulator and stop at the program entry point:

```gdb
target remote localhost:1234
break *0
continue
```

You can also set a breakpoint on a label:

```gdb
break stop
```

## Stepping and execution

```gdb
stepi                 # execute one instruction
nexti                 # step over the current instruction
continue              # run until the next breakpoint
info breakpoints      # list breakpoints
delete                # delete all breakpoints
disassemble 0,stop
```

For the current source location and instruction:

```gdb
where                 # show the current location
x/i $pc               # examine the instruction at the program counter
```

## View registers

```gdb
info registers        # show all registers known to GDB
p/x $r20              # print one register in hexadecimal
p/d $r20              # print one register in decimal
p/x $pc               # program counter
p/x $sp               # stack pointer
p/x $sreg             # status register
```

After the `add r20, r21` instruction in the example, inspect the result with:

```gdb
p/x $r20
p/x $r21
```

## View memory

GDB's `x` command examines memory. Its format is `x/<count><format><size>`.

```gdb
x/16bx 0x800100     # 16 SRAM bytes, hexadecimal
x/8hx  0x800100     # 8 SRAM halfwords, hexadecimal
x/16ub 0x800100     # 16 SRAM bytes, decimal
```

The example stores `r20` at data-memory address `0x0100`, so this is useful for
checking the value written by `sts`. AVR-GDB represents SRAM using a virtual
`0x800000` offset, so AVR data-memory address `0x0100` is examined as
`0x800100`:

```gdb
break stop
continue
x/1bx 0x800100
```

Depending on the AVR-GDB version and memory space being inspected, you can also
use the AVR-specific commands or prefixes supported by that build. The ELF's
disassembly and register values are generally the most portable way to verify
execution.

## Ending a debugging session

Exit GDB with:

```gdb
quit
```

Then stop simavr with `Ctrl-C` in its terminal. Rebuild the ELF after changing
the assembly source before starting a new simulation.
