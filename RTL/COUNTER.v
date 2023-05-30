module COUNTER #(parameter counter_max = 3 ,
                           count_width= $clog2(counter_max)) 
 (  input   wire                   clk,
    input   wire                    rst,
    input   wire                    Counter_enable,
    output  reg                     Counter_done_seq,
    output  wire                    Counter_done_comb,
    output  reg  [count_width-1:0]  count
  );
    
    reg       flag;

always @(posedge clk or negedge rst ) begin
  if(!rst) 
      begin
        count<=0;
        flag<=1;
      end
  else if(Counter_enable)
     begin
        count<=1;
        flag<=0;
     end
  else
     begin
        if(count<counter_max && flag==0)
          begin
            count<=count+1; 
            flag<=0;
          end
        else
          begin
            count<=0;
            flag<=1;
           end
     end 
end

////////////////////////////////////////////////////////////////////////////
///////////////// put in always block to delay 1 clk cycle /////////////////
///////////////////////////////////////////////////////////////////////////
always @(posedge clk or negedge rst)
 begin
    if (!rst)
      begin
        Counter_done_seq<=0;
      end
    else 
      begin
        Counter_done_seq<=(count==counter_max);
      end
 
 end

assign Counter_done_comb=(count==counter_max);

endmodule