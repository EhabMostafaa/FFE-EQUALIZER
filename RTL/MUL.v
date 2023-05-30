module MUL #(parameter  data_width=12)
 (  input    wire signed  [data_width-1:0]    in1,
    input    wire signed  [data_width-1:0]    in2,
    output   wire signed  [data_width-1:0]    out
);

reg signed [(2*data_width)-1:0] tmp;

always @(*) 
    begin
        tmp=in1*in2;    
    end
    
assign out={tmp[2*data_width-1] , tmp[data_width-2:0]};
    
endmodule