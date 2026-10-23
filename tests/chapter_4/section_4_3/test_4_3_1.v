module test_4_3_1;
    wire [31:0] w_vec;
    reg signed [7:0] r_vec;
    logic [15:0] l_vec;
    initial begin
        $display("w_vec = %b, r_vec = %b, l_vec = %b", w_vec, r_vec, l_vec);
    end
endmodule
