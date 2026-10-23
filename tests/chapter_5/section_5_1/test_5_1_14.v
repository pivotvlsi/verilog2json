module test_5_1_14;
    reg a;
    reg b;
    reg [3:0] out;

    always @* begin
        out = {2{a, b}};
        $display("out = %b", out);
    end
    initial begin
        #10 $finish;
    end
endmodule
