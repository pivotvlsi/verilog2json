module test_9_1_9;
    reg c;
    always begin
        c = #5 ~c;
        $display("c = %b", c);
    end
endmodule
