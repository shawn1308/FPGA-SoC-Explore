`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.09.2025 23:21:12
// Design Name: 
// Module Name: SEGMENT1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SEGMENT1(
    input wire CLK,              // 100 MHz clock
    output reg [6:0] SEG,        // 7-segment segments (a-g)
    output reg [3:0] AN          // 7-segment digit enable on basys3
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

    // Enable only one digit (rightmost)
    always @(*) begin
        AN = 4'b1110;  // Enable an0 (rightmost digit), disable others
    end
endmodule
