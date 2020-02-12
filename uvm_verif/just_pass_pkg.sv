package just_pass_pkg;
	`include "uvm_macros.svh"
	import uvm_pkg::*;

`include "../uvm_verif/just_pass_transaction_i.sv"
`include "../uvm_verif/just_pass_transaction_o.sv"
`include "../uvm_verif/just_pass_sequence_i.sv"

`include "../uvm_verif/just_pass_driver_i.sv"
`include "../uvm_verif/just_pass_driver_o.sv"
`include "../uvm_verif/just_pass_driver_sc_o.sv"
`include "../uvm_verif/just_pass_monitor_i.sv"
`include "../uvm_verif/just_pass_monitor_o.sv"
`include "../uvm_verif/just_pass_monitor_sc_o.sv"
`include "../uvm_verif/just_pass_agent_i.sv"
`include "../uvm_verif/just_pass_agent_o.sv"
`include "../uvm_verif/just_pass_agent_sc_o.sv"

`include "../uvm_verif/just_pass_refmod.sv"
`include "../uvm_verif/just_pass_cover.sv"
`include "../uvm_verif/just_pass_scoreboard.sv"
`include "../uvm_verif/just_pass_env.sv"
`include "../uvm_verif/just_pass_test.sv" //SE LIGUE SA SEQUÊNCIA QUE SÃO COLOCADOS !!!!!!!!! 
								  //SE ALGUEM CHAMA ALGO, ESSE ALGO DEVE ESTAR ACIMA DESSE ALGUEM !!!!!!

endpackage : just_pass_pkg