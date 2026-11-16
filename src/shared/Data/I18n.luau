--!strict
--[[
	Dual localization (EN + RU) for Zombie World RTS.
	Client-only usage (never require from src/shared/Core/* so lockstep stays deterministic).
]]

local IS_ROBLOX = type(game) == "userdata"
local Signal: any = if IS_ROBLOX
	then require((game :: any):GetService("ReplicatedStorage"):WaitForChild("Airfront").Core.Signal)
	else (require :: any)("../Core/Signal")

local I18n = {}
I18n.changed = Signal.new()

local function norm_lang(raw: any): string
	if type(raw) == "string" then
		local s = string.lower(raw)
		if string.sub(s, 1, 2) == "ru" then
			return "ru"
		end
	end
	return "en"
end

local function detect_lang(): string
	if not IS_ROBLOX then
		return "en"
	end
	local ok, res = pcall(function()
		local RunService = game:GetService("RunService")
		if not RunService:IsClient() then
			return "en"
		end
		local locService = game:GetService("LocalizationService")
		local locId = locService.RobloxLocaleId
		if type(locId) == "string" and locId ~= "" then
			return norm_lang(locId)
		end
		local Players = game:GetService("Players")
		local lp = Players.LocalPlayer
		if lp ~= nil then
			return norm_lang(lp.LocaleId)
		end
		return "en"
	end)
	return if ok then res else "en"
end

local _lang: string = detect_lang()

local STRINGS: { [string]: { [string]: string } } = {
	en = {
		lang_code = "EN",
		lang_next = "RU",
		lang_label = "Language: English",

		title_tag = "BIO-THREAT  ·  SURVIVE OR INFECT",
		title_play_solo = "PLAY SOLO",
		title_how_to_play = "HOW TO PLAY",
		title_solo_head = "PLAY SOLO",
		title_mode = "MODE",
		mode_classic = "Classic",
		mode_zombie = "Zombie Plague",
		title_role = "ROLE",
		role_survivor = "Survivor",
		role_infected = "Patient Zero",
		mode_desc_zombie_survivor = "Outbreaks erupt on the globe. Build Quarantine Bunkers and pop free Emergency Vaccine surges.",
		mode_desc_zombie_infected = "You are Patient Zero! Spread the Strain, leech troops on every bite, and assimilate fallen nations.",
		title_diff = "DIFFICULTY",
		diff_0 = "Relaxed",
		diff_1 = "Standard",
		diff_2 = "Brutal",
		diff_desc_0 = "Gentle AI: slower growth and a long early peace.",
		diff_desc_1 = "A fair fight: nations respect a short early peace.",
		diff_desc_2 = "Aggressive AI that grows fast and hunts you early.",
		title_map = "Map:  %s",
		title_start = "START",
		title_deploying = "DEPLOYING…",

		pause_title = "GAME MENU",
		pause_settings = "SETTINGS",
		pause_resume = "RESUME",
		pause_how_to_play = "How to play",
		pause_done = "DONE",
		pause_lang = "Language:  English  (switch to RU)",
		pause_labels = "Territory labels",
		pause_music = "Music",
		pause_pops = "Border pop sound",
		pause_confirm_atk = "Select before attacking",
		pause_tips = "Show tips again",
		pause_new_player = "Replay as new player",
		pause_next_preview = "Next-match screen",
		pause_restart = "Restart match",
		pause_leave = "LEAVE MATCH",
		pause_stay = "Stay",
		pause_leave_go = "Leave",
		pause_confirm_leave = "Return to the title screen?",
		pause_confirm_leave_alive = "Surrender and return to the title screen? %s",
		pause_leave_mp = "Your nation stays on the map without a commander.",
		pause_leave_solo = "This campaign will end.",
		pause_confirm_restart = "Restart with a fresh world? This match will be lost.",
		pause_restart_go = "Restart",
		pause_replay_go = "Replay",
		pause_confirm_new = "Play as a new player again? Your match count and tutorial start over%s What you own stays.",
		pause_confirm_new_end = ", and this match ends.",
		pause_sub_settings = "Saved for next time",
		pause_sub_title = "Main menu",
		pause_sub_wait = "Waiting for the next multiplayer match",
		pause_sub_mp = "Multiplayer match",
		pause_sub_solo = "Solo match · %s · paused",
		pause_sub_zombie = "Zombie Plague · %s · paused",

		top_goal = "WIN AT %d%%",
		top_goal_zombie = "PURGE HORDE OR %d%%",
		top_goal_infected = "INFECT %d%%",
		top_you = "YOU",
		top_horde_tag = "HORDE",
		top_outbreak_in = "OUTBREAK %s",
		top_bio_threat = "BIO %d%%",
		top_vaccine_on = "SERUM %ds",
		top_grace = "PEACE %s",

		spawn_wait = "SPAWNING IN  %s",
		spawn_ready = "TAP LAND TO DROP",
		spawn_waiting = "Deploying commanders…",
		spawn_classic_sub = "Pick your starting territory before nations awaken.",
		spawn_zombie_sub = "Pick a defensible homeland. Bio-outbreaks erupt 12s after start!",
		spawn_infected_sub = "Choose Ground Zero. Prepare to consume adjacent tribes and nations.",

		bar_build = "Build",
		bar_sends = "Sends %s troops",
		bar_world_pct = "%s of the world",
		bar_bio_pct = "%s of world  ·  Bio %s",

		bunker_title = "Quarantine Bunker",
		bunker_short = "Bunker",
		bunker_blurb = "Locks borders down: 8x Horde attrition, blocks bite leech, slows breaches.",
		vaccine_title = "Vaccine Surge",
		vaccine_short = "Vaccine",
		vaccine_blurb = "FREE in Plague! +20% troops & 20s bio-shield (50% Horde dmg, zero leech).",
		vaccine_ready = "FREE  ·  20s Bio-Shield",
		free = "FREE",
		kind_zombie = "Infected",
		team_zombie = "Zombie Horde",

		alert_biohazard = "BIOHAZARD OUTBREAK",
		alert_biohazard_sub = "Infected hives erupted! Contain borders with Bunkers, Vaccines & Nukes.",
		alert_mutated = "NATION MUTATED",
		alert_mutated_sub = "%s fell to the Strain and joined the Zombie Horde!",
		alert_vaccine = "VACCINE SERUM ACTIVE (20s)",
		alert_vaccine_sub = "50% Horde damage & zero bite leech for 20s.",

		over_win_purge = "PLAGUE PURGED",
		over_win_purge_sub = "Humanity eradicated every outbreak and reclaimed Earth.",
		over_win_horde = "EARTH CONSUMED",
		over_win_horde_sub = "The Zombie Horde assimilated 80% of the habitable world.",
		over_win_infected_player = "TOTAL INFECTION",
		over_win_infected_player_sub = "Your Strain devoured civilization.",
		over_loss_horde = "OVERWHELMED BY HORDE",
		over_loss_horde_sub = "Bio-outbreaks consumed %s%% of the globe.",
		over_loss_purged = "STRAIN ERADICATED",
		over_loss_purged_sub = "Survivors purged the last infected hive.",
		over_play_again = "PLAY AGAIN",
		over_main_menu = "MAIN MENU",

		title_welcome_cmd = "Welcome, Commander %s",
		title_welcome_cmd_anon = "Welcome, Commander",
		title_welcome_gen = "Welcome, General %s",
		title_welcome_gen_anon = "Welcome, General",
		title_public_matches = "Public matches",
		title_credits = "BioFront: Zombie World RTS  ·  Based on OpenFront & RoWorld  ·  Music: Rodrigo Flores  ·  GNU AGPL v3 (See Help)",
		title_credits_short = "BioFront  ·  Based on OpenFront & RoWorld  ·  GNU AGPL v3",

		mp_zombie = "ZOMBIE PLAGUE",
		mp_ffa = "CLASSIC FFA",
		mp_team = "TEAM GAME",
		mp_world = "WORLD",
		mp_join = "JOIN",
		mp_join_teams = "JOIN TEAMS",
		mp_cancel = "CANCEL",
		mp_leader = "LEADER",
		mp_next = "Next: ",
		mp_players_starts = "%d / %d players  ·  starts in %s",
		mp_teams_fmt = "%d Teams",
		mp_next_soon = "Next match opening soon",
		mp_next_soon_short = "Next match soon",
		mp_finding = "Finding a seat…",
		mp_joining = "Joining…",
		mp_waiting_seat = "Waiting for a free seat  ·  %s",
		mp_connecting = "Connecting to server…",
		mp_offline = "Offline  ·  play solo for now",
		mp_q_joining = "JOINING MULTIPLAYER",
		mp_q_starts_in = "Match starts in %s",
		mp_q_voted_in = "Voted to start  ·  starting in %s",
		mp_q_vote = "Vote to start  ·  %s",
		mp_q_voted = "Voted  ·  %s  (tap to undo)",
		mp_q_leave = "Leave match",

		rotate_title = "ROTATE YOUR DEVICE",
		rotate_body = "BioFront is played in landscape.\nTurn your device sideways to continue.",

		help_title = "HOW TO PLAY",
		help_sub = "Survive the bio-plague or conquer the globe.",
		help_paused = "  ·  Game paused",
		help_zombie_title = "Zombie Plague Mode",
		help_zombie_text = "Bio-outbreaks erupt 12s into the match and weak nations mutate into the Horde! Build Quarantine Bunkers (8× Horde attrition, blocks bite leech), trigger FREE Emergency Vaccine Surges (+20% troops & 20s 50%-damage bio-shield), or purge infected borders with Nukes (2× blast kills & 10× fallout burn). In Solo you can also play as Patient Zero!",

		next_title = "NEXT MATCH",
		next_sub = "Choose your next front",
		next_solo_head = "SOLO",
		next_solo_body = "Play offline against AI & the Horde on %s.",
		next_online_head = "ONLINE PLAGUE",
		next_online_body = "Survive the Zombie Horde with up to 50 commanders online.",
		next_online_btn = "PLAY ONLINE",
		next_results = "See results",
		next_close = "Close",
	},
	ru = {
		lang_code = "RU",
		lang_next = "EN",
		lang_label = "Язык: Русский",

		title_tag = "БИО-УГРОЗА  ·  ВЫЖИТЬ ИЛИ ЗАРАЗИТЬ",
		title_play_solo = "ИГРАТЬ СОЛО",
		title_how_to_play = "ОБУЧЕНИЕ",
		title_solo_head = "СОЛО-РЕЖИМ",
		title_mode = "РЕЖИМ",
		mode_classic = "Классика",
		mode_zombie = "Зомби-эпидемия",
		title_role = "РОЛЬ",
		role_survivor = "Выживший",
		role_infected = "Нулевой пациент",
		mode_desc_zombie_survivor = "На карте вспыхнут очаги Орды. Стройте карантинные бункеры и жмите бесплатную Вакцину!",
		mode_desc_zombie_infected = "Вы — Нулевой пациент! Разносите штамм, крадите войска при укусе и обращайте нации в Орду.",
		title_diff = "СЛОЖНОСТЬ",
		diff_0 = "Спокойная",
		diff_1 = "Стандарт",
		diff_2 = "Хардкор",
		diff_desc_0 = "Мягкий ИИ: медленный рост и долгое перемирие на старте.",
		diff_desc_1 = "Честный бой: короткое перемирие в начале матча.",
		diff_desc_2 = "Агрессивный ИИ: быстрый рост и ранняя охота.",
		title_map = "Карта:  %s",
		title_start = "В БОЙ",
		title_deploying = "ВЫСАДКА…",

		pause_title = "МЕНЮ ИГРЫ",
		pause_settings = "НАСТРОЙКИ",
		pause_resume = "ПРОДОЛЖИТЬ",
		pause_how_to_play = "Как играть",
		pause_done = "ГОТОВО",
		pause_lang = "Язык:  Русский  (переключить на EN)",
		pause_labels = "Подписи территорий",
		pause_music = "Музыка",
		pause_pops = "Звук захвата границ",
		pause_confirm_atk = "Подтверждать атаку кликом",
		pause_tips = "Показать советы снова",
		pause_new_player = "Заново как новичок",
		pause_next_preview = "Экран следующего матча",
		pause_restart = "Начать заново",
		pause_leave = "ВЫЙТИ В МЕНЮ",
		pause_stay = "Остаться",
		pause_leave_go = "Выйти",
		pause_confirm_leave = "Вернуться в главное меню?",
		pause_confirm_leave_alive = "Сдаться и выйти в главное меню? %s",
		pause_leave_mp = "Ваша держава останется на карте под управлением ИИ.",
		pause_leave_solo = "Эта кампания будет завершена.",
		pause_confirm_restart = "Перезапустить матч с новой картой? Текущий прогресс будет потерян.",
		pause_restart_go = "Заново",
		pause_replay_go = "Сначала",
		pause_confirm_new = "Сбросить обучение и начать как новичок?%s Все покупки останутся.",
		pause_confirm_new_end = " Текущий матч завершится.",
		pause_sub_settings = "Сохраняется автоматически",
		pause_sub_title = "Главное меню",
		pause_sub_wait = "Ожидание сетевого матча",
		pause_sub_mp = "Сетевой матч",
		pause_sub_solo = "Соло · %s · пауза",
		pause_sub_zombie = "Зомби-эпидемия · %s · пауза",

		top_goal = "ПОБЕДА %d%%",
		top_goal_zombie = "ЗАЧИСТКА ИЛИ %d%%",
		top_goal_infected = "ЗАРАЗИТЬ %d%%",
		top_you = "ВЫ",
		top_horde_tag = "ОРДА",
		top_outbreak_in = "ВСПЫШКА %s",
		top_bio_threat = "ЗАРАЗА %d%%",
		top_vaccine_on = "ВАКЦИНА %dс",
		top_grace = "МИР %s",

		spawn_wait = "СТАРТ ЧЕРЕЗ  %s",
		spawn_ready = "ВЫБЕРИТЕ ЗЕМЛЮ",
		spawn_waiting = "Высадка командиров…",
		spawn_classic_sub = "Выберите стартовый регион до пробуждения наций.",
		spawn_zombie_sub = "Займите удобный плацдарм. Очаги вспыхнут через 12с!",
		spawn_infected_sub = "Выберите Нулевую точку, чтобы поглотить соседей.",

		bar_build = "Стройка",
		bar_sends = "Отправка %s войск",
		bar_world_pct = "%s суши",
		bar_bio_pct = "%s суши  ·  Зараза %s",

		bunker_title = "Карантинный бункер",
		bunker_short = "Бункер",
		bunker_blurb = "8x потери для Орды, блок вампиризма, в 4x медленнее прорыв.",
		vaccine_title = "Вакцинация",
		vaccine_short = "Вакцина",
		vaccine_blurb = "БЕСПЛАТНО в Эпидемии! +20% войск и био-щит на 20с (50% урона Орды).",
		vaccine_ready = "БЕСПЛАТНО  ·  20с Щит",
		free = "БЕСПЛ.",
		kind_zombie = "Заражённые",
		team_zombie = "Зомби-Орда",

		alert_biohazard = "БИО-ТРЕВОГА: ВСПЫШКА!",
		alert_biohazard_sub = "Проснулись очаги Орды! Ставьте бункеры, жмите Вакцину и Ядерку.",
		alert_mutated = "НАЦИЯ ЗАРАЖЕНА",
		alert_mutated_sub = "%s пала и примкнула к Зомби-Орде!",
		alert_vaccine = "ВАКЦИНА АКТИВНА (20с)",
		alert_vaccine_sub = "50% урона Орды и блок вампиризма на 20с.",

		over_win_purge = "ЭПИДЕМИЯ ОСТАНОВЛЕНА",
		over_win_purge_sub = "Человечество выжгло все очаги заразы и спасло Землю.",
		over_win_horde = "ЗЕМЛЯ ПОГЛОЩЕНА",
		over_win_horde_sub = "Зомби-Орда захватила 80% обитаемой суши.",
		over_win_infected_player = "ТОТАЛЬНОЕ ЗАРАЖЕНИЕ",
		over_win_infected_player_sub = "Ваш штамм поглотил цивилизацию.",
		over_loss_horde = "СМЯТЫ ОРДОЙ",
		over_loss_horde_sub = "Зараза охватила %s%% планеты.",
		over_loss_purged = "ШТАММ УНИЧТОЖЕН",
		over_loss_purged_sub = "Выжившие зачистили последний очаг Орды.",
		over_play_again = "ИГРАТЬ СНОВА",
		over_main_menu = "ГЛАВНОЕ МЕНЮ",

		title_welcome_cmd = "Добро пожаловать, Командир %s",
		title_welcome_cmd_anon = "Добро пожаловать, Командир",
		title_welcome_gen = "Добро пожаловать, Генерал %s",
		title_welcome_gen_anon = "Добро пожаловать, Генерал",
		title_public_matches = "Сетевые матчи",
		title_credits = "BioFront: Zombie World RTS  ·  На базе OpenFront и RoWorld  ·  Музыка: Rodrigo Flores  ·  GNU AGPL v3 (см. Помощь)",
		title_credits_short = "BioFront  ·  На базе OpenFront и RoWorld  ·  GNU AGPL v3",

		mp_zombie = "ЗОМБИ-ЭПИДЕМИЯ",
		mp_ffa = "КЛАССИКА (FFA)",
		mp_team = "КОМАНДНЫЙ БОЙ",
		mp_world = "МИР",
		mp_join = "В БОЙ",
		mp_join_teams = "В КОМАНДУ",
		mp_cancel = "ОТМЕНА",
		mp_leader = "ЛИДЕР",
		mp_next = "Карта: ",
		mp_players_starts = "%d / %d игроков  ·  старт через %s",
		mp_teams_fmt = "%d команды",
		mp_next_soon = "Следующий матч скоро откроется",
		mp_next_soon_short = "Скоро старт",
		mp_finding = "Поиск места…",
		mp_joining = "Подключение…",
		mp_waiting_seat = "Ожидание свободного места  ·  %s",
		mp_connecting = "Подключение к серверу…",
		mp_offline = "Офлайн  ·  доступен соло-режим",
		mp_q_joining = "ПОДКЛЮЧЕНИЕ К МАТЧУ",
		mp_q_starts_in = "Старт матча через %s",
		mp_q_voted_in = "Голосование прошло  ·  старт через %s",
		mp_q_vote = "Голосовать за старт  ·  %s",
		mp_q_voted = "Голос учтён  ·  %s  (отмена)",
		mp_q_leave = "Покинуть лобби",

		rotate_title = "ПОВЕРНИТЕ УСТРОЙСТВО",
		rotate_body = "BioFront работает в горизонтальном режиме.\nПоверните устройство боком, чтобы продолжить.",

		help_title = "КАК ИГРАТЬ",
		help_sub = "Выживите в био-чуме или покорите мир.",
		help_paused = "  ·  Пауза",
		help_zombie_title = "Режим «Зомби-эпидемия»",
		help_zombie_text = "Через 12с после старта вспыхнут очаги заразы, а слабые нации мутируют в Орду! Стройте Карантинные бункеры (8× потери Орды, блок вампиризма), жмите БЕСПЛАТНУЮ Вакцину (+20% войск и био-щит на 20с) и выжигайте заразу ядерными ударами (2× урон взрыва и 10× урон радиации). В Соло можно играть за Нулевого пациента!",

		next_title = "СЛЕДУЮЩИЙ МАТЧ",
		next_sub = "Выберите следующий фронт",
		next_solo_head = "СОЛО",
		next_solo_body = "Одиночная кампания против ИИ и Орды (%s).",
		next_online_head = "ОНЛАЙН-ЭПИДЕМИЯ",
		next_online_body = "Выживайте против Зомби-Орды до 50 игроков в матче.",
		next_online_btn = "ИГРАТЬ ОНЛАЙН",
		next_results = "К итогам",
		next_close = "Закрыть",
	},
}

function I18n.get(): string
	return _lang
end

function I18n.set(lang: string): boolean
	local target = norm_lang(lang)
	if target == _lang then
		return false
	end
	_lang = target
	I18n.changed:Fire(_lang)
	return true
end

function I18n.toggle(): string
	I18n.set(if _lang == "ru" then "en" else "ru")
	return _lang
end

function I18n.t(key: string, ...: any): string
	local tbl = STRINGS[_lang] or STRINGS.en
	local tpl = tbl[key] or STRINGS.en[key] or key
	if select("#", ...) > 0 then
		local ok, out = pcall(string.format, tpl, ...)
		if ok and type(out) == "string" then
			return out
		end
	end
	return tpl
end

return I18n
