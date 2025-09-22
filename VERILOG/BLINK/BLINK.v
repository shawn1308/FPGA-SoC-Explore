`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Engineer: Amalan
// Module Name: BLINK

//////////////////////////////////////////////////////////////////////////////////


module BLINK(
    input wire CLK,         // Clock
    output wire LED         // LED
    );
    
    reg [23:0] counter = 0;  // Compteur 24 bits

    always @(posedge CLK) begin
        counter <= counter + 1;
    end

    assign LED = counter[23];
endmodule
