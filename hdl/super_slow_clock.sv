module super_slow_clock(
	       input logic 	  mclk,
	       output logic 	  sclk
	       );


   reg [24:0] 			counter;

 
   initial begin
      sclk = 0;
      counter = 0;
   end
   

   always @ (posedge mclk) begin

      counter = counter + 1;
    
      if(counter == 20000) begin
	 sclk = ~sclk;
	 counter = 0;
      end

   end

endmodule // slow_clock

