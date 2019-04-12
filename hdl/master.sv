module master(
	      input logic 	  mclk,
	      input logic [5:0]   key_code,

	      output logic [4:0]  nowH,
	      output logic [5:0]  nowM,
	      output logic 	  set,
	      output logic [4:0]  timerH,
	      output logic [5:0]  timerM, 
	      output logic 	  run_enable,
	      output logic [3:0]  status,
//	      output logic [15:0] bitmap
	      );

   reg [4:0] 			  key_old;
   reg 				  key_valid;

   initial begin
      nowH = 0;
      nowM = 0;
      set = 0;      
      timerH = 0;
      timerM = 0;
      run_enable = 0;
      status = 0;
      key_old = 9;
      key_valid = 0;
//      bitmap = 1;
   end
   

   always @ (posedge mclk) begin

      key_valid = (key_old == 0 && key_old != key_code);
      key_old = key_code;

      set = 0;

      if(key_code == 1 && key_valid) begin
	 nowH = 0;
	 nowM = 0;
	 set = 1;
	 timerH = 0;
	 timerM = 0;
	 run_enable = 0;
	 status = 0;
	 key_old = 1;
	 key_valid = 0;
//	 bitmap = 1;
      end
	 
      if(status == 0) begin // set current Hour1	 
//	 bitmap = 16'b1111111111111110;
	 
	 if(get_real(key_code) <= 2 && key_valid) begin
	    nowH = get_real(key_code) * 10;
	    set = 1;
	    status = status + 1;
	 end
	 
      end else if(status == 1) begin // set current Hour2
//	 bitmap = 16'b1111111111111101;
	 
	 if(get_real(key_code) <= 9 && nowH + get_real(key_code) < 24 && key_valid) begin
	    nowH = nowH + get_real(key_code);
	    set = 1;	    
	    status = status + 1;
	 end
	 
      end  else if(status == 2) begin // set current Minute1
//	 bitmap = 16'b1111111111111011;
	 
	 if(get_real(key_code) < 6 && key_valid) begin
	    nowM = get_real(key_code) * 10;
	    set = 1;
	    status = status + 1;
	 end
	 
      end else if(status == 3) begin // set current Minute2
//	 bitmap = 16'b1111111111110111;
	 
	 if(get_real(key_code) <= 9 && nowM + get_real(key_code) < 60 && key_valid) begin
	    nowM = nowM + get_real(key_code);
	    set = 1;	    
	    status = status + 1;
	 end
	 
      end else if(status == 4) begin // set timer Hour1
//	 bitmap = 16'b1111111111101111;

	 if(get_real(key_code) <= 2 && key_valid) begin      	    
	    timerH = get_real(key_code) * 10;
	    status = status + 1;
	 end

      end else if(status == 5) begin // set timer Hour1
//	 bitmap = 16'b1111111111011111;
	 
	 if(get_real(key_code) <= 9 && timerH + get_real(key_code) < 24 && key_valid) begin
	    timerH = timerH + get_real(key_code);
	    status = status + 1;
	 end
	 
      end  else if(status == 6) begin // set current Minute1
//	 bitmap = 16'b1111111110111111;
	 
	 if(get_real(key_code) < 6 && key_valid) begin
	    timerM = get_real(key_code) * 10;
	    status = status + 1;
	 end
	 
      end else if(status == 7) begin // set current Minute2
//	 bitmap = 16'b1111111101111111;
	 
	 if(get_real(key_code) <= 9 &&timerM + get_real(key_code) < 60 && key_valid) begin
	    timerM = timerM + get_real(key_code);
	    status = status + 1;
	    run_enable = 1;
	 end


      end
      
   end


   function [3:0] get_real(
			   input [4:0] key_code
			   );
      case(key_code)
	1: get_real = 10; // reset
	2: get_real = 11; // clock
	3: get_real = 12; // enter
	4: get_real = 13; // shift
	5: get_real = 9; 
	6: get_real = 6;
	7: get_real = 3;
	8: get_real = 14; // AD
	9: get_real = 8;
	10: get_real = 5;
	11: get_real = 2;
	12: get_real = 15; // ID
	13: get_real = 7;
	14: get_real = 4;
	15: get_real = 1;
	16: get_real = 0;
	default: get_real = 0;	   
      endcase // case (key_code)
      
   endfunction // get_real
   
   
   
   

endmodule // set_timer

