# FPGA-Based Vending Machine Controller

An FPGA-based implementation of a vending machine controller designed and tested on the **Nexys A7 (Artix-7)** development board using **Verilog HDL**.  
The project models a real-world embedded controller using a **finite state machine (FSM)** to handle inputs, manage system state, and control hardware outputs.

---

## Project Overview

This project implements a vending machine controller that:
- Accepts ₹5, ₹10, ₹20, and ₹50 coin inputs
- Supports three products priced at ₹15, ₹25, and ₹45
- Dispenses products based on sufficient balance
- Returns appropriate change
- Indicates out-of-stock conditions using LEDs

The controller is synthesized, simulated, and deployed on a physical FPGA board, demonstrating deterministic and real-time hardware control.

---

## Hardware Platform

- **FPGA Board:** Nexys A7 (Artix-7)
- **Toolchain:** Vivado Design Suite
- **Implementation Language:** Verilog HDL
- **Inputs:** Push buttons / switches (coin insertion, product selection)
- **Outputs:** LEDs (product dispense, change return, out-of-stock)

---

## System Design Approach

The vending machine is designed using a **Finite State Machine (FSM)** approach.  
This ensures predictable behavior, reliable state transitions, and safe handling of edge cases.

### FSM States
- **Idle:** Waiting for coin insertion
- **Coin Insert:** Accumulating inserted amount
- **Selection:** Waiting for product selection
- **Dispense:** Dispensing selected product
- **Change Return:** Returning excess balance
- **Out-of-Stock:** Indicating unavailable product

---


---

## Verification and Testing

- Functional verification performed using a Verilog testbench
- Simulation confirms correct:
  - Product dispensing
  - Change return
  - Stock decrement
  - Out-of-stock indication
- Hardware testing validated on Nexys A7 FPGA board

---

## Key Features

- FSM-based control logic
- Multi-denomination coin handling
- Product stock management
- Change calculation logic
- Real hardware deployment
- Clear visual feedback using LEDs

---

## How to Run

1. Open **Vivado**
2. Create a new RTL project
3. Add Verilog source files from `src/`
4. Add testbench from `testbench/`
5. Add constraints file from `constraints/`
6. Run simulation or generate bitstream
7. Program the FPGA board

---

## Future Enhancements

- LCD display for balance and product information
- Support for additional products
- Dynamic pricing configuration
- Keypad-based user input
- Persistent stock storage

---

## Authors

- **Nithish S**
- **Sheik Parvezh**



