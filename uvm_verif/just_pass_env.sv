class just_pass_env extends uvm_env;
	`uvm_component_utils(just_pass_env)

	just_pass_agent_i agent_i;
	just_pass_agent_o agent_o;
	just_pass_agent_sc_o agent_sc_o;

	just_pass_scoreboard scoreboard;

	just_pass_cover cobertura;

	function new(string name, uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agent_i = just_pass_agent_i::type_id::create("agent_i", this);
		agent_o = just_pass_agent_o::type_id::create("agent_o", this);
		agent_sc_o = just_pass_agent_sc_o::type_id::create("agent_sc_o", this);

		scoreboard = just_pass_scoreboard::type_id::create("scoreboard", this);

		cobertura = just_pass_cover::type_id::create("cobertura", this);
	endfunction : build_phase

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		//agent_i
		agent_i.agt_just_pass_i_tr_analysis_port.connect(scoreboard.to_rfm_analysis_port);

		//agent_o
		agent_o.agt_just_pass_o_tr_analysis_port.connect(cobertura.resp_port);
		agent_o.agt_just_pass_o_tr_analysis_port.connect(scoreboard.to_comp_analysis_port);
		
		//agent_sc_o
		agent_sc_o.agt_just_pass_o_tr_analysis_port.connect(scoreboard.to_comp_sc_analysis_port);
	endfunction : connect_phase

	virtual function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
	endfunction : end_of_elaboration_phase

endclass : just_pass_env
