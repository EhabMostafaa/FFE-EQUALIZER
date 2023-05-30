module MUX_2x1 #(parameter  data_width=12) 
(
    input   wire [data_width-1:0]          in1,
    input   wire [data_width-1:0]          in2,
    input   wire                           sel,
    output  reg  [data_width-1:0]          out
);

always @(*) 
 begin
   case (sel)
        1'b0: out=in1;
        1'b1: out=in2;
     default: out=in1;
        
   endcase    
 end   
endmodule