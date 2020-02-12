`timescale 1ns/10ps
`include "../systemc/wrapper/just_pass_sc2sv.sv"

module Topo ();

parameter DATA_WIDTH = 8;

  logic clk = '0;
  logic rstn = 1;
  logic [DATA_WIDTH-1:0] data_i;

  
  logic bool_o_sc;
  logic [DATA_WIDTH-1:0] data_o_sc;

  logic bool_o_rtl;
  logic [DATA_WIDTH-1:0] data_o_rtl;
  
just_pass_sc2sv sc_dut (
  .clk(clk),
  .rstn(rstn),
  .data_i(data_i),
  .bool_o(bool_o_sc),
  .data_o(data_o_sc)
);

Just_Pass rtl_dut (
  .clk(clk),
  .rstn(rstn),
  .data_i(data_i),
  .bool_o(bool_o_rtl),
  .data_o(data_o_rtl)
);

  always #1 clk <= !clk;
    initial
      begin
        #1 $display("Teste 0");
        #11 rstn = '0;
        #20 rstn = '1;
        #300;
        $finish();
      end

  always @(posedge clk)
  begin
    data_i <= $urandom();
  end

endmodule
