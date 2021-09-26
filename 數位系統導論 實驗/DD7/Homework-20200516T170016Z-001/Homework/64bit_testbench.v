`timescale 1ns/1ps

module testbench;

    reg [63:0] in_a, in_b;
    reg cin;

	reg clk;
	reg rst;

    reg [5:0] idx;
    reg [5:0] write;
    reg [5:0] correct_ct;
    reg [64:0] correct_ans;

    wire [63:0] sum;
    wire cout;

    CLA_64bit Import_CLA(in_a,in_b,cin,sum,cout);

	initial begin

        in_a = 0;
        in_b = 0;
        cin = 0;
        clk = 1'b0;
        correct_ct = 0;

        $dumpfile("lab06_64bit.fsdb");  
        $dumpvars;
        
        #10 rst = 1;
        #20 rst = 0;

        for (idx = 1;idx < 20;idx=idx+1) begin
            #500 rst = 1;
            #20 rst = 0;
        end

        #500     $display ("//                     CORRECT COUNT = %d                     //",correct_ct);
        #100    $finish;

    end

    always #10 clk = ~clk;

    always @(posedge clk or posedge rst) begin

        if (rst) begin

			in_a <= {$random}*{$random}*{$random}*{$random};
			in_b <= {$random}*{$random}*{$random}*{$random};
            cin <= {$random} % 2;
            correct_ans <= 0;
            write <= 0;

        end else begin
    
            correct_ans <= in_a + in_b + cin;
            write <= write + 1;

            if (write == 10) begin
                
                if ({cout,sum} == correct_ans) begin

                    correct_ct <= correct_ct + 1;
                    $display ("/////////////////////////////Test %d/////////////////////////////", idx);
                    $display ("//  Q :%d + %d + %d = ?     //", in_a, in_b , cin);
                    $display ("/////////////////////////////////////////////////////////////////");
                    $display ("//  Your answer                                                //");                    
                    $display ("//  Cout = %d Sum = %d                        //",cout,sum);
                    $display ("/////////////////////////////////////////////////////////////////");
                    $display ("//  Correct answer                                             //");
                    $display ("//  Cout = %d Sum = %d                        //",correct_ans[64],correct_ans[63:0]);      
                    $display ("/////////////////////////////////////////////////////////////////");
                    $display ("//                         SUCCESSFUL !                        //");
                    $display ("/////////////////////////////////////////////////////////////////\n");

                end else begin

                    $display ("/////////////////////////////Test %d/////////////////////////////", idx);
                    $display ("//  Q :%d + %d + %d = ?     //", in_a, in_b , cin);
                    $display ("/////////////////////////////////////////////////////////////////");
                    $display ("//  Your answer                                                //");                    
                    $display ("//  Cout = %d Sum = %d                        //",cout,sum);
                    $display ("/////////////////////////////////////////////////////////////////");
                    $display ("//  Correct answer                                             //");
                    $display ("//  Cout = %d Sum = %d                        //",correct_ans[64],correct_ans[63:0]);      
                    $display ("/////////////////////////////////////////////////////////////////");
                    $display ("//                            FAIL !                           //");
                    $display ("/////////////////////////////////////////////////////////////////\n");

                end 
            end
        end
    end

endmodule