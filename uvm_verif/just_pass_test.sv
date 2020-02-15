class just_pass_test extends uvm_test;
  just_pass_env env;
  just_pass_sequence_i seq;

  interface_vif vif;

  `uvm_component_utils(just_pass_test)

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = just_pass_env::type_id::create("env", this);
    seq = just_pass_sequence_i::type_id::create("seq", this);

    if(!uvm_config_db#(interface_vif)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "failed to get virtual interface")
    end
  endfunction
 
  task main_phase(uvm_phase phase);
    phase.raise_objection(this);
    fork
      seq.start(env.agent_i.sequencer);
      
      forever 
      begin 
        @(negedge vif.rstn)
        // #1;
        phase.jump(uvm_pre_reset_phase::get());
      end
    join
    
  endtask : main_phase

endclass : just_pass_test