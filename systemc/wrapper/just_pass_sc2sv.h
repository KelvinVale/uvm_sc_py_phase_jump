#define SC_INCLUDE_FX

#ifndef _JUST_PASS_SC2SV_H_
#define _JUST_PASS_SC2SV_H_


#include "systemc.h"
#include "../arch/just_pass_define.h"
#include "../arch/just_pass_interface.h"
#include "../arch/just_pass_arch.h"



SC_MODULE(just_pass_sc2sv)
{

    sc_in<bool> clk;
    sc_in<bool> rstn;
    sc_in<just_pass_data_type_t> data_i;

    sc_out<bool> bool_o;
    sc_out<just_pass_data_type_t> data_o;

    just_pass_arch arch;

    just_pass_sc2sv(sc_module_name nm);
};








#endif