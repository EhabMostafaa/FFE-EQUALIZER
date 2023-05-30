module ADDER #(parameter width=12)
 (  input   wire   signed  [width-1:0] in1,
    input   wire   signed  [width-1:0] in2,
    output  wire   signed  [width-1:0] out
);

reg  [width:0] tmp;

always @(*)
    begin
      tmp=in1+in2;
    end
  
assign out=tmp[width-1:0];
  
endmodule