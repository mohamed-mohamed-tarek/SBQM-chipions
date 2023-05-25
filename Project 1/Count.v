module counter
# (parameter n=3 ) // this is used as generic to change counter size

(   // this clock signal is used only with Resetn
    input Resetn, // Reset should be low when clock rise
    input up_count, // up_count must change from high to low to increase Y_o this will be connected to back beam
    input down_count, // down_count must change from high to low to decrease Y_o this will be connected to front beam
    output empty_flag, // this flag is active high gives 1 when Y_o is zero otherwise it gives 0
    output full_flag, //  this flag is active high gives 1 when Y_o is 2^n - 1 otherwise it gives 0
    output [n-1:0]Y_o // this is the output of the counter connected to Pcount
);

// Register Declaration section
reg [n-1:0]Y_r; // this Register is used to store output after always blocks terminates
reg FF;        // this Register is used to store empty flag status after performing always blocks
reg EF;       // this Register is used to store Full flag status after performing always blocks
 
// States Section
reg [n-1:0] state_r;

// Assignment Section
assign Y_o=Y_r;         // puting value of Register Y_r on Y_o (the output of counter)
assign full_flag = FF; // putting value of Register FF on full_flag (output flag of counter)
assign empty_flag = EF; // putting value of Register EF on emmpty_flag (output flag of counter)

// Always block used for reseting of the counter
always@(negedge Resetn,negedge up_count,negedge down_count,negedge Resetn)begin
  
  EF <=1;
  FF <=0;

// if statment used to reset counter in case the Resetn was low while the clock changed for low to high
   if (Resetn ==0)begin
  state_r <= 0;  // Reseting Y_r to zero state
     Y_r <= 3'b000 ;
     FF <= 0;       // Reseting FF to low
     EF <= 1 ;      // Seting EF to high
  end
  else begin
   case(state_r)
  0:begin
  Y_r <= 3'b000;
  end
  1:begin
  Y_r <= 3'b001;
  end
  2:begin
  Y_r <= 3'b010;
  end
  3:begin
  Y_r <= 3'b011;
  end
  4:begin
  Y_r <= 3'b100;
  end
  5:begin
  Y_r <= 3'b101;
  end
  6:begin
  Y_r <= 3'b110;
  end
  7:begin
  Y_r <= 3'b111;
  end
  endcase
  
// if statment used to decrease Y_r when front beam is interrupted 
  
  if (down_count==0 )
  begin 
      if (up_count==0) begin 
        state_r <= state_r;
      end
      else begin
       if (state_r != 0  )begin
  state_r <= state_r - 1 ;
  end
  else if (state_r==0)begin
    state_r <= 0;
  end

// if statment used to affect empty and full flag only
  if(state_r == (2**n - 1))begin
  FF <= 1'h1;
  EF <= 1'h0;
  end
  else if(state_r == 0)begin
  EF<=1'h1;
  FF <=1'h0;
  end
  else begin
  FF <= 1'h0;
  EF <= 1'h0 ;
  end
      end
  
  end
  else begin
  
  if (up_count==0)begin
      if(state_r != (2**n - 1)) begin
  state_r <= state_r + 1 ;
  end
  else if (state_r == (2**n - 1))begin
    state_r <= 7;
  end

// if statment used to affect empty and full flag only
  if(state_r == (2**n - 1))begin
  FF <= 1;
  EF <= 0;
  end
  else if(state_r == 0)begin
  EF<=1;
  FF <=0;
  end
  else begin
  FF <= 0;
  EF <= 0 ;
  end
  end
  end
end

end
endmodule