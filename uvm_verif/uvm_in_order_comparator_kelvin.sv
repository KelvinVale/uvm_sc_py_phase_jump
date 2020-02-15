 class parent_comparator 
     #( type T = int ,
        type comp_type = uvm_built_in_comp #( T ) ,
        type convert = uvm_built_in_converter #( T ) , 
        type pair_type = uvm_built_in_pair #( T ) )
       extends uvm_component;
   
     typedef parent_comparator #(T,comp_type,convert,pair_type) this_type;
     `uvm_component_param_utils(this_type)
   
     const static string type_name = 
       "parent_comparator #(T,comp_type,convert,pair_type)";

     uvm_analysis_export #(T) from_refmod;
     uvm_analysis_export #(T) from_rtl;
     uvm_analysis_export #(T) from_sc;

    uvm_analysis_port   #(pair_type) pair_ap;
    
    local uvm_tlm_analysis_fifo #(T) from_refmod_fifo;
    local uvm_tlm_analysis_fifo #(T) from_rtl_fifo;
    local uvm_tlm_analysis_fifo #(T) from_sc_fifo;
  
    int m_matches_sc, m_mismatches_sc;
    int m_matches_ref, m_mismatches_ref;
  
    function new(string name, uvm_component parent);
  
      super.new(name, parent);
  
      from_refmod = new("from_refmod", this);
      from_rtl  = new("from_rtl", this);
      from_sc = new("from_sc", this);

      pair_ap       = new("pair_ap", this);
  
      from_refmod_fifo = new("from_refmod_fifo", this);
      from_rtl_fifo  = new("from_rtl_fifo", this);
      from_sc_fifo  = new("from_sc_fifo", this);
      
      m_matches_sc = 0;
      m_mismatches_sc = 0;
      m_matches_ref = 0;
      m_mismatches_ref = 0;
  
    endfunction
    
    virtual function string get_type_name();
      return type_name;
    endfunction
  
    virtual function void connect_phase(uvm_phase phase);
      from_refmod.connect(from_refmod_fifo.analysis_export);
      from_rtl.connect(from_rtl_fifo.analysis_export);
      from_sc.connect(from_sc_fifo.analysis_export);
    endfunction

    task pre_reset_phase(uvm_phase phase);
      phase.raise_objection(this);
        flush();
      phase.drop_objection(this);
    endtask : pre_reset_phase

    virtual task main_phase(uvm_phase phase);
   
      pair_type pair;

      T refmod;
      T rtl;
      T sc;
      string s;

      forever begin
        from_refmod_fifo.get(refmod);
        from_rtl_fifo.get(rtl);
        from_sc_fifo.get(sc);
        
        //Compara transação do rtl com o refmod
        if(!comp_type::comp(refmod, rtl)) begin
  
          $sformat(s, "%s (from refmod) differs from %s (from rtl)", convert::convert2string(refmod),
                                            convert::convert2string(rtl));
  
          uvm_report_warning("Comparator Mismatch REFMODxRTL", s);
  
          m_mismatches_ref++;
  
        end
        else begin
          s = convert::convert2string(rtl);
          uvm_report_info("Comparator Match REFMODxRTL", s);
          m_matches_ref++;
        end

        //Compara transação do rtl com o SystemC
        if(!comp_type::comp(sc, rtl)) begin
  
          $sformat(s, "%s (from SystemC) differs from %s (from rtl)", convert::convert2string(sc),
                                            convert::convert2string(rtl));
  
          uvm_report_warning("Comparator Mismatch SYSTEMCxRTL", s);
  
          m_mismatches_sc++;
  
        end
        else begin
          s = convert::convert2string(rtl);
          uvm_report_info("Comparator Match SYSTEMCxRTL", s);
          m_matches_sc++;
        end
  

        // we make the assumption here that a transaction "sent for
        // analysis" is safe from being edited by another process.
        // Hence, it is safe not to clone refmod and rtl.
        pair = new("after/before");
        pair.first = refmod;
        pair.second = rtl;
        pair_ap.write(pair);
      end
    
    endtask
    
    virtual function void flush();
      from_refmod_fifo.flush();
      from_rtl_fifo.flush();
      from_sc_fifo.flush();
      $display("All Fifos Were Cleaned");
      
      m_mismatches_ref = 0;
      m_matches_ref = 0;
      m_mismatches_sc = 0;
      m_matches_sc = 0;
    endfunction
    
  endclass


class child_comparator #( type T = int )
  extends parent_comparator #( T , 
                                     uvm_class_comp #( T ) , 
                                     uvm_class_converter #( T ) , 
                                     uvm_class_pair #( T, T ) );

  typedef child_comparator #(T) this_type;
  `uvm_component_param_utils(this_type)

  const static string type_name = "child_comparator #(T)";

  function new( string name  , uvm_component parent);
    super.new( name, parent );
  endfunction
  
  virtual function string get_type_name ();
    return type_name;
  endfunction

  function void flush();
    super.flush();
  endfunction

endclass