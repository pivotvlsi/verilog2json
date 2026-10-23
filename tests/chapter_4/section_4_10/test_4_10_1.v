module test_4_10_1;
    parameter [31:0] PARAM1 = 32'hFFFFFFFF;
    parameter signed [7:0] PARAM2 = 8'hFF;
    localparam PARAM3 = 10;
    initial begin
        $display("PARAM1 = %h, PARAM2 = %h, PARAM3 = %d", PARAM1, PARAM2, PARAM3);
    end
endmodule
