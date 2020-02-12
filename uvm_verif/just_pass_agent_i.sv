typedef uvm_sequencer#(just_pass_transaction_i) sequencer_type;


class just_pass_agent_i extends uvm_agent;
	`uvm_component_param_utils(just_pass_agent_i)

	typedef just_pass_transaction_i transaction_type;
	typedef just_pass_driver_i driver_type;
	typedef just_pass_monitor_i monitor_type;

	uvm_analysis_port#(transaction_type) agt_just_pass_i_tr_analysis_port;

	sequencer_type sequencer;
	driver_type driver;
	monitor_type monitor;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		agt_just_pass_i_tr_analysis_port = new("agt_just_pass_i_tr_analysis_port", this);

		sequencer = sequencer_type::type_id::create("sequencer", this);
		driver = driver_type::type_id::create("driver", this);
		monitor = monitor_type::type_id::create("monitor", this);
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		driver.seq_item_port.connect(sequencer.seq_item_export);
		monitor.mon_just_pass_i_tr_analysis_port.connect(agt_just_pass_i_tr_analysis_port);

	endfunction

	task pre_reset_phase(uvm_phase phase);
		phase.raise_objection(this);
			sequencer.stop_sequences();
		phase.drop_objection(this);
	endtask : pre_reset_phase

endclass
