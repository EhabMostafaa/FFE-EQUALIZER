module TOP #(
    parameter data_width=12 , counter_max=3)
 ( input    wire                         clk,
   input    wire                         rst,
   input    wire                         load_signal,
   input    wire    [data_width-1:0]     Data_in,
   output   wire    [data_width-1:0]     Data_out
    );

//parametes
    localparam counter_width = $clog2(counter_max);
    
// internal wires
    wire     [data_width-1:0]       Req0,Reg1,Reg2,Reg3;
    wire                            data_valid;
    wire                            data_valid_comb;
    wire     [counter_width-1:0]    count;
    wire     [data_width-1:0]       MUL_in1,MUL_in2,MUL_out;
    wire     [data_width-1:0]       ADDER_in2,ADDER_out;
    wire     [data_width-1:0]       OUT_MUX_IN;
    


REGISTER delay_unit_0(
    .in(Data_in),
    .rst(rst),
    .clk(load_signal),
    .out(Req0)
);

REGISTER delay_unit_1(
    .in(Req0),
    .rst(rst),
    .clk(load_signal),
    .out(Reg1)
);

REGISTER delay_unit_2(
    .in(Reg1),
    .rst(rst),
    .clk(load_signal),
    .out(Reg2)
);

REGISTER delay_unit_3(
    .in(Reg2),
    .rst(rst),
    .clk(load_signal),
    .out(Reg3)
);

COUNTER Counter1(
    .clk(clk),
    .rst(rst),
    .Counter_enable(load_signal),
    .Counter_done_seq(data_valid),
    .Counter_done_comb(data_valid_comb),
    .count(count)
);

MUX_4x1 Mux_after_registers(
    .in1(Req0),
    .in2(Reg1),
    .in3(Reg2),
    .in4(Reg3),
    .sel(count),
    .out(MUL_in1)
);

MUX_4x1 Mux_constant_Multiplier(
    .in1(12'b0000_0001_0000),
    .in2(12'b1111_1111_1000),
    .in3(12'b0000_0000_0101),
    .in4(12'b1111_1111_1110),
    .sel(count),
    .out(MUL_in2)
);

MUL MUL_u0(
    .in1(MUL_in1),
    .in2(MUL_in2),
    .out(MUL_out)
);

ADDER ADDER_u0(
    .in1(MUL_out),
    .in2(ADDER_in2),
    .out(ADDER_out)
);

REGISTER ADDER_reg(
    .in(ADDER_out),
    .rst(rst),
    .clk(clk),
    .out(OUT_MUX_IN)
);

REGISTER reg_delete(
    .in(ADDER_out),
    .rst(rst),
    .delete(data_valid_comb),
    .clk(clk),
    .out(ADDER_in2)
);

MUX_2x1 Mux_FFE_out(
    .in1(Data_out),
    .in2(OUT_MUX_IN),
    .sel(data_valid),
    .out(Data_out)
);

endmodule