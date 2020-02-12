#include "just_pass_sc2sv.h"

SC_HAS_PROCESS(just_pass_sc2sv);

just_pass_sc2sv::just_pass_sc2sv(sc_module_name nm):
	clk("clk"),
	rstn("rstn"),
	data_i("data_i"),
	bool_o("bool_o"),
	data_o("data_o"),

	arch("arch")
{
	arch.clk(clk);
	arch.rstn(rstn);
	arch.data_i(data_i);
	arch.bool_o(bool_o);
	arch.data_o(data_o);
}

XMSC_MODULE_EXPORT(just_pass_sc2sv);
