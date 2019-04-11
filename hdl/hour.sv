module hour(
	    input logic        minute,
	    output logic       hour,
	    output logic [4:0] r_hour
	    );

   reg [5:0] 		       counter;
   
   initial begin
      hour = 0;
      r_hour = 0;
      counter = 0;      
   end

   always @ (posedge minute) begin

      counter = counter + 1;     
      hour = 0;
      
      if(counter == 60) begin
	 r_hour = (r_hour  == 23 ? 0 : r_hour + 1);
	 hour = 1; 
	 counter = 0;
      end
      
   end

endmodule // hour

