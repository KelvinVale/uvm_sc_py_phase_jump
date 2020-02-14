//import uvm_pkg::*;//NUNCA MUDE
//`include "uvm_macros.svh"//NUNCA MUDE e nessa ordem !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//import just_pass_pkg::*;
`include "../systemc/wrapper/just_pass_sc2sv.sv"

module just_pass_top;
	import uvm_pkg::*;
	import just_pass_pkg::*;
	parameter freq_clk = 50000000;
	parameter baud_rate = 115200;
	parameter min_trans = 10000;

	int cont=0;

	parameter DATA_WIDTH = 8;

	logic clk, rstn;
    logic [DATA_WIDTH-1:0] data_o_sc;
	logic bool_o_sc;
	just_pass_if dut_if (.clk(clk), .rstn(rstn));
	just_pass_if sc_if (.clk(clk), .rstn(rstn));

	
	just_pass_sc2sv sc_dut (
		.clk(dut_if.clk),
		.rstn(dut_if.rstn),
		.data_i(dut_if.data_i),
		.data_o(sc_if.data_o),
		.bool_o(sc_if.bool_o)
	);

	Just_Pass dut
	(
		.clk(dut_if.clk),
		.rstn(dut_if.rstn),
		.data_i(dut_if.data_i),
		.data_o(dut_if.data_o),
		.bool_o(dut_if.bool_o)
	);

  	initial begin
  		clk = 0;
  		rstn = 1;
  		#10 rstn = 0;
  		#10 rstn = 1;
  	end

  	always #3 clk = ~clk;

  	always begin 
  		cont ++;
  		if (cont == 200) begin
  			cont = 0;
  			rstn = 0;
  			#20 rstn = 1;
  		end
  		@(posedge clk);
  	end

	initial begin
		`ifdef XCELIUM
			$recordvars();
		`endif
		`ifdef VCS
			$vcdpluson;
		`endif
		`ifdef QUESTA
			$wlfdumpvars();
			set_config_int("*", "recording_detail", 1);
		`endif

		uvm_config_db#(interface_vif)::set(uvm_root::get(), "*", "vif", dut_if);
		uvm_config_db#(interface_vif)::set(uvm_root::get(), "*", "sc_vif", sc_if);
		uvm_config_db#(int)::set(uvm_root::get(), "*", "min_trans", min_trans);

		run_test("just_pass_test");
	end

endmodule

