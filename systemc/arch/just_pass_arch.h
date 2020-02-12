#ifndef _JUST_PASS_ARCH_DEFINE_H_
#define _JUST_PASS_ARCH_DEFINE_H_

#define SC_INCLUDE_FX

#include "systemc.h"
#include "just_pass_define.h"
#include "just_pass_interface.h"
#include <queue>

class just_pass_arch : public just_pass_interface<
	just_pass_data_type_t, bool>
{

public:
	void reset();

	void run();

	just_pass_arch(sc_module_name nm);
};

#endif
