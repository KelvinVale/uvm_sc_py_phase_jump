
#include "just_pass_arch.h"

SC_HAS_PROCESS(just_pass_arch);

just_pass_arch::just_pass_arch(sc_module_name nm):
    just_pass_interface<
    just_pass_data_type_t, bool>(nm)

{
    SC_METHOD(reset); 
        sensitive << rstn.neg();

    SC_METHOD(run); 
        sensitive << clk.pos();
}

void just_pass_arch::reset()
{
    bool_o  =   0;
    data_o  =   0;
    return;
}


void just_pass_arch::run() 
{
    if (rstn == 1)
    {
        data_o = data_i;
        if (bool_o == 0)
        {
            bool_o = 1;
        }
        else
        {
            bool_o = 0;
        }
    }
    return;
}
