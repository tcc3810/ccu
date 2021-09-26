module lab5_cnt0_7(	
		input [2:0] cnt,
		output reg [6:0] seg_data
	);

	//cnt
	always@(*)begin
		seg_data[0] = (cnt[2] & !cnt[1] & !cnt[0]) | (!cnt[2] & !cnt[1] & cnt[0]);
		seg_data[1] = (cnt[2] & !cnt[1] & cnt[0]) | (cnt[2] & cnt[1] & !cnt[0]);
		seg_data[2] = !cnt[2] & cnt[1] & !cnt[0];
		seg_data[3] = (cnt[2] & !cnt[1] & !cnt[0]) | (!cnt[2] & !cnt[1] & cnt[0]) | (cnt[2] & cnt[1] & cnt[0]);
		seg_data[4] = (cnt[2] & !cnt[1]) | (!cnt[2] & cnt[0]) | (cnt[2] & cnt[0]);
		seg_data[5] = (!cnt[2] & cnt[0]) | (!cnt[2] & cnt[1]);
		seg_data[6] = (!cnt[2] & !cnt[1]) | (cnt[2] & cnt[1] & cnt[0]) ; 
	end
	
endmodule