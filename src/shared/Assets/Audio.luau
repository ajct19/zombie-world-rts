-- BioFront audio manifest (built-in rbxasset://sounds + verified Roblox Creator Store SFX/music).
-- sfx entries are {id, length}, or {sprite, start, stop, length} for audio-sprite regions.
return {
	music = {
		menu = { id = "rbxassetid://9046503137", length = 110.498 },
		war = { id = "rbxassetid://1847568713", length = 96.975 },
	},
	sfx = {
		-- Short UI / pops
		ui_click = { sprite = "rbxasset://sounds/volume_slider.ogg", start = 0, stop = 0.12, length = 0.12 },
		ui_hover = { sprite = "rbxasset://sounds/volume_slider.ogg", start = 0, stop = 0.12, length = 0.12 },
		ui_tab = { sprite = "rbxasset://sounds/volume_slider.ogg", start = 0, stop = 0.12, length = 0.12 },
		star_tick = { sprite = "rbxasset://sounds/volume_slider.ogg", start = 0, stop = 0.12, length = 0.12 },
		countdown_tick = { sprite = "rbxasset://sounds/volume_slider.ogg", start = 0, stop = 0.12, length = 0.12 },
		order_ack = { sprite = "rbxasset://sounds/volume_slider.ogg", start = 0, stop = 0.24, length = 0.24 },

		expand_pop = { id = "rbxasset://sounds/action_jump_land.mp3", length = 0.261 },
		expand = { id = "rbxasset://sounds/action_jump_land.mp3", length = 0.261 },
		ui_back = { id = "rbxasset://sounds/action_jump_land.mp3", length = 0.261 },
		ui_locked = { id = "rbxasset://sounds/action_jump_land.mp3", length = 0.261 },
		spectate_switch = { id = "rbxasset://sounds/action_jump_land.mp3", length = 0.261 },

		card_whoosh = { id = "rbxasset://sounds/action_jump.mp3", length = 0.34 },
		sam_launch = { id = "rbxasset://sounds/action_jump.mp3", length = 0.34 },
		attack_launch = { id = "rbxasset://sounds/action_jump.mp3", length = 0.34 },

		card_flip = { id = "rbxasset://sounds/action_get_up.mp3", length = 0.575 },
		ui_open = { id = "rbxasset://sounds/action_get_up.mp3", length = 0.575 },
		build = { id = "rbxasset://sounds/action_get_up.mp3", length = 0.575 },
		crate_rattle = { id = "rbxasset://sounds/action_get_up.mp3", length = 0.575 },

		ui_confirm = { id = "rbxassetid://9125540237", length = 0.327 },
		ui_error = { id = "rbxassetid://9125540237", length = 0.327 },
		ally_request = { id = "rbxassetid://9125540237", length = 0.327 },
		queue_start = { id = "rbxassetid://9125540237", length = 0.327 },
		spawn_confirm = { id = "rbxassetid://9125540237", length = 0.327 },
		countdown_tick_1 = { id = "rbxassetid://9125540237", length = 0.327 },
		countdown_tick_2 = { id = "rbxassetid://9125540237", length = 0.327 },
		countdown_tick_3 = { id = "rbxassetid://9125540237", length = 0.327 },
		countdown_tick_4 = { id = "rbxassetid://9125540237", length = 0.327 },
		countdown_tick_5 = { id = "rbxassetid://9125540237", length = 0.327 },

		-- Combat / naval / alarms / stings
		boat_launch = { id = "rbxasset://sounds/impact_water.mp3", length = 2.377 },
		warship = { id = "rbxasset://sounds/impact_water.mp3", length = 2.377 },
		shell_splash = { id = "rbxasset://sounds/impact_water.mp3", length = 2.377 },
		ship_sink = { id = "rbxasset://sounds/impact_water.mp3", length = 2.377 },

		shell_fire = { id = "rbxasset://sounds/impact_explosion_03.mp3", length = 2.586 },
		shell_hit = { id = "rbxasset://sounds/impact_explosion_03.mp3", length = 2.586 },
		sam_intercept = { id = "rbxasset://sounds/impact_explosion_03.mp3", length = 2.586 },
		eliminate = { id = "rbxasset://sounds/impact_explosion_03.mp3", length = 2.586 },
		crate_drop = { id = "rbxasset://sounds/impact_explosion_03.mp3", length = 2.586 },
		crate_land = { id = "rbxasset://sounds/impact_explosion_03.mp3", length = 2.586 },

		nuke_explosion = { id = "rbxassetid://9114361763", length = 4.559 },
		nuke_launch = { sprite = "rbxassetid://9114840785", start = 0, stop = 3.2, length = 3.2 },
		conquer = { sprite = "rbxassetid://9114840785", start = 0, stop = 3.2, length = 3.2 },
		under_attack = { sprite = "rbxassetid://9114840785", start = 0, stop = 3.2, length = 3.2 },

		nuke_alarm = { id = "rbxassetid://134637290412213", length = 2.295 },
		betrayal = { id = "rbxassetid://134637290412213", length = 2.295 },
		game_start = { id = "rbxassetid://134637290412213", length = 2.295 },
		countdown_gamestart = { id = "rbxassetid://134637290412213", length = 2.295 },

		star_get = { id = "rbxassetid://92486275191948", length = 2.554 },
		buy_spend = { id = "rbxassetid://92486275191948", length = 2.554 },
		alliance = { id = "rbxassetid://92486275191948", length = 2.554 },
		crate_open = { id = "rbxassetid://92486275191948", length = 2.554 },
		reveal_common = { id = "rbxassetid://92486275191948", length = 2.554 },
		crate_preview_common = { id = "rbxassetid://92486275191948", length = 2.554 },

		unlock = { id = "rbxassetid://138007687545003", length = 2.38 },
		crate_shimmer = { id = "rbxassetid://138007687545003", length = 2.38 },
		reveal_rare = { id = "rbxassetid://138007687545003", length = 2.38 },
		reveal_epic = { id = "rbxassetid://138007687545003", length = 2.38 },
		crate_preview_rare = { id = "rbxassetid://138007687545003", length = 2.38 },
		crate_preview_epic = { id = "rbxassetid://138007687545003", length = 2.38 },

		victory = { id = "rbxassetid://1839893816", length = 8.76 },
		reveal_legendary = { id = "rbxassetid://1839893816", length = 8.76 },
		crate_preview_legendary = { id = "rbxassetid://1839893816", length = 8.76 },

		defeat = { id = "rbxassetid://1839893736", length = 7.88 },
	},
}
