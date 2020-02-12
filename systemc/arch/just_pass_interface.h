#ifndef _JUST_PASS_INTERFACE_H_
#define _JUST_PASS_INTERFACE_H_

template<
	typename JUST_PASS_DATA,
	typename BOOL_TEMPLATE>

SC_MODULE(just_pass_interface)
{
    sc_in<BOOL_TEMPLATE> clk;
    sc_in<BOOL_TEMPLATE> rstn;
    sc_in<JUST_PASS_DATA> data_i;

    sc_out<BOOL_TEMPLATE> bool_o;
    sc_out<JUST_PASS_DATA> data_o;

    just_pass_interface(sc_module_name mn) : sc_module(mn),
		clk("clk"),
		rstn("rstn"),
		data_i("data_i"),
		bool_o("bool_o"),
		data_o("data_o")
	{
	}
};

#endif