class just_pass_transaction_i extends uvm_sequence_item;
	rand logic unsigned [7:0] data_i;

	`uvm_object_utils_begin(just_pass_transaction_i)
		`uvm_field_int(data_i, UVM_ALL_ON|UVM_HEX)
	`uvm_object_utils_end

	function new(string name = "just_pass_transaction_i");
		super.new(name);	
	endfunction : new

	function string convert2string();
		return $sformatf("{data_i = %h}",data_i);
	endfunction

	function void do_copy(uvm_object rhs);
        just_pass_transaction_i rhs_;

        if(!$cast(rhs_, rhs)) begin
          `uvm_fatal("do_copy", "cast of rhs object failed")
        end
        super.do_copy(rhs);
        data_i = rhs_.data_i;
    endfunction : do_copy

endclass : just_pass_transaction_i
