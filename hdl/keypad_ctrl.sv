module keypad_ctrl(
		   input logic 	       mclk,
		   input logic [3:0]   ax_keyin,
		   output logic [3:0]  ax_keyout,
		   output logic [4:0]  key_code,
		   output logic [15:0] key_bitmap
		   );

   // *** Wire definition
//   wire [15:0] 			       key_bitmap_wire;

   // *** Register definition
   reg [3:0] 			       key_r1[3:0], key_r2[3:0];
   reg [1:0] 			       key_ctr;
   reg [7:0] 			       key_delay;

   // *** Logic
   assign ax_keyout = f_ax_keyout(key_ctr);
   assign key_bitmap = {
			key_r2[3] | key_r1[3], key_r2[2] | key_r1[2],
			key_r2[1] | key_r1[1], key_r2[0] | key_r1[0]
			};
   assign key_code = f_key_code(key_bitmap);

   // *** Register
   always_ff @ (posedge mclk) begin
      if(key_delay == 128) begin
	 case(key_ctr)
           0: key_r1[0] <= ax_keyin;
           1: key_r1[1] <= ax_keyin;
           2: key_r1[2] <= ax_keyin;
           3: key_r1[3] <= ax_keyin;
	 endcase
	 key_r2[key_ctr] <= key_r1[key_ctr];
	 key_ctr <= key_ctr + 1;
      end
      key_delay <= key_delay + 1;
   end

   // *** Function definition
   function [3:0] f_ax_keyout;
      input [1:0] ctr;

      // 1 is high impedance, 0 is output low level
      case(ctr)
	0: f_ax_keyout = 4'b1110;
	1: f_ax_keyout = 4'b1101;
	2: f_ax_keyout = 4'b1011;
	3: f_ax_keyout = 4'b0111;
      endcase
   endfunction
   function [4:0] f_key_code;
      input [15:0] bitmap;

      casex(bitmap)
	16'b0xxxxxxxxxxxxxxx: f_key_code = 16;
	16'b10xxxxxxxxxxxxxx: f_key_code = 15;
	16'b110xxxxxxxxxxxxx: f_key_code = 14;
	16'b1110xxxxxxxxxxxx: f_key_code = 13;
	16'b11110xxxxxxxxxxx: f_key_code = 12;
	16'b111110xxxxxxxxxx: f_key_code = 11;
	16'b1111110xxxxxxxxx: f_key_code = 10;
	16'b11111110xxxxxxxx: f_key_code = 9;
	16'b111111110xxxxxxx: f_key_code = 8;
	16'b1111111110xxxxxx: f_key_code = 7;
	16'b11111111110xxxxx: f_key_code = 6;
	16'b111111111110xxxx: f_key_code = 5;
	16'b1111111111110xxx: f_key_code = 4;
	16'b11111111111110xx: f_key_code = 3;
	16'b111111111111110x: f_key_code = 2;
	16'b1111111111111110: f_key_code = 1;
	default: f_key_code = 0;
      endcase
   endfunction
endmodule
