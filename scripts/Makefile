SYSTEMC_HOME = /usr/local/systemc232
PATH_PARA_O_ARQUIVO_SYSTEMC = ../systemc

INCLUDES 		= /usr/include/python3.4m/
INCLUEDE_CONFG 	= /usr/include/python3.4m/config-3.4m

IFS 			= ../uvm_verif/just_pass_if.sv
PKGS 			= ../uvm_verif/just_pass_pkg.sv
RTL = ../rtl/Just_Pass.sv 

MIN_TRANSA = 1000

NOME_DO_TESTE = just_pass_test
RUN_ARGS_COMMON = 	+UVM_TESTNAME=$(NOME_DO_TESTE) -covtest $(NOME_DO_TESTE) \
					+uvm_set_config_int=*,recording_detail,1 -coverage all -covoverwrite

SYSTEMC_CPP = 	../systemc/wrapper/just_pass_sc2sv.cpp \
				../systemc/arch/just_pass_arch.cpp

ARQUIVO_DE_TOPO = ../uvm_verif/just_pass_top.sv

run: all

all:
	g++ -g -fPIC -Wall -std=c++0x ../python/py_2_c.cpp -I ${INCLUDES} -L \
		/usr/include/python3.4m/config-3.4m -lpython3.4m -shared -o test.so
	xrun -smartlib -uvm $(PKGS) $(IFS) $(RTL) $(SYSTEMC_CPP) -sv_lib test.so\
		-smartorder -access +rwc -licqueue -64bit -sv \
		-SC_MAIN_STACKSIZE 0x4000000 -SC_THREAD_STACKSIZE 0x4000000 -sysc -v200x \
		-timescale 1ns/1ps -lic_used -errtcl_verbose -status -mccodegen -mcl -nxmbind -dpi -dpiheader \
		 dpi_header.txt -dpiimpheader dpi_imp_haeder.txt -format off -dumpstack -xceligen on \
		-I$(SYSTEMC_HOME)/include -L$(SYSTEMC_HOME)/lib-linux64 \
		-I$(PATH_PARA_O_ARQUIVO_SYSTEMC)/arch\
		-I$(PATH_PARA_O_ARQUIVO_SYSTEMC)/arch/just_pass_arch.cpp \
		$(RUN_ARGS_COMMON) -input shm.tcl $(ARQUIVO_DE_TOPO)\
		-defparam just_pass_top.min_trans=$(MIN_TRANSA)

create:
	@echo "database -open waves -shm" >> shm.tcl
	@echo "probe -create  Topo -depth all -all -memories -shm -database waves" >> shm.tcl
	@echo "run" >> shm.tcl
	@echo "exit" >> shm.tcl
	
waves: 
	simvision waves.shm	

simulate: all 

synthesize:
	rc -f rtl.tcl

clean_reports:
	rm -r reports*
clean:
	rm -rf xcelium.d INCA_libs xrun.* *.shm *.dsn *.trn *.ucm ncvlog_*.err imc.key .simvision
	rm -r  mapped* rc* fv libscore_work script
