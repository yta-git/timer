module minute(
	      input logic      sec,
	      output logic     minute,
	      output logic [5:0] r_minute
	      );

   reg [5:0] 		       counter;
   
   initial begin
      minute = 0;
      r_minute = 0;
      counter = 0;      
   end

   always @ (posedge sec) begin

      counter = counter + 1;     
      minute = 0;
      
      if(counter == 60) begin
	 r_minute = (r_minute == 59 ? 0 : r_minute + 1);
	 minute = 1; 
	 counter = 0;
      end
      
   end

endmodule // minute
