class just_pass_transaction_o extends uvm_sequence_item;
	rand logic unsigned [7:0] 	data_o;
	rand logic unsigned			bool_o;

	`uvm_object_utils_begin(just_pass_transaction_o)
		`uvm_field_int(data_o, UVM_ALL_ON|UVM_HEX)
		`uvm_field_int(bool_o, UVM_ALL_ON|UVM_HEX)
	`uvm_object_utils_end

	function new(string name = "just_pass_transaction_o");
		super.new(name);	
	endfunction : new

	function string convert2string();
		return $sformatf("{data_o = %h, bool_o = %h}", data_o, bool_o);
	endfunction

	function void do_copy(uvm_object rhs);
        just_pass_transaction_o rhs_;

        if(!$cast(rhs_, rhs)) begin
          `uvm_fatal("do_copy", "cast of rhs object failed")
        end
        super.do_copy(rhs);
        data_o = rhs_.data_o;
        bool_o = rhs_.bool_o;
    endfunction : do_copy

endclass : just_pass_transaction_o
