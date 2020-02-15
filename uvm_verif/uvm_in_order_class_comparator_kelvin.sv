class uvm_in_order_class_comparator_kelvin #( type T = int )
  extends uvm_in_order_comparator_kelvin #( T , 
                                     uvm_class_comp #( T ) , 
                                     uvm_class_converter #( T ) , 
                                     uvm_class_pair #( T, T ) );
  int cont = 0;
  typedef uvm_in_order_class_comparator_kelvin #(T) this_type;
  `uvm_component_param_utils(this_type)

  const static string type_name = "uvm_in_order_class_comparator_kelvin #(T)";

  function new( string name  , uvm_component parent);
    super.new( name, parent );
  endfunction
  
  virtual function string get_type_name ();
    return type_name;
  endfunction

  function void flush();
    super.flush();
    m_before_fifo.flush();
    m_after_fifo.flush();
  endfunction

endclass