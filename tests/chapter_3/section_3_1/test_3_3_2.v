/* 
   This is a multi-line block comment
   It tests if the Verilog parser correctly strips it.
*/
module test_3_3_2();
    /* Inline block comment */ 
    initial begin
        $display("test_3_3_2 PASSED");
        #1 $finish;
    end
endmodule
