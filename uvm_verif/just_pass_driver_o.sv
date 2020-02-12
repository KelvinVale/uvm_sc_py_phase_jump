//typedef virtual just_pass_if.mst interface_vif;

class just_pass_driver_o extends uvm_driver#(just_pass_transaction_o);
	`uvm_component_param_utils(just_pass_driver_o)
	
	typedef just_pass_transaction_o tr_type;

	interface_vif vif;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(interface_vif)::get(this, "", "vif", vif)) begin
			`uvm_fatal("NOVIF", "failed to get virtual interface")
		end
	endfunction

	function void connect_phase (uvm_phase phase);
		super.connect_phase(phase);
	endfunction

	task reset_phase(uvm_phase phase);
		phase.raise_objection(this);
			//Nothing to do here.
		phase.drop_objection(this);
	endtask : reset_phase

endclass