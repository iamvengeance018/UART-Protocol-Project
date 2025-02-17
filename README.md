# UART-Protocol-Project
A complete implementation of a UART protocol including design, simulation, and synthesis using Verilog.

## Project Overview

This repository contains the complete implementation of a **Universal Asynchronous Receiver/Transmitter (UART)** protocol. The project includes **design, simulation, implementation, and synthesis** using Verilog. The main objective is to achieve efficient serial communication for VLSI systems.

## Features

- Designed **UART Transmitter (uart\_tx)** module.
- Implemented a **Baud Rate Generator (baud\_rate\_generator)** for accurate timing.
- Simulated and verified state transitions and signal assignments.
- Successfully synthesized and implemented the design without errors.

## Project Structure

```
├── src/                  # Source files for Verilog implementation
│   ├── uart_tx.v         # UART Transmitter module
│   ├── baud_rate_generator.v  # Baud Rate Generator module
│   ├── uart_tb.v  # Testbench for simulation
│
├── simulation/           # Simulation results and waveforms
│   ├── uart_simulation.png
│   ├── baud_rate_waveform.png
│
├── implementation/       # Implementation and synthesis reports
│   ├── synthesis_log.txt
│   ├── implementation_log.txt
│
├── README.md             # Project documentation
```

## Design and Implementation

### UART Transmitter

- The transmitter follows a finite state machine (FSM) to manage data transmission.
- It sends data serially along with **start** and **stop** bits.
- Configured to work with standard baud rates (e.g., 9600, 115200, etc.).

### Baud Rate Generator

- Generates clock enable signals at desired baud rates.
- Ensures precise timing for UART transmission.
- Implemented using a counter-based approach.

## Simulation and Debugging

- Simulated using **ModelSim/Xilinx Vivado** to verify functionality.
- Debugged state transitions and signal assignments.
- Ensured the **clk\_en** signal generation is accurate.

## Synthesis and Implementation

- Synthesized using **Xilinx Vivado** without errors.
- Verified implementation on FPGA hardware.
- Ensured correct data transmission and reception.

## Getting Started

### Prerequisites

- **Xilinx Vivado / ModelSim** (for synthesis and simulation)
- **Verilog/SystemVerilog knowledge**

### Steps to Run Simulation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/UART-Protocol-Project.git
   ```
2. Open ModelSim or Vivado.
3. Add Verilog files from the `src/` directory.
4. Run the simulation testbench `uart_tb.v`.
5. Observe waveforms to verify the output.

### Steps to Implement on FPGA

1. Synthesize the design in **Vivado**.
2. Generate the bitstream and program the FPGA board.
3. Use a terminal tool to send and receive serial data.

## Acknowledgments

Special thanks to **Dr. Latha P.** for her guidance at **PEP VLSI Centre**.

## Next Steps

- Extend the project to include **UART Receiver**.
- Explore more advanced communication protocols.
- Optimize the design for **low-power applications**.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For any queries or discussions, feel free to reach out!

**Author:** Chandra Sekaran S
**LinkedIn:** https://www.linkedin.com/in/chandra-sekaran-s-1b44b3255/
**GitHub:** https://github.com/iamvengeance018

