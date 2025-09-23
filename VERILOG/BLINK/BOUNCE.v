`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.09.2025 22:50:47
// Design Name: 
// Module Name: BOUNCE
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
