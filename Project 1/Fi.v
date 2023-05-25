module SBqM
# (parameter n=3 )
(
    input clk,
    input up_count,
    input down_count,
    input Resetn,
    input [1:0]tcount,
    output empty_flag,
    output full_flag,
    output [4:0]wcount,
    output [n-1:0]pcount
);

wire [n-1:0]pcount_wire;
assign pcount = pcount_wire;

counter counter_num
(
    Resetn,
    up_count,
    down_count,
    empty_flag,
    full_flag,
    pcount_wire[n-1:0]
);

ROM Rom_memoryr
(
    tcount[1:0],
    pcount_wire[n-1:0],
    clk,
    wcount[4:0]
);

    
endmodule