module test_4_9_1;
    reg [7:0] mem [0:255];
    initial begin
        $display("mem[0] = %h", mem[0]);
    end
endmodule
