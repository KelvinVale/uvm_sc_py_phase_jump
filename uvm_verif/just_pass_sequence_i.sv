class just_pass_sequence_i extends uvm_sequence#(just_pass_transaction_i);

	`uvm_object_param_utils(just_pass_sequence_i)

	typedef just_pass_transaction_i transaction_type;

	function new(string name = "");
		super.new(name);
	endfunction

	task body();
		transaction_type tr;
		forever begin
			tr = transaction_type::type_id::create("tr");
			start_item(tr);
				assert(tr.randomize());
			finish_item(tr);
		end
	endtask
endclass : just_pass_sequence_i