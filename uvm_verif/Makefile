IFS = ./just_pass_if.sv
INCLUDES = /usr/include/python3.4m/
INCLUEDE_CONFG = /usr/include/python3.4m/config-3.4m
PKGS = ./just_pass_pkg.sv

RTL = ../rtl/Just_Pass.sv 

MIN_TRANSA = 1000

RUN_ARGS_COMMON = -access +r -input ./shm.tcl \
		  +uvm_set_config_int=*,recording_detail,1 -coverage all -covoverwrite

sim: clean
	g++ -g -fPIC -Wall -std=c++0x ../python/py_2_c.cpp -I ${INCLUDES} -L /usr/include/python3.4m/config-3.4m -lpython3.4m -shared -o test.so
	xrun -64bit -uvm $(PKGS) $(IFS) $(RTL) just_pass_top.sv -sv_lib test.so \
		+UVM_TESTNAME=just_pass_test -covtest just_pass_test $(RUN_ARGS_COMMON) \
		-defparam just_pass_top.min_trans=$(MIN_TRANSA)

clean:
	@rm -rf INCA_libs waves.shm cov_work/ *.history *.log *.key mdv.log imc.log imc.key ncvlog_*.err *.trn *.dsn .simvision/ xcelium.d simv.daidir *.so *.o *.err *.diag

waves:
	@simvision waves.shm &