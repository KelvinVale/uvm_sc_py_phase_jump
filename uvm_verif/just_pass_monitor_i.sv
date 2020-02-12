class just_pass_monitor_i extends uvm_monitor;
	
	interface_vif vif;
	just_pass_transaction_i tr;
	
	event begin_record, end_record;
	
	uvm_analysis_port #(just_pass_transaction_i) mon_just_pass_i_tr_analysis_port; 
										// NomeDoModulo_NomeDaTransacao_tr_NomeDaPorta

	`uvm_component_utils(just_pass_monitor_i)

	function new(string name, uvm_component parent);
        super.new(name, parent);
        mon_just_pass_i_tr_analysis_port = new("mon_just_pass_i_tr_analysis_port", this);
    endfunction

    virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(interface_vif)::get(this, "", "vif", vif)) begin
			`uvm_fatal("NO_VIF", "just_pass_monitor_i: falha no get da interface_vif")
		end

		tr = just_pass_transaction_i::type_id::create("tr",this);	
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
		forever
		begin
			@(posedge vif.clk);
			begin_tr(tr, "just_pass_monitor_i: tr");
			tr.data_i = vif.data_i;
			end_tr(tr, "just_pass_monitor_i: tr");
			
			mon_just_pass_i_tr_analysis_port.write(tr);
		end
	endtask : monitoramento


endclass : just_pass_monitor_i
