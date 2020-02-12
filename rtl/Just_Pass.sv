module Just_Pass (
	clk,
	rstn,
	data_i,
	data_o,
	bool_o
);
input clk;
input rstn;
input logic		[7:0] 	data_i;

output logic	[7:0] 	data_o;
output logic 			bool_o;


always_ff @(posedge clk or negedge rstn)
begin
	if(~rstn)
	begin
		data_o		<= '0;
		bool_o		<= '0;
	end
	else
	begin
		bool_o <= ~bool_o;
		data_o <= data_i;
	end
end

endmodule