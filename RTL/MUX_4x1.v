module MUX_4x1 #(
    parameter  data_width=12
) (
    input   wire [data_width-1:0]          in1,
    input   wire [data_width-1:0]          in2,
    input   wire [data_width-1:0]          in3,
    input   wire [data_width-1:0]          in4,
    input   wire [1:0]                     sel,
    output  reg  [data_width-1:0]          out
);

always @(*) 
 begin
    case (sel)
        2'b00: out=in1;
         
        2'b01: out=in2;
        
        2'b10: out=in3;
        
        2'b11: out=in4;
        
      default: out=in1;
   endcase    
 end   
endmodule