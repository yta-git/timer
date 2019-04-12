module cmp(
	   input logic 	      mclk,
	   
	   input logic [4:0] nowH,
	   input logic [5:0] nowM,
	   input logic [4:0] timerH,
	   input logic [5:0] timerM,
	   
	   input logic 	      enable,

	   output logic equal
	   );


   
   initial begin
      equal = 0;
   end
   

   always @ (posedge mclk) begin
      
      equal = enable && nowH == timerH && nowM == timerM;

   end

endmodule // sec
