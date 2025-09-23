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

LED Toggle use simple synchronizer and edge detector for robust against debouncing :

```verilog
module BOUNCE(
    input wire CLK,         // Clock
    input wire BTN,         // Push button
    output reg LED          // LED
    );
    
    reg [23:0] counter = 0;
    
    reg btn_sync_0 = 0, btn_sync_1 = 0;
    reg btn_prev = 0;
    wire btn_rising;

    // Synchronize button to clock domain
    always @(posedge CLK) begin
        btn_sync_0 <= BTN;
        btn_sync_1 <= btn_sync_0;
    end

    // Detect rising edge
    assign btn_rising = btn_sync_1 & ~btn_prev;

    // Update previous button state
    always @(posedge CLK) begin
        btn_prev <= btn_sync_1;
    end

    // Debounce counter and LED toggle
    always @(posedge CLK) begin
        if (btn_rising) begin
            LED <= ~LED;
        end
    end
endmodule
```

Constraints for BASYS 3 :

```
set_property -dict { PACKAGE_PIN W5 IOSTANDARD LVCMOS33 } [get_ports CLK]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK]

set_property -dict { PACKAGE_PIN L1 IOSTANDARD LVCMOS33 } [get_ports LED]
set_property -dict { PACKAGE_PIN W19 IOSTANDARD LVCMOS33 } [get_ports BTN]
```
