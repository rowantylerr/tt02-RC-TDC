/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_rowantylerr_RC_TDC (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    //Module to control functionality of RC time to resistance calculator
    RC_TDC RC_TDC_inst(
        .clk(clk),
        .reset_in(ui_in[0]),    //From raspberry pi
        .enable(ui_in[1]),   //From raspberry pi
        .step_input(ui_in[2]),   // Async input from RC circuit
        .step_set(uo_out[0]), //Output to stimulate circuit
        .uart_tx(uo_out[1])   //Serial output pin for resistance measurement
    );

  // All output pins must be assigned. If not used, assign to 0.
    assign uo_out[7:2] = 0;
    assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
    wire _unused = &{ena, rst_n, ui_in[7:3], uio_in, 1'b0};

endmodule
