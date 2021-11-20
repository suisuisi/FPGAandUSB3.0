// ==============================================================
// File generated on Wed Nov 17 22:38:59 +0800 2021
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2018.3 (64-bit)
// SW Build 2405991 on Thu Dec  6 23:38:27 MST 2018
// IP Build 2404404 on Fri Dec  7 01:43:56 MST 2018
// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1ns/1ps

module v_demosaic_0_v_demosaic_mux_53fYi #(
parameter
    ID                = 0,
    NUM_STAGE         = 1,
    din0_WIDTH       = 32,
    din1_WIDTH       = 32,
    din2_WIDTH       = 32,
    din3_WIDTH       = 32,
    din4_WIDTH       = 32,
    din5_WIDTH         = 32,
    dout_WIDTH            = 32
)(
    input             clk,
    input             reset,
    input             ce,
    input  [7 : 0]     din0,
    input  [7 : 0]     din1,
    input  [7 : 0]     din2,
    input  [7 : 0]     din3,
    input  [7 : 0]     din4,
    input  [2 : 0]    din5,
    output [7 : 0]   dout);

// puts internal signals
wire [2 : 0]     sel;
// level 1 signals
wire [7 : 0]         mux_1_0;
wire [7 : 0]         mux_1_1;
wire [7 : 0]         mux_1_2;
// level 2 signals
reg  [7 : 0]         mux_2_0_reg;
reg  [7 : 0]         mux_2_1_reg;
reg  [2 : 2]      sel2;
// level 3 signals
wire [7 : 0]         mux_3_0;

assign sel = din5;

// Generate level 1 logic
assign mux_1_0 = (sel[0] == 0)? din0 : din1;
assign mux_1_1 = (sel[0] == 0)? din2 : din3;
assign mux_1_2 = din4;

// Generate level 2 logic
always @(posedge clk) begin
    if (reset == 1)
        sel2 <= 0;
    else if (ce == 1)
        sel2 <= sel[2 : 2];
end

always @(posedge clk) begin
    if (reset == 1)
        mux_2_0_reg <= 0;
    else if (ce == 1) begin
        if (sel[1] == 0)
            mux_2_0_reg <= mux_1_0;
        else
            mux_2_0_reg <= mux_1_1;
    end
end

always @(posedge clk) begin
    if (reset == 1)
        mux_2_1_reg <= 0;
    else if (ce == 1) begin
        mux_2_1_reg <= mux_1_2;
    end
end


// Generate level 3 logic
assign mux_3_0 = (sel2[2] == 0)? mux_2_0_reg : mux_2_1_reg;

// output logic
assign dout = mux_3_0;

endmodule
