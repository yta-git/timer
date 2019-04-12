module hour(
	    input logic        carry_from_minute,
	    output logic [4:0] r_hour,
	    input logic [4:0]  set_hour,
	    input logic        set
	    );
   
   initial begin
      r_hour = 0;
   end
   
   always @ (posedge carry_from_minute or posedge set) begin

      if(set) r_hour = set_hour;
      else begin
     
	 r_hour = r_hour == 59 ? 0 : r_hour + 1;	  
	 
      end
      
   end

endmodule // hour

