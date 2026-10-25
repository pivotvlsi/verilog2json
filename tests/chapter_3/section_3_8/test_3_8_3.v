// Parameterized module with ports
module test_3_8_3 #(parameter W=8, parameter V=2) (input wire a, output wire b);
    initial begin
        $display("W = %d, V = %d", W, V);
        #1 $finish;
    end
endmodule
