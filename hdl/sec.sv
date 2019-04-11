module sec(
	       input logic 	mclk,
	       input logic 	enable,
 	       output logic 	sec,
	       output logic [5:0] r_sec
	       );


   reg [24:0] 			counter;

 
   initial begin
      sec = 0;
      r_sec = 0;
      counter = 0;
   end
   

   always @ (posedge mclk) begin

      if(enable) counter = counter + 1;
      sec = 0;
      
      if(counter == 32000000) begin
	 r_sec = (r_sec == 59 ? 0 : r_sec + 1);
	 sec = 1;
	 counter = 0;
      end

   end

endmodule // sec
