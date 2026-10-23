module test_3_9_1;
    real r_val = 1.23;
    realtime rt_val = 123.4e-2;
    time t_val = 2ns;
    initial begin
        $display("r_val = %f, rt_val = %f, t_val = %0d", r_val, rt_val, t_val);
    end
endmodule
