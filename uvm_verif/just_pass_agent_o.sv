class just_pass_agent_o extends uvm_agent;
	`uvm_component_param_utils(just_pass_agent_o)

	typedef just_pass_transaction_o transaction_type;
	typedef just_pass_driver_o driver_type;
	typedef just_pass_monitor_o monitor_type;

	uvm_analysis_port#(transaction_type) agt_just_pass_o_tr_analysis_port;
 

	driver_type driver;
	monitor_type monitor;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		agt_just_pass_o_tr_analysis_port = new("agt_just_pass_o_tr_analysis_port", this);

		driver = driver_type::type_id::create("driver", this);
		monitor = monitor_type::type_id::create("monitor", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		monitor.mon_just_pass_o_tr_analysis_port.connect(agt_just_pass_o_tr_analysis_port);
	endfunction

endclass
