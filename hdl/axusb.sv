// AX-USB 1bit Sound Player & Synthesizer

// Key definition
`define key_null 0
`define key_1 1
`define key_2 2
`define key_3 3
`define key_4 4
`define key_5 5
`define key_6 6
`define key_7 7
`define key_8 8
`define key_9 9
`define key_10 10
`define key_11 11
`define key_12 12
`define key_13 13
`define key_14 14
`define key_15 15
`define key_16 16

// Top module
module axusb(
	     input logic 	 mclk, // 32MHz
	     input logic [3:0] 	 ax_sw,
	     output logic [15:0] ax_led,
	     output logic [10:0] ax_lcd,
	     output logic [7:0]  ax_seg_db, ax_seg_sel,
	     input logic [3:0] 	 ax_keyin,
	     inout wire [3:0] 	 ax_keyout
	     );
   // *** Wire definition
   wire 			 snd_ax_sp, syn_ax_sp;
   wire [3:0] 			 raw_keyout;
   wire [4:0] 			 key_code;
   wire [15:0] 			 key_bitmap;

   wire 			 sec_wire, minute_wire, hour_wire, sclk, ssclk, led_ctrl;
   wire [5:0] 			 r_sec, r_minute; 			 
   wire [4:0] 			 r_hour;
   wire [7:0] 			 seg_db, seg_sel;
   
   // *** Register definition

   // Common (Keypad)
   // *** Logic
   assign ax_keyout[3] 		 = (raw_keyout[3] ? 1'bz : 1'b0);
   assign ax_keyout[2] = (raw_keyout[2] ? 1'bz : 1'b0);
   assign ax_keyout[1] = (raw_keyout[1] ? 1'bz : 1'b0);
   assign ax_keyout[0] = (raw_keyout[0] ? 1'bz : 1'b0);
   
   assign ax_led = (led_ctrl ? 16'b1111111111111111 : 16'b0000000000000000);
   assign ax_seg_db = seg_db;
   assign ax_seg_sel = seg_sel;
   

   keypad_ctrl keypad_ctrl(mclk, ax_keyin, raw_keyout, key_code, key_bitmap);
   
   sec sec(mclk, 1'b1, sec_wire, r_sec);
   minute minute(sec_wire, minute_wire, r_minute);
   hour hour(minute_wire, hour_wire, r_hour);
   seg_ctrl seg_ctrl(ssclk, r_hour, r_minute, r_sec, seg_sel, seg_db);

   slow_clock slow_clock(mclk, sclk);
   super_slow_clock super_slow_clock(mclk, ssclk);
   pwm pwm(sclk, led_ctrl);
      
endmodule
