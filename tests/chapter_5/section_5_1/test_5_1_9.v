module test_5_1_9;
    wire unsigned_net = 12;
    wire signed signed_net = -12;
    reg [31:0] unsigned_reg = 12;
    reg signed [31:0] signed_reg = -12;
    integer int_var = -12;
    time time_var = 12;
    real real_var = -1.23;
    realtime realtime_var = -12.34;
    initial begin
        $display("unsigned_net = %b, signed_net = %b, unsigned_reg = %d, signed_reg = %d, int_var = %d", unsigned_net, signed_net, unsigned_reg, signed_reg, int_var);
    end
endmodule
