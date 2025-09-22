# BLINK

> VERILOG for BASYS 3

Simulation time unit/precision

```verilog
`timescale 1ns / 1ps
```
Counter in VERILOG

```verilog
reg [23:0] counter = 0;  // 24 bits counter

always @(posedge CLK) begin
    counter <= counter + 1;
end
```
Whole BLINK LED Code : 

```verilog
module BLINK(
    input wire CLK,     // Clock
    output wire LED     // LED
    );
    
    reg [23:0] counter = 0;

    always @(posedge CLK) begin
        counter <= counter + 1;
    end

    assign LED = counter[23];

endmodule
```

Constraints for BASYS 3 :

```
set_property -dict { PACKAGE_PIN W5 IOSTANDARD LVCMOS33 } [get_ports CLK]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK]

set_property -dict { PACKAGE_PIN L1 IOSTANDARD LVCMOS33 } [get_ports LED]
```
