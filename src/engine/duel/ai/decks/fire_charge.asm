AIActionTable_FireCharge:
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
	db MAGMAR_LV31
	db CHANSEY
	db DODUO
	db GROWLITHE
	db $00

.list_bench
	db DODUO
	db GROWLITHE
	db CHANSEY
	db MAGMAR_LV24
	db $00

.list_retreat
	ai_retreat CHANSEY,         2
	ai_retreat DODUO,           2
	ai_retreat DODRIO,          2
	ai_retreat GROWLITHE,       2
	db $00

.list_energy
	ai_energy GROWLITHE,       2, +0
	ai_energy ARCANINE_LV45,   4, +2
	ai_energy ARCANINE_LV34,   2, +2
	ai_energy MAGMAR_LV24,     2, +0
	ai_energy CHANSEY,         4, +0
	db $00

.list_prize
	db BILL
	db ARCANINE_LV34
	db $00

.store_list_pointers
	store_list_pointer wAICardListAvoidPrize, .list_prize
	store_list_pointer wAICardListArenaPriority, .list_arena
	store_list_pointer wAICardListBenchPriority, .list_bench
	store_list_pointer wAICardListPlayFromHandPriority, .list_bench
	store_list_pointer wAICardListRetreatBonus, .list_retreat
	store_list_pointer wAICardListEnergyBonus, .list_energy
	ret
