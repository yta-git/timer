module pwm(
	   input logic 	mclk,
	   output logic led_ctrl
	   );
   
   reg [7:0] 		counter, delay, threshold;
   reg 			flag, flag2;
   reg [7:0] 		test;
   
   initial begin
      counter = 0;
      flag = 0;
      flag2 = 0;
      led_ctrl = 1;
      delay = 100;
      test = 255;
      threshold = 0;
   end

   always @ (posedge mclk) begin

      if(counter == 255) flag = 1;
      if(counter == 0) begin
	 flag = 0;
	 if(threshold == 255) flag2 = 1;
	 if(threshold == 0) flag2 = 0;
	 threshold = flag2 ? threshold - 1 : threshold + 1;
      end

      counter = flag ? counter - 1 : counter + 1;
      led_ctrl = counter < threshold ? 0 : 1;

   end

endmodule // pwm



