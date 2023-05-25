module ROM 
   #(parameter n=3)
   (
    input [1:0] tcount , // 1 2 or 3  can be represented in 2 bits
    input wire [n-1:0] pcount ,// accourding to the max_nymber of persons in the queue"7", and its an input wire from the counter moduele
    input clk ,
    output [4:0] wcount
);

wire [4:0] address ;
reg [4:0] rom [0:31] ; //32 place because of address each with 5 bits of data as we store up to 21 wich need 5 bits to be represented.
reg [4:0] waiting_time ;
assign address = {tcount[1:0],pcount[n-1:0]} ;
assign wcount = waiting_time ;
initial 
begin 
// we have the adress from 0 to 31
rom[0] <= 5'd0 ;
rom[1] <= 5'd0 ;
rom[2] <= 5'd0 ;
rom[3] <= 5'd0 ;
rom[4] <= 5'd0 ;
rom[5] <= 5'd0 ;
rom[6] <= 5'd0 ;
rom[7] <= 5'd0 ;

rom[8] <= 5'd0 ;
rom[9] <= 5'd3 ;
rom[10] <= 5'd6 ;
rom[11] <= 5'd9 ;
rom[12] <= 5'd12 ;
rom[13] <= 5'd15 ;
rom[14] <= 5'd18 ;
rom[15] <= 5'd21 ;

rom[16] <= 5'd1 ;
rom[17] <= 5'd3 ;
rom[18] <= 5'd4 ;
rom[19] <= 5'd6 ;
rom[20] <= 5'd7 ;
rom[21] <= 5'd9 ;
rom[22] <= 5'd10 ;
rom[23] <= 5'd12 ;

rom[24] <= 5'd2 ;
rom[25] <= 5'd3 ;
rom[26] <= 5'd4 ;
rom[27] <= 5'd5 ;
rom[28] <= 5'd6 ;
rom[29] <= 5'd7 ;
rom[30] <= 5'd8 ;
rom[31] <= 5'd9 ;
end 

integer my_int;
always @( address )
    my_int = address;
always @(posedge clk) 
begin
waiting_time <= rom[my_int] ;
end
    
endmodule