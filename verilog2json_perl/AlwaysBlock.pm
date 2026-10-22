package AlwaysBlock;

use SemanticChecker;
use strict;
use warnings;
use utf8;


sub always_block;
our $always_block_count=0;
our @always_block_arr = ();
our $delay_val_cnt;

sub always_block {
    my ($orig_line_no) = @_;
    my $line_no = $orig_line_no;
    my $expect_end = 0;
    my $end_occurred=0;
    $delay_val_cnt = 0;
    $AlwaysBlockIf::always_if_count = 0;
    my $line1 = $VerilogParser::verilog_file[$line_no];
    chomp($line1);
    my $kaladeenam;
    my $samvedanasoochi;
    if ($line1 =~ /always/) {
        if ($line1 =~ /^\s*always_comb\b/) {
            $line1 =~ s/^\s*always_comb//;
            $kaladeenam = "न";
            $samvedanasoochi = "*";
        } elsif ($line1 =~ /^\s*always\s*@\s*\(\s*(.*?)\s*\)/) {
            $samvedanasoochi = $1;
            $line1 =~ s/^\s*always\s*@\s*\(\s*.*?\s*\)//;
            if ($samvedanasoochi eq '*' || $samvedanasoochi !~ /posedge|negedge/) {
                $kaladeenam = "न";
            } else {
                $kaladeenam = "आम्";
            }
        } elsif ($line1 =~ /^\s*always\s*@\s*\*/) {
            $line1 =~ s/^\s*always\s*@\s*\*//;
            $kaladeenam = "न";
            $samvedanasoochi = "*";
        } elsif ($line1 =~ /^\s*always\b/) {
            $line1 =~ s/^\s*always//;
            $kaladeenam = "न";
            $samvedanasoochi = "";
        } else {
            Diagnostics::report_diagnostic("Error", "ERR_FATAL", "From AlwaysBlock ; To be updated later", $line_no);
        }
        while ($line1 =~ /^$/) {
              $line_no = $line_no+1;
            if ($line_no > $VerilogParser::max_line) {
                Diagnostics::report_diagnostic("Error", "ERR_FATAL", "Max line reached at check_module", $line_no);
            }
            $line1 .= $VerilogParser::verilog_file[$line_no];
            chomp($line1);
            $line1 =~ s/\s*//g;
        }
        $line1 =~ s/\s*//g;
        if ($line1 =~ /^begin/) {
           $expect_end=1;
           $line1 =~ s/begin//;
        }  
        @always_block_arr = ();
        push @always_block_arr, $always_block_count;
        push @always_block_arr, "\$";

        my $json_var = $JsonOutput::module_json{$VerilogParser::module_name};
        my $arr_cnt = scalar @always_block_arr;
        my $arr_trk=0;
        my $statement_type;
        my $statement_count;
        my $json_statement;
        while ($arr_trk < $arr_cnt) {
            $statement_type = $always_block_arr[$arr_trk+1];
            $statement_count = $always_block_arr[$arr_trk];
            $arr_trk= $arr_trk+2;


            if ($statement_type eq "\$") {
                $json_statement = "सदाङ्गम्_".${statement_count};
                $json_var->{$json_statement} //= {};
                $json_var = $json_var->{$json_statement};




            } elsif ($statement_type eq "_") {
                $json_statement = "यद्यङ्गम्_".${statement_count};
                $json_var->{$json_statement} //= {};
                $json_var = $json_var->{$json_statement};
            } elsif ($statement_type eq "#") {
                $json_statement = "अन्यथायद्यङ्गम्_".${statement_count};
                $json_var->{$json_statement} //= {};
                $json_var = $json_var->{$json_statement};
            } elsif ($statement_type eq "&") {
                $json_statement = "अन्यथाङ्गम्_".${statement_count};
                $json_var->{$json_statement} //= {};
                $json_var = $json_var->{$json_statement};                
            }
        }
        $json_var->{"प्रकारः"} = "सदाङ्गम्";
        $json_var->{"क्रमः"} = $VerilogParser::statement_order;
        $always_block_count = $always_block_count+1;
        $json_var->{"संवेदनसूची"} = $samvedanasoochi;
        $json_var->{"कालाधीनम्"} = $kaladeenam; #आम् न
        $AlwaysBlock::current_kaladeenam = $kaladeenam;
        $VerilogParser::statement_order = $VerilogParser::statement_order+1;
        while(1) {
            while ($line1 =~ /^$/) {
                $line_no = $line_no+1;
                if ($line_no > $VerilogParser::max_line) {
                    Diagnostics::report_diagnostic("Error", "ERR_FATAL", "Max line reached at AlwaysBlock", $line_no);
                }
                $line1 .= $VerilogParser::verilog_file[$line_no];
                chomp($line1);
                $line1 =~ s/#\s*(\d+)/#\($1\)/g;
                if ($line1 !~ /\$display/) {
                    $line1 =~ s/\s*//g;
                }
            }
            if ($line1 =~ /^\s*if/) { #Check for IF loop
                $line_no = AlwaysBlockIf::always_comb_if ($line1, $line_no);
                $line1 = "";
                if ($expect_end == 0) {               
                     $end_occurred = 1;           
                }
            #Check for END    
            } elsif ($line1 =~ /^\s*end\s*$/) {
                if ($expect_end == 1) {
                    $end_occurred = 1;
                } else {
                    Diagnostics::report_diagnostic("Error", "ERR_FATAL", "Extra end present", $line_no);
                    $end_occurred =1;
                }










            } elsif ($line1 =~ /^\s*;\s*$/) { # Null statement
                $line1 = "";
                if ($expect_end == 0) {
                    $end_occurred = 1;
                }
            } elsif ($line1 =~ /^\s*\$display\b/) {
                while ($line1 !~ /;/) {
                    $line_no = $line_no+1;
                    if ($line_no > $VerilogParser::max_line) {
                        Diagnostics::report_diagnostic("Error", "ERR_FATAL", "Max line reached at always_block", $line_no);
                    }
                    $line1 .= $VerilogParser::verilog_file[$line_no];
                    chomp($line1);
                }
                if ($line1 =~ /;/) {
                    $line1 =~ s/;//;
                } else {
                    print "Semicolon missing at end of \$display statement";
                }
                my $args_str = "";
                if ($line1 =~ /\$display\s*\(\s*(.*?)\s*\)\s*$/) {
                    $args_str = $1;
                } elsif ($line1 =~ /\$display\s*$/) {
                    $args_str = "";
                } else {
                    Diagnostics::report_diagnostic("Error", "ERR_FATAL", "Print statement format is not correct", $line_no);
                }
                my @args = CheckExpr::parse_system_task_args($args_str);
                my $stt = ${VerilogParser::statement_line}."_वाक्यम्";
                $json_var->{$stt} //= {};
                $json_var->{$stt}->{"प्रकारः"} = "मुद्रणम्";
                $json_var->{$stt}->{"क्रमः"} = $VerilogParser::statement_order;
                $json_var->{$stt}->{"तर्काः"} = \@args;
                $VerilogParser::statement_order = $VerilogParser::statement_order+1;
                $line1 = "";
                $VerilogParser::statement_line = $VerilogParser::statement_line+1;
                if ($expect_end == 0) {
                    $end_occurred = 1;
                }
            } elsif ($line1 =~ /^\s*([^=]+?)\s*(<=|=)\s*(.*)$/) { #Check for Statement
                my $lhs = $1;
                my $operator = $2;
                my $rhs = $3;
                chomp($line1);
                
                if (defined $AlwaysBlock::current_kaladeenam) {
                    if ($AlwaysBlock::current_kaladeenam eq "आम्" && $operator eq '=') {
                        Diagnostics::report_diagnostic("Error", "ERR_FATAL", "Blocking assignment '=' used in sequential always block", $line_no);
                    } elsif ($AlwaysBlock::current_kaladeenam eq "न" && $operator eq '<=') {
                        Diagnostics::report_diagnostic("Error", "ERR_FATAL", "Non-blocking assignment '<=' used in combinational always block", $line_no);
                    }
                }
                
                SemanticChecker::validate_assignment($lhs, $line_no);
                
                my $statement;
                my @statement_temp = CheckExpr::create_postfix($line1, $line_no);
                $statement = join(" ",@statement_temp);
                my $stt = ${VerilogParser::statement_line}."_वाक्यम्";
                $json_var->{$stt} //= {};
                $json_var->{$stt}->{"प्रकारः"} = "वाक्यम्";
                $json_var->{$stt}->{"वाक्यम्"} = $statement;
                $json_var->{$stt}->{"क्रमः"} = $VerilogParser::statement_order;
                $VerilogParser::statement_order = $VerilogParser::statement_order+1;
                $line1 = "";
                $VerilogParser::statement_line = $VerilogParser::statement_line+1;
                if ($expect_end == 0) {
                    $end_occurred = 1;
                }
            } elsif ($line1 =~ /^\$/) {






















                Diagnostics::report_diagnostic("Error", "ERR_FATAL", " Unsupported system tasks", $line_no);
            } elsif ($line1 =~ /endmodule|always/) {
                Diagnostics::report_diagnostic("Error", "ERR_FATAL", "Missing end at $line_no with line $line1", $line_no);
            } else {
                Diagnostics::report_diagnostic("Error", "ERR_FATAL", "Error occured $line1", $line_no);
            }
            if ($end_occurred == 1) {
                last;
            } 
        }
    } else {
        Diagnostics::report_diagnostic("Error", "ERR_FATAL", "Error in $line_no from always block", $line_no);
    }   
    return $line_no;
}
1;
