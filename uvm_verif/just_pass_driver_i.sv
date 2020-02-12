typedef virtual just_pass_if interface_vif;


class just_pass_driver_i extends uvm_driver#(just_pass_transaction_i);
	`uvm_component_param_utils(just_pass_driver_i)
	
	typedef just_pass_transaction_i tr_type;

	interface_vif vif;
	tr_type tr;

	event reset_feito, begin_record, end_record;

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
		wait(vif.rstn === '0);
			tr = null;
			vif.data_i		= '0;
		@(posedge vif.rstn);
		phase.drop_objection(this);
	endtask : reset_phase

	task main_phase(uvm_phase phase);
		fork
			get_and_drive(phase);
		join
	endtask : main_phase

	virtual task get_and_drive(uvm_phase phase);
        forever begin
            seq_item_port.try_next_item(tr);
            begin_tr(tr, "just_pass_driver");
            drive_transfer();
        end
    endtask : get_and_drive

	virtual task drive_transfer();
		@(posedge vif.clk);
		vif.data_i		<= tr.data_i;
		end_tr(tr, "just_pass_driver");

		seq_item_port.item_done();
	endtask : drive_transfer

endclass