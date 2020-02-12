class just_pass_monitor_sc_o extends uvm_monitor;
	
	just_pass_transaction_o tr;
	interface_vif vif;
	
	event begin_record, end_record;
	
	uvm_analysis_port #(just_pass_transaction_o) mon_just_pass_o_tr_analysis_port; 
										// NomeDoModulo_NomeDaTransacao_tr_NomeDaPorta

	`uvm_component_utils(just_pass_monitor_sc_o)

	function new(string name, uvm_component parent);
        super.new(name, parent);
        mon_just_pass_o_tr_analysis_port = new("mon_just_pass_o_tr_analysis_port", this);
    endfunction

    virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		assert (uvm_config_db#(interface_vif)::get(this, "", "sc_vif", vif))
			else `uvm_fatal("NO_VIF", "just_pass_monitor_sc_o: failed to get interface_vif at Monitor_SC module");

		tr = just_pass_transaction_o::type_id::create("tr",this);	
	endfunction : build_phase
	
	task reset_phase(uvm_phase phase);
		phase.raise_objection(this);
		//Nothing to do here!
		phase.drop_objection(this);
	endtask : reset_phase

	task main_phase(uvm_phase phase);
		fork
			monitoramento();
		join
	endtask : main_phase

	virtual task monitoramento();
		// @(posedge vif.clk);
		forever
		begin
			@(posedge vif.clk);
			#1;
			begin_tr(tr, "just_pass_monitor_sc_o: tr");
			tr.data_o = vif.data_o;
			tr.bool_o = vif.bool_o;
			end_tr(tr, "just_pass_monitor_sc_o: tr");
			mon_just_pass_o_tr_analysis_port.write(tr);
		end
	endtask : monitoramento

endclass : just_pass_monitor_sc_o


//vif.valid_o
//vif.ready_o
//vif.data_out_o
