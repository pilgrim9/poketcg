AIActionTable_GoGoRainDance:
	dw .do_turn ; unused
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize

.do_turn
	call AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .store_list_pointers
	call SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call AIDecideBenchPokemonToSwitchTo
	ret

.ko_switch
	call AIDecideBenchPokemonToSwitchTo
	ret

.take_prize
	call AIPickPrizeCards
	ret

.list_arena
	db LAPRAS
	db SQUIRTLE
	db MAGIKARP
	db SQUIRTLE
	db $00

.list_bench
	db MAGIKARP
	db SQUIRTLE
	db LAPRAS
	db $00

.list_retreat
	ai_retreat MAGIKARP,  0
	ai_retreat SQUIRTLE,  3
	ai_retreat WARTORTLE, 3
	ai_retreat LAPRAS, 4
	ai_retreat BLASTOISE, 8
	ai_retreat GYARADOS,  10
	db $00

.list_energy
	ai_energy SQUIRTLE,  1, +0
	ai_energy WARTORTLE, 0, +0
	ai_energy BLASTOISE, 5, +5
	ai_energy GYARADOS,  4, +10
	ai_energy MAGIKARP,  2, +3
	ai_energy LAPRAS,    2, +2
	db $00

.list_prize
	db ENERGY_RETRIEVAL
	db GYARADOS
	db BLASTOISE
	db SQUIRTLE
	db WARTORTLE
	db BILL
	db $00

.store_list_pointers
	store_list_pointer wAICardListAvoidPrize, .list_prize
	store_list_pointer wAICardListArenaPriority, .list_arena
	store_list_pointer wAICardListBenchPriority, .list_bench
	store_list_pointer wAICardListPlayFromHandPriority, .list_bench
	store_list_pointer wAICardListRetreatBonus, .list_retreat
	store_list_pointer wAICardListEnergyBonus, .list_energy
	ret
