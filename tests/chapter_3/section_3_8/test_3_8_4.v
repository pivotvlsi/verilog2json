// Parameterized module with no ports
module test_3_8_4 #(
    parameter W=8
);
    wire c;
    initial begin
        $display("W = %d, c = %b", W, c);
    end
endmodule
