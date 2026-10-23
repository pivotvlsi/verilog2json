module test_5_1_5;
    wire a;
    wire b;
    wire c;
    reg d;
    always @* begin
        d = &a & (|b) | c;
        $display("d = %b", d);
    end
    initial begin
        #10 $finish;
    end
endmodule
