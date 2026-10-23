module test_9_1_13;
wire a;
wire b;
assign a = b;
assign #10 a = ~b;
initial begin
    #15;
    $display("a = %b, b = %b", a, b);
end
endmodule
