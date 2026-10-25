// This is a single line comment before the module
module test_3_3_1();
 // This is a comment inside the module
 // Another inline comment
    initial begin
        $display("test_3_3_1 PASSED");
        #1 $finish;
    end
endmodule
// Final comment
