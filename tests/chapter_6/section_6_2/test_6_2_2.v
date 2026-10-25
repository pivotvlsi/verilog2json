module test_6_2_2;
    integer i = 0;
    integer j;
    initial begin
        $display("i = %d, j = %d", i, j);
        #1 $finish;
    end
endmodule
