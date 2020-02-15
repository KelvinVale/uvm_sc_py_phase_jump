class just_pass_scoreboard extends uvm_scoreboard;

  typedef just_pass_transaction_o transa_o;
  typedef just_pass_transaction_i transa_i;
  typedef child_comparator #(transa_o) comp_type;
  just_pass_refmod rfm;
  comp_type comp;
  // comp_type comp_sc;

  uvm_analysis_port #(transa_o) to_comp_sc_analysis_port;
  
  uvm_analysis_port #(transa_o) to_comp_analysis_port;
  uvm_analysis_port #(transa_i) to_rfm_analysis_port;

  `uvm_component_utils(just_pass_scoreboard)

  function new(string name = "translator", uvm_component parent = null);
    super.new(name, parent);
    to_comp_analysis_port = new("to_comp_analysis_port", this);
    to_rfm_analysis_port = new("to_rfm_analysis_port", this);

    to_comp_sc_analysis_port = new("to_comp_sc_analysis_port", this);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rfm = just_pass_refmod::type_id::create("rfm", this);
    comp = comp_type::type_id::create("comp", this);
    // comp_sc = comp_type::type_id::create("comp_sc", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // to_comp_sc_analysis_port.connect(comp_sc.before_export);
    // to_comp_analysis_port.connect(comp_sc.after_export);
    
    rfm.refmod_just_pass_o_tr_analysis_port.connect(comp.from_refmod);
    to_comp_analysis_port.connect(comp.from_rtl);
    to_comp_sc_analysis_port.connect(comp.from_sc);
    
    to_rfm_analysis_port.connect(rfm.refmod_just_pass_i_tr_analysis_imp);
  endfunction

  task pre_reset_phase(uvm_phase phase);
    phase.raise_objection(this);
      // comp.flush();
    phase.drop_objection(this);
  endtask : pre_reset_phase

endclass : just_pass_scoreboard
