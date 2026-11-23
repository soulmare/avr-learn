# Learn AVR Assembly using VSCode

This project contains small AVR assembly exercises. The examples below use an
ATmega328P running at 16 MHz.

The exercises and chapter names are based on *The AVR Microcontroller and Embedded Systems: Using Assembly and C* by Muhammad Ali Mazidi, Sarmad Naimi, and Sepehr Naimi.

The book uses the Atmel/Microchip AVR assembler dialect, while this project
builds with GNU AVR assembler through `avr-gcc`. Some syntax differs between
the dialects.
The exercises in this repository are adapted to the GNU toolchain.

The book targets the ATmega32; this project targets the ATmega328P. Their
memory maps differ (`RAMEND` is `0x085F` vs. `0x08FF`), so use `<avr/io.h>`
instead of `M32DEF.INC`.

The project includes VS Code tasks and a debugger configuration that preserve
the command-line workflow while allowing you to build and debug from the VS
Code interface. Install these extensions for the complete experience:

- **C/C++** (`ms-vscode.cpptools`) — required for the `cppdbg` debugger
  configuration.
- **AVR Support** (`rockcat.avr-support`) — provides AVR assembly language
  support and syntax highlighting.
- **Memory Inspector** (`eclipse-cdt.memory-inspector`) — provides the memory
  viewer while debugging.

### Open the project

Open the project folder.

Open the assembly file you want to work on, for example:

```text
chapter-03/exercise-01.asm
```

The build and debug configurations use the currently active `.asm` file and
the matching `.elf` file.

### Build in VS Code

Press `Ctrl+Shift+B` and run:

```text
AVR: Build active asm file
```

This runs the same `avr-gcc` command described in the command-line workflow.
The resulting ELF file is written beside the active assembly file.

### Inspect the listing

The ELF file contains the assembled program and debug information. Use
`avr-objdump` to view the disassembly together with the original source:

```sh
avr-objdump -d -S chapter-04/exercise-09.stack-portb-toggle-delay.elf
```

### Start debugging in VS Code

Press `F5` and choose:

```text
AVR: Debug active asm file
```

VS Code will build the active file, start `simavr` as a GDB server, connect
with `avr-gdb`, and stop at the program entry point.

### Inspect registers and memory

Add these expressions to the **Watch** section of the Run and Debug panel to
keep them visible whenever execution pauses:

```text
$r20
$r21
$pc
$sp
$sreg
```

### End a VS Code session

Use the **Stop** button in the Debug toolbar. This stops the debugger and the
simulator task. Rebuild after changing the assembly source before starting a
new debugging session.

## Troubleshooting

### Build task says “No instance is currently running”

In some VS Code versions, `Ctrl+Shift+B` can fail before starting the build
task and show “No instance is currently running”. This is a VS Code task-system
issue; it does not indicate a problem with the AVR build itself.

Reload the VS Code window with `Ctrl+Shift+P` → `Developer: Reload Window`, then
run the build task again. If the problem persists, use
`Ctrl+Shift+P` → `Tasks: Run Build Task`, or build directly in a terminal.

## Command-line workflow

The command-line workflow is documented separately in
[README-CMDLINE.md](README-CMDLINE.md).
