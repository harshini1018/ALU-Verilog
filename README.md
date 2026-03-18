# 4-bit ALU in Verilog

## Features
- Arithmetic: Add, Subtract
- Logic: AND, OR, XOR, NOT
- Shift operations
- Flags: Carry, Zero, Overflow

## Tools Used
- Icarus Verilog
- GTKWave

## Verification
- Testbench with multiple cases
- Waveform analysis

## How to Run
1. Compile: iverilog -o alu.out alu_4bit.v alu_tb.v
2. Run: vvp alu.out
3. View waveform: gtkwave wave.vcd
