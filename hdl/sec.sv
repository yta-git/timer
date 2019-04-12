module sec(
	   input logic 	      mclk,
	   input logic 	      enable,
 	   output logic       carry_for_min,
	   output logic [5:0] r_sec,
	   output logic       sec_p,
	   input logic 	      reset
	   );


   reg [24:0] 		      counter;

   
   initial begin
      carry_for_min = 0;
      r_sec = 0;
      counter = 0;
      sec_p = 0;
   end
   

   always @ (posedge mclk or posedge reset) begin

      if(reset) begin	 
	 carry_for_min = 0;
	 r_sec = 0;
	 counter = 0;
	 sec_p = 0;
      end else begin
	 
	 
	 counter = counter + 1;
	 carry_for_min = 0;
	 sec_p = 0;
	 
	 if(counter == 32000000) begin
	    
	    counter = 0;
	    sec_p = 1;
	    if(enable) r_sec = r_sec + 1;
	    
	    if(r_sec == 60) begin
	       r_sec = 0;
	       carry_for_min = 1;
	    end
	    
	 end // if (counter == 32000000)
	 
      end // else: !if(reset)

   end

endmodule // sec
