module tester;
   logic mclk;
   logic [3:0] ax_sw;
   wire [15:0] ax_led;
   wire [10:0] ax_lcd;
   wire [7:0] 	ax_seg_db, ax_seg_sel;
   logic [3:0] 	ax_keyin;
   wire [3:0] 	ax_keyout;

   initial begin
      mclk = 0;
      ax_sw = 0;
      ax_keyin = 0;
      #100000000000000000 $finish;
   end

   always #10 mclk = ~mclk;
   
   axusb axusb(mclk, ax_sw, ax_led, ax_lcd, ax_seg_db, ax_seg_sel, ax_keyin, ax_keyout);
   
endmodule



