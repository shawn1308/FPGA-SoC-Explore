# 7 SEGMENT on BASYS 3

> use 7 sement on basys 3 and switch case

### Generate 1 Hz from 100 MHz on BASYS 3 :

```verilog
    always @(posedge CLK) begin
        if (one_sec_counter >= 100_000_000 - 1) begin
            one_sec_counter <= 0;
            one_sec_tick <= 1;
        end else begin
            one_sec_counter <= one_sec_counter + 1;
            one_sec_tick <= 0;
        end
    end
```

### 0 to 9 counter and reset to 0 :

```verilog
    always @(posedge CLK) begin
        if (one_sec_tick) begin
            digit <= (digit == 9) ? 0 : digit + 1;
        end
    end
```

### 7 Segment DECODER :

```verilog
    always @(*) begin
        case (digit)
            4'd0: SEG = 7'b1000000;
            4'd1: SEG = 7'b1111001;
            4'd2: SEG = 7'b0100100;
            4'd3: SEG = 7'b0110000;
            4'd4: SEG = 7'b0011001;
            4'd5: SEG = 7'b0010010;
            4'd6: SEG = 7'b0000010;
            4'd7: SEG = 7'b1111000;
            4'd8: SEG = 7'b0000000;
            4'd9: SEG = 7'b0010000;
            default: SEG = 7'b1111111;
        endcase
    end
```

## Count 0 to 9 full code : 

```verilog
module SEGMENT1(
    input wire CLK,              // 100 MHz clock
    output reg [6:0] SEG,        // 7-segment (A-G)
    output reg [3:0] AN          // Digit Enable
    );
    
    reg [26:0] one_sec_counter = 0;
    reg one_sec_tick = 0;
    reg [3:0] digit = 0;
    
    // Generate 1 Hz tick from 100 MHz clock
    always @(posedge CLK) begin
        if (one_sec_counter >= 100_000_000 - 1) begin
            one_sec_counter <= 0;
            one_sec_tick <= 1;
        end else begin
            one_sec_counter <= one_sec_counter + 1;
            one_sec_tick <= 0;
        end
    end
    
    // Increment digit every second
    always @(posedge CLK) begin
        if (one_sec_tick) begin
            digit <= (digit == 9) ? 0 : digit + 1;
        end
    end

    // 7-segment decoder
    always @(*) begin
        case (digit)
            4'd0: SEG = 7'b1000000;
            4'd1: SEG = 7'b1111001;
            4'd2: SEG = 7'b0100100;
            4'd3: SEG = 7'b0110000;
            4'd4: SEG = 7'b0011001;
            4'd5: SEG = 7'b0010010;
            4'd6: SEG = 7'b0000010;
            4'd7: SEG = 7'b1111000;
            4'd8: SEG = 7'b0000000;
            4'd9: SEG = 7'b0010000;
            default: SEG = 7'b1111111;
        endcase
    end

    // Enable only one digit
    always @(*) begin
        AN = 4'b1110;  // Enable an0 (rightmost digit), disable others
    end
endmodule
```
## Contraint file :
```
## Clock
set_property -dict { PACKAGE_PIN W5 IOSTANDARD LVCMOS33 } [get_ports CLK]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK]

## 7 Segment Display
set_property -dict { PACKAGE_PIN W7   IOSTANDARD LVCMOS33 } [get_ports {SEG[0]}]
set_property -dict { PACKAGE_PIN W6   IOSTANDARD LVCMOS33 } [get_ports {SEG[1]}]
set_property -dict { PACKAGE_PIN U8   IOSTANDARD LVCMOS33 } [get_ports {SEG[2]}]
set_property -dict { PACKAGE_PIN V8   IOSTANDARD LVCMOS33 } [get_ports {SEG[3]}]
set_property -dict { PACKAGE_PIN U5   IOSTANDARD LVCMOS33 } [get_ports {SEG[4]}]
set_property -dict { PACKAGE_PIN V5   IOSTANDARD LVCMOS33 } [get_ports {SEG[5]}]
set_property -dict { PACKAGE_PIN U7   IOSTANDARD LVCMOS33 } [get_ports {SEG[6]}]

## DP
set_property -dict { PACKAGE_PIN V7   IOSTANDARD LVCMOS33 } [get_ports DP]

## Digital Enable
set_property -dict { PACKAGE_PIN U2   IOSTANDARD LVCMOS33 } [get_ports {AN[0]}]
set_property -dict { PACKAGE_PIN U4   IOSTANDARD LVCMOS33 } [get_ports {AN[1]}]
set_property -dict { PACKAGE_PIN V4   IOSTANDARD LVCMOS33 } [get_ports {AN[2]}]
set_property -dict { PACKAGE_PIN W4   IOSTANDARD LVCMOS33 } [get_ports {AN[3]}]
```