module seg_ctrl(
		input logic 	   mclk,
		input logic [4:0]  nowH,
		input logic [5:0]  nowM,
		
		input logic [4:0]  timerH,
		input logic [5:0]  timerM,

		input logic [3:0]  master_status,
		
		output logic [7:0] seg_sel,
		output logic [7:0] seg_db,

		input logic 	   sec_p
		);

   reg [2:0] 			   status;
   reg 				   flag;
      
   initial begin
      status = 0;
      seg_sel = ~(8'b00000001);
      flag = 0;      
   end

   always @ (posedge sec_p) flag = ~flag;   
   
   always @ (posedge mclk) begin
      seg_sel = ~(8'b00000001 << status);
      
      case(status)
	0: seg_db = master_status > 7 ? get_seg(timerM % 10) : flag && master_status == 7 ? 8'b00001000 : 8'b00000000;
	1: seg_db = master_status > 6 ? get_seg(timerM / 10) : flag && master_status == 6 ? 8'b00001000 : 8'b00000000;
	2: seg_db = master_status > 5 ? get_seg(timerH % 10) : flag && master_status == 5 ? 8'b00001000 : 8'b00000000;
	3: seg_db = master_status > 4 ? get_seg(timerH / 10) : flag && master_status == 4 ? 8'b00001000 : 8'b00000000;
	4: seg_db = master_status > 3 ? get_seg(nowM % 10) : flag && master_status == 3 ? 8'b00001000 : 8'b00000000;
	5: seg_db = master_status > 2 ? get_seg(nowM / 10) : flag && master_status == 2 ? 8'b00001000 : 8'b00000000;
	6: seg_db = master_status > 1 ? (flag && master_status == 8 ? get_seg(nowH % 10) | 8'b10000000 : get_seg(nowH % 10)) : (flag && master_status == 1 ? 8'b00001000 : 8'b00000000);
	7: seg_db = master_status > 0 ? get_seg(nowH / 10): flag && master_status == 0 ? 8'b00001000 : 8'b00000000;
	default: seg_db = 8'b00000010;//get_seg(6); //seg_db <= 8'b11001100;
      endcase // case (status)
      
      status = (status == 7? 0 :  status + 1);
      
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

