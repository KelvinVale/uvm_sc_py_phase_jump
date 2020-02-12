module just_pass_sc2sv (
	clk,
	rstn,
	data_i,
	bool_o,
	data_o
)
(* integer foreign = "SystemC";
*);

	parameter data_width = 8;
	
	input clk;
	input rstn;
	input [data_width-1:0] data_i;
	
	output bool_o;
	output [data_width-1:0] data_o;


endmodule