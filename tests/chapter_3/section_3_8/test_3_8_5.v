(* my_attr = 1 *) module test_3_8_5;
    (* keep = "true" *) wire a;
    (* 
        multiline attr
    *) wire b;
    initial begin
        $display("a = %b, b = %b", a, b);
    end
endmodule
