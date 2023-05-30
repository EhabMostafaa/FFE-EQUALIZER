module REGISTER #(
    parameter width = 12)
  ( input   wire                 clk,
    input   wire                 rst,
    input   wire    [width-1:0]  in,
    input   wire                 delete, 
    output  reg     [width-1:0]  out
  );

always @(posedge clk or negedge rst)
   begin
      if (!rst) 
      begin
         out<=0;
       end
       
    else if(delete)
       begin
       out<=0;
       end
    
    else begin
        out<=in;
    end
 end    
endmodule