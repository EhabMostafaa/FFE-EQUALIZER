`timescale 1ns/1ps
 module testbench ();

//parameters    
    parameter DATA_WIDTH =12,
              CLK_PER = 250;

// DUT signals
    reg                             clk;
    reg                             rst;
    reg                             load_signal;
    reg     signed [DATA_WIDTH-1:0] Data_in;
    wire    signed [DATA_WIDTH-1:0] Data_out;
    

// Testbench signals
    reg   [11:0]  input_Data  [999:0];
    reg   [11:0]  output_Data [249:0];
    reg   [15:0]  T_counter;
    reg   [15:0]  F_counter;
    integer i;
    
    
    
initial
   begin
      $dumpfile("FFE .vcd");
      $dumpvars;
      
        initialize();    
        reset();
      
    //************** don't forget to change the path ********** 
         $readmemb("D:/DIGITAL/Project/DATA/All_Inputs.txt", input_Data);
         $readmemb("D:/DIGITAL/Project/DATA/Expected_outputs.txt", output_Data);

  for(i=0;i<1000;i=i+1)
    begin
       @(posedge clk)
          Data_in= input_Data[i];
       if(load_signal) 
          begin
             if(output_Data[(i/4)-1]== Data_out)
                 begin
                    T_counter=T_counter+1;
                 end 
             else 
                 begin
                    F_counter=F_counter+1; 
                    $display (" EXPECTED OUTPUT = %b    ,   SIM_OUTPUT=%b" ,output_Data[i/4] ,Data_out );
                 end     
            end
    end    
end


// to make load high one cycle every 4 clock cycles
initial 
   begin
     reset();
    
   repeat(250)
   begin
          @(posedge clk)
          load_signal<=1;
       repeat(3)
          begin
          @(posedge clk)
          load_signal<=0;
          end
      end    
    #CLK_PER;
    #CLK_PER;
   $stop;                
 end


// task reset
task reset(); 
  begin
    rst=1;
    @(negedge clk)
    rst=0;
    @(negedge clk)
    rst=1;
  end
endtask


//task initialize
task initialize();
  begin
    clk=0;
    load_signal=0;
    Data_in=0;
    T_counter='b0;
    F_counter='b0;
  end
endtask


// Clock Generation
    always #CLK_PER clk=~clk;

// module instantation
  TOP #(.data_width(DATA_WIDTH))
       dut(.Data_in     (Data_in),
           .load_signal (load_signal),
           .clk         (clk),
           .rst         (rst),
           .Data_out    (Data_out));
    

endmodule
