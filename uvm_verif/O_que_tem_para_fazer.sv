O que tem para fazer :


	agents:
		-agent_in
			.interfacee			DONE;
			.transaction		DONE;
			.sequence			DONE;
			.driver				DONE;
			.monitor			DONE;
			.sequencer			DONE;
			.montar_agent		DONE;

		-agent_out
			.interfacee			DONE;
			.transaction		DONE;
			.driver				DONE;
			.monitor			DONE;
			.montar_agent		DONE;

	scoreboard:
		-refmods
			.refmod.py				DONE;
			.refmod.sv				DONE;
		-comparador					DONE;
		-montar_scoreboard			DONE;

	env:
		-agents						DONE;
		-scoreboard					DONE;
		-cobertura					DONE;
		-montar_env					DONE;

	teste:
		-env 						DONE;
		-montar_teste				DONE; //Ativar a sequência !!!!

	top:
		-dut						DONE;
		-pkg						DONE;
		-montar_top					DONE;



	phase_jump:
		-Criar as fases nos drivers, monitors, teste, refmod, agents com sequencer -parar a sequência-.
			.driver_i.sv				DONE;
			.driver_o.sv				DONE;
			.monitor_i.sv				DONE;
			.monitor_o.sv				DONE;
			.refmod						DONE;
			.teste 						DONE;
			.agent_in					DONE;



	Ligando SystemC:
		-Instanciar uma nova interface do mesmo tipo do DUT no topo 	DONE;

		-Criar Agent out (mon_out e driver_out) para o bloco SystemC;
			.driver_sc_o.sv												DONE;
			.monitor_sc_o.sv											DONE;
			.agent_sc_o													DONE;

		-Criar novo comparador dentro do scoreboard e nova porta para tal;
			.porta_para_SC 												DONE;
			.comparador 												DONE;

		-Instanciar o novo agent;
			.Instanciar agent_sc no env 								DONE;




