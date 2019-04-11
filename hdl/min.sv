module minute(
	      input logic 	 carry_from_sec,
	      output logic 	 carry_for_hour,
	      output logic [5:0] r_minute,
	      input logic [5:0]  set_minute,
	      input logic 	 set
	      );
   
   initial begin
      carry_for_hour = 0;
      r_minute = 0;
   end

   always @ (posedge carry_from_sec or posedge set) begin

      if(set) r_minute = set_minute;
      else begin

	 r_minute = r_minute + 1;	 
	 carry_for_hour = 0;
	 
	 if(r_minute == 60) begin

	    r_minute = 0;
	    carry_for_hour = 1;
	    
	 end
	 
      end
      
   end

endmodule // minute
