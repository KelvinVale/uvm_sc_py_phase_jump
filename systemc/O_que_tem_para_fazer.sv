O que tem para fazer :


	arch:
		-interface.h
			.Criar os templates													TODO;
			.Definir quais sinais são entradas e quais são saídas				TODO;
			.OBS: O template serve para deixar a interface "adaptável" para qualquer tipo que 
				venha a ser instanciado naquela posição. Podendo-se definir quantos bits há em cada 
				variável.

		-define.h
			.Definir parâmetros e tipos de dados			TODO;
		
		-arch.h
			.Incluir, em sequência, systemc.h -> MODULE_NAME_define.h -> MODULE_NAME_interface.h -> <queue>		TODO;
			.Criar class MODULE_NAME_arch, com todas as funções que serão usadas e o construtor					TODO;
		
		-arch.cpp
			.Incluir unicamente o MODULE_NAME_arch.h							TODO;
			.Definir as funções que foram declaradas no MODULE_NAME_arch.h		TODO;
			.OBS: No construtor deve-se definir a sensibilidade das funções declaradas !!!



	wrapper:
		-sc2sv.sv:
			.Definir a casca em sv para os sinais usados pelo sc 				TODO;
			.Usar a seguinte linha "(* integer foreign = "SystemC";
									*);", NÂO É OPCIONAL !!!!					TODO;
			OBS: Não usar o tipo do siunal, pois o mesmo está definido em sc, 
				apenas declarar se é entrada ou saída e a quantidade de bits.
		
		-sc2sv.h
			.Incluir, na seguinte sequência, "systemc.h" -> "MODULE_NAME_define.h" -> 
			"MODULE_NAME_interface.h" -> "MODULE_NAME_arch.h" 									TODO;
			.Fazer instância das entradas, saídas e do arch, além de prototipar o construtor	TODO;
		
		-sc2sv.cpp
			.Ligar as variáveis aos campos do arch 				TODO;