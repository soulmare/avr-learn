# Project instructions

## Purpose

This repository contains small AVR assembly exercises based on *The AVR
Microcontroller and Embedded Systems: Using Assembly and C*. The book uses the
Atmel/Microchip assembler dialect, while this project builds source files with
GNU `avr-gcc` and GNU AVR assembler.

## Target environment

- Microcontroller: ATmega328P
- Clock: 16 MHz
- Source language: AVR assembly preprocessed by the C preprocessor
- Build input type: `assembler-with-cpp`
- Programs start at the reset-vector address, `0x0000`

## Adapting book examples

When adding or adapting an example from the book:

1. Replace device-specific book includes such as `.INCLUDE "M32DEF.INC"` with:

   ```asm
   #include <avr/io.h>
   ```

2. Preserve the book's original explanatory comments. Keep comments describing
   the purpose of each instruction, branch, delay step, and subroutine. Add or
   adjust comments only when needed to explain a GNU assembler or
   ATmega328P-specific change.

   When a copied example has comments broken onto separate lines even though
   they belong to the preceding instruction, restore them as inline comments
   on that instruction. Keep standalone section or subroutine comments on
   separate lines.

3. Do not add behavioral, initialization, or hardware-configuration code that
   is absent from the book example unless the user explicitly requests it.
   Adapt syntax and identifiers as required for the current toolchain, but
   preserve the example's original instruction sequence, behavior, and valid
   assembler directives. Do not omit explicit directives such as `.ORG 0` or a
   book-specified routine address merely because the toolchain would imply the
   same result.

4. Use the ATmega328P register names supplied by `<avr/io.h>`. For registers
   used by `IN` or `OUT`, use the GNU-compatible address form:

   ```asm
   OUT _SFR_IO_ADDR(PORTB), r16
   ```

5. Replace book-style `HIGH(...)` and `LOW(...)` expressions with GNU forms
   such as `hi8(...)` and `lo8(...)` when initializing multi-byte addresses:

   ```asm
   LDI r16, hi8(RAMEND)
   OUT _SFR_IO_ADDR(SPH), r16
   LDI r16, lo8(RAMEND)
   OUT _SFR_IO_ADDR(SPL), r16
   ```

6. Initialize the stack pointer before using `CALL`, `RCALL`, `PUSH`, `POP`, or
   `RET`. There is no C runtime startup code because exercises are linked with
   `-nostdlib`.

7. Preserve the book's control flow, but use GNU assembler syntax and the
   existing repository conventions: four-space indentation, uppercase
   instruction mnemonics, lowercase register names, descriptive labels, and a
   `stop` infinite loop at the end of the source. A program that deliberately
   loops forever during normal operation may still keep `BACK` or another loop
   label for that active loop, followed by the standard `stop` terminator after
   subroutines.

8. Keep delay routines as ordinary labels in the text section unless the
   example specifically demonstrates placement at another address. If the
   book example places a routine at a fixed address, `.ORG` may be retained and
   should be verified by inspecting the disassembly.

## File naming

Place each exercise in its corresponding `chapter-NN/` directory using this
pattern:

```text
exercise-NN.short-description.asm
```

Use a short description that reflects the main concept, such as
`exercise-08.stack-push-pop.asm` or
`exercise-09.stack-portb-toggle-delay.asm`.

## Documentation

When the user refers to the README without naming a specific file, update the
main `README.md`. Edit `README-CMDLINE.md` only when the user explicitly asks
for the command-line README or that specific file.

## Build and verification

Build an exercise from the project root with:

```sh
avr-gcc -mmcu=atmega328p -x assembler-with-cpp -nostdlib -g \
  -o /tmp/exercise.elf chapter-NN/exercise-NN.short-description.asm
```

Use a temporary or ignored output path so generated ELF files do not become
source changes. For non-trivial changes, inspect the result with:

```sh
avr-objdump -d /tmp/exercise.elf
```

Confirm that calls, branches, I/O addresses, and fixed `.ORG` locations match
the intended exercise.
