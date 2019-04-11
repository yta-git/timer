module seg_ctrl(
		input logic 	   mclk,
		input logic [4:0]  hour,
		input logic [5:0]  minute,
		input logic [5:0]  sec,
		output logic [7:0] seg_sel,
		output logic [7:0] seg_db
		);

   reg [2:0] 			   status;
   
   initial begin
      status = 0;
      seg_sel = ~(8'b00000001);
   end

   always @ (posedge mclk) begin
      seg_sel = ~(8'b00000001 << status);   
      
      case(status)
	0: seg_db = get_seg(sec % 10);
	1: seg_db = get_seg(sec / 10);
	2: seg_db = get_seg(minute % 10);
	3: seg_db = get_seg(minute /  10);
	4: seg_db = get_seg(hour % 10);
	5: seg_db = get_seg(hour / 10);
//	6: seg_db = 8'b01000000; //get_seg(7);//hour / 10);
//	7: seg_db = 8'b10000000;//get_seg(8);//hour / 10);
	default: seg_db = 8'b01101101;//get_seg(6); //seg_db <= 8'b11001100;
      endcase // case (status)
      
      status =(status == 5? 0 :  status + 1);
      
   end
   
   function [7:0] get_seg;
      input [4:0] 		 num;
      
      case(num)
	0: get_seg = 8'b00111111;
	1: get_seg = 8'b00000110;
	2: get_seg = 8'b01011011;
	3: get_seg = 8'b01001111;
	4: get_seg = 8'b01100110;
	5: get_seg = 8'b01101101;
	6: get_seg = 8'b01111101;
	7: get_seg = 8'b00100111;
	8: get_seg = 8'b01111111;
	9: get_seg = 8'b01101111;
	default: get_seg = 8'b00000000;
      endcase // case (num)
      
   endfunction // casex


endmodule // seg_ctrl

