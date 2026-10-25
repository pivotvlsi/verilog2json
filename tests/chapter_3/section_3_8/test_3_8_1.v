// Module with no ports
module test_3_8_1;
    wire a;
    initial begin
        $display("a = %b", a);
        #1 $finish;
    end
endmodule
