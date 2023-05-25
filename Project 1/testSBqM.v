module testSBqM
    # (parameter n=3 );
    reg T_clk, T_Resetn, T_FBeam, T_BBeam;
    reg [1:0] T_Tcount;
    wire T_full_flag, T_empty_flag;
    wire [4:0] T_Wtime;
    wire [n-1:0] T_Pcount;

integer i ; 

initial begin
    T_clk = 1'b1;
end

always begin 
    #50 T_clk = ~T_clk;
end

initial begin
    T_Resetn = 1'b0 ; 
    T_BBeam = 1'b1 ; 
    T_FBeam = 1'b1 ; 
    T_Tcount = 1;
    #5 T_Resetn = 1'b1 ; 
    // Test, at each value of Tcount, the two flags, wrapping around situation, and waiting time.
    T_Tcount = 1;
    for (i = 0  ; i < 9 ; i = i+1 ) begin 
        T_BBeam = 1'b0 ; 
        #50 T_BBeam = 1'b1 ; 
        #50; 
    end
    for (i = 0  ; i < 9 ; i = i+1 ) begin 
        
        T_FBeam = 1'b0 ; 
        #50 T_FBeam = 1'b1 ; 
        #50; 
    end
    T_Tcount = 2;
    for (i = 0  ; i < 9 ; i = i+1 ) begin 
        T_BBeam = 1'b0 ; 
        #50 T_BBeam = 1'b1 ; 
        #50; 
    end
    for (i = 0  ; i < 9 ; i = i+1 ) begin 
        
        T_FBeam = 1'b0 ; 
        #50 T_FBeam = 1'b1 ; 
        #50; 
    end
    T_Tcount = 3;
    for (i = 0  ; i < 9 ; i = i+1 ) begin 
        T_BBeam = 1'b0 ; 
        #50 T_BBeam = 1'b1 ; 
        #50; 
    end
    for (i = 0  ; i < 9 ; i = i+1 ) begin 
        
        T_FBeam = 1'b0 ; 
        #50 T_FBeam = 1'b1 ; 
        #50; 
    end
end
    SBqM dut (.Resetn(T_Resetn),
                .down_count(T_FBeam),
                .up_count(T_BBeam), 
                .clk(T_clk),  
                .empty_flag(T_empty_flag), 
                .full_flag(T_full_flag),
                .tcount(T_Tcount),
                .pcount (T_Pcount),
                .wcount(T_Wtime)
                );

    initial begin
        $monitor($time, "T_Resetn = %b, T_FBeam = %b, T_BBeam = %b, T_full_flag = %b, T_empty_flag = %b, T_Pcount = %d, T_Wtime = %d, T_Tcount = %d", 
        T_Resetn, T_FBeam, T_BBeam, T_full_flag, T_empty_flag, T_Pcount, T_Wtime, T_Tcount);
    end
endmodule