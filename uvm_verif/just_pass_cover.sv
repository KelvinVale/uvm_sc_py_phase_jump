
class just_pass_cover extends uvm_component;

  `uvm_component_utils(just_pass_cover)
  just_pass_transaction_o resp;
  uvm_analysis_imp#(just_pass_transaction_o, just_pass_cover) resp_port;

  int cont = 0;
  int limite;

 // ==========================  COBERTURA DAS RESPOSTAS =====================================
  covergroup resp_cover;
    option.per_instance = 1;
    option.at_least = 1;
    resp_saida:coverpoint resp.data_o{
      bins pode[] = {[0:$]};
    }
  endgroup // resp_cover

  function new(string name = "subscriber", uvm_component parent= null);
    super.new(name, parent);
    resp_port   = new("resp_port", this);
    resp_cover  = new;
    resp        = new;

  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase (phase);
    uvm_config_db#(int)::get(this, "", "min_trans", limite);
  endfunction

  // protected uvm_phase running_phase = uvm_main_phase::get();
  // task main_phase(uvm_phase phase);
  //   running_phase = phase;
  // endtask : main_phase
  // task run_phase(uvm_phase phase);
  //   running_phase = phase;
  //   running_phase.raise_objection(this);
  // endtask: run_phase

  //============= Função para copiar transações do agent (Respostas) ========================
  function void write (just_pass_transaction_o t);
    cont ++;
    resp.copy(t);
    resp_cover.sample();

    //$display("cobertura:%d",$get_coverage());
    if((cont == 30000))
      uvm_main_phase::get().drop_objection(this);
  endfunction: write
endclass : just_pass_cover
