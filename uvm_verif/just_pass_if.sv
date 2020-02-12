interface just_pass_if (input clk, rstn);
	logic [7:0] data_i;
	logic bool_o;
	logic [7:0] data_o;

	modport DUT (
		input clk, rstn,
		input	 data_i,
		output	 bool_o,
		output	 data_o);

	modport VERIF (
		input clk, rstn,
		output	 data_i,
		input	 bool_o,
		input	 data_o);
endinterface : just_pass_if