
typedef struct {
  int a;
  int b;
} DpiStructGEN;

import "DPI-C" context gen_init_python = function gen_init_sv();
import "DPI-C" context gen_set_param = function gen_sv_set_param (inout DpiStructGEN dpiStruct);
import "DPI-C" context just_pass_val = function int gen_sv_pass_val(inout DpiStructGEN dpiStruct);
import "DPI-C" context just_pass_bool = function int gen_sv_pass_bool(inout DpiStructGEN dpiStruct);

DpiStructGEN dpiStruct;

class just_pass_refmod extends uvm_component;
  `uvm_component_utils(just_pass_refmod)

  typedef just_pass_transaction_i tr_type_in;
  typedef just_pass_transaction_o tr_type_out;

  tr_type_in tr_in;
  tr_type_out tr_out;

  uvm_analysis_imp #(tr_type_in, just_pass_refmod) refmod_just_pass_i_tr_analysis_imp;
  uvm_analysis_port #(tr_type_out) refmod_just_pass_o_tr_analysis_port;
  
  event begin_record, end_record, begin_refmodtask;

  int val_passado, bool_passado;

  
//======================= Construtor =======================================
  function new(string name = "just_pass_refmod", uvm_component parent);
    super.new(name, parent);
    refmod_just_pass_i_tr_analysis_imp = new("refmod_just_pass_i_tr_analysis_imp", this);
    refmod_just_pass_o_tr_analysis_port = new("refmod_just_pass_o_tr_analysis_port", this);

    void'(gen_init_sv());
  endfunction

//====================== Build Phase =======================================
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction: build_phase

//======================= Run Phase ========================================
  
  task reset_phase(uvm_phase phase);
    phase.raise_objection(this);
    val_passado = 0;
    bool_passado = 0;


      dpiStruct.a = 0;
      dpiStruct.b = 0;
      gen_sv_set_param(dpiStruct);
      dpiStruct.a = 0;
      dpiStruct.b = 0;
      gen_sv_set_param(dpiStruct);
      dpiStruct.a = 0;
      dpiStruct.b = 0;
      gen_sv_set_param(dpiStruct);
    phase.drop_objection(this);
  endtask : reset_phase

  task main_phase(uvm_phase phase);

      fork
        refmod_task();
      join
  endtask : main_phase

//============ Função para copiar transações do agent ======================
  virtual function write ( tr_type_in t);
    tr_in = tr_type_in::type_id::create("tr_in", this);
    tr_in.copy(t);

      begin_tr(tr_out, "rfm");
   -> begin_refmodtask;
  endfunction

//============ Função para analisar leitura/escrita ========================
  task refmod_task();
    forever 
    begin
      tr_out = null;
      tr_out = tr_type_out::type_id::create("tr_out", this);
      @begin_refmodtask;
        dpiStruct.a = tr_in.data_i;

        tr_out.data_o = gen_sv_pass_val(dpiStruct);
        tr_out.bool_o = gen_sv_pass_bool(dpiStruct);
      end_tr(tr_out, "rfm");
        // #1;
      refmod_just_pass_o_tr_analysis_port.write(tr_out);
    end
  endtask

endclass: just_pass_refmod
