# AGENTS.md — Системные инструкции проекта (форк RoWorld / OpenFront для Antigravity на Windows)

## 1. Подключение к Roblox Studio (Windows + Antigravity)

1. **Двойное подключение к Roblox Studio (`MCP` + `Argon :18002`):**
   - Используй встроенный MCP-сервер **`Roblox_Studio`** (`list_roblox_studios`, `get_studio_state`, `execute_luau`, `get_console_output`, `start_stop_play`, `search_game_tree`, `inspect_instance`, `screen_capture`) для живой проверки рантайма и плейтестов.
   - Для синхронизации кода из файлов на диске используй **`argon`** на **порту `18002`** (порт `18001` занят проектом `roblox_game_2_metro`; в системе установлен `argon-rbx`, а не `rojo`):
     - Сборка `.rbxl` с нуля: `argon build default.project.json -o roworld_dev.rbxl` (или `release.project.json` без `**/Dev/**` для релиза).
     - Live-синхронизация в фоне: `argon serve default.project.json --port 18002 --sourcemap --yes` (и подключай плагин Argon в Roblox Studio к порту **`18002`**).
2. **Жёсткое правило проверки через MCP (`Roblox_Studio`):**
   - **ЗАПРЕЩЕНО** принимать или сдавать изменения в геймплее, UI или рендере карты «вслепую» только по чтению кода или успешному `argon build`.
   - Каждая задача/этап считается завершённой только после живой проверки в Roblox Studio через `Roblox_Studio` MCP:
     1. Проверка подключения студии (`list_roblox_studios` / `get_studio_state`) и синка из Argon (`:18002`).
     2. Запуск плейтеста (`start_stop_play`) и проверка логов консоли (`get_console_output` — **`0` ошибок** и без новых предупреждений).
     3. Проверка логики/данных в рантайме через `execute_luau` и структуры дерева через `inspect_instance` / `search_game_tree`.
     4. Визуальная проверка интерфейса и карты через `screen_capture` (если менялись UI, цвета карты, спавн или меню).
3. **Особенности Windows vs upstream-скрипты:**
   - Upstream-репозиторий разрабатывался на macOS/Linux под Claude MCP (`tools/*.py`, `tools/*.sh`; например, `tools/upload.py` использует Unix-модуль `fcntl`, а `CLAUDE.md` ссылается на `snick-announce`).
   - **Не запускай `tools/*.py` / `tools/*.sh` напрямую на Windows без адаптации** — для локальной сборки, sourcemap и плейтестов используй `argon build` / `argon serve --port 18002` и MCP `Roblox_Studio`.

---

## 2. Архитектура кода (`Airfront` в `default.project.json`)

- **Маппинг дерева:**
  - `src/shared` -> `ReplicatedStorage.Airfront`
  - `src/server` -> `ServerScriptService.AirfrontServer`
  - `src/client` -> `StarterPlayer.StarterPlayerScripts.AirfrontClient`
  - Настройки плейса в `default.project.json`: `Players.CharacterAutoLoads = false`, `Workspace.Gravity = 0`, `StarterGui.ResetPlayerGuiOnSpawn = false`, `ScreenOrientation = LandscapeSensor`, `Lighting.Technology = Compatibility`.
  - В `release.project.json` дополнительно исключаются `**/Dev/**` и `**/Dev`.
- **Автономная работа из коробки (`Solo` + `MemoryStore` лобби):**
  - Режим **Solo** выполняется полностью на клиенте (без нагрузки на сервер).
  - Мультиплеер (`src/server/ServerMain.luau`) при отсутствии `src/server/Lobbies/Secret.luau` автоматически использует встроенный в Roblox **`MemoryStore` список лобби** — внешний Node.js-сервер `services/lobbies` **не обязателен** для старта и плейтестов.
- **Карты (`src/shared/Data/MapList.luau`):**
  - В комплекте 10 готовых карт (`world` реплицируется сразу в `src/shared/Data/Maps/World.luau`, остальные 9 — `europe`, `asia`, `africa`, `northamerica`, `southamerica`, `mediterranean`, `middleeast`, `oceania`, `unitedstates` — подгружаются с сервера из `src/server/MapData/`).

---

## 3. Юридический чеклист (`GNU AGPL-3.0`) и монетизация перед релизом

Репозиторий распространяется под лицензией **`GNU AGPL-3.0`** (унаследовано от OpenFront). Коммерческий форк и монетизация в Roblox легальны при строгом соблюдении следующих пунктов:

1. **Публичный исходный код (`AGPL-3.0`):** перед или в момент публичного релиза в Roblox опубликуй изменённый исходный код нашего форка в открытом GitHub-репозитории под лицензией `GNU AGPL-3.0`, сохрани уведомления об авторстве `OpenFront` и `lukechatton/roworld` и укажи ссылку на репозиторий в описании игры.
2. **Полная замена чужого брендинга:**
   - Заменить все упоминания и ассеты `"RoWorld"`, `"Rofront"`, `"Torrey Pines"`, `"Airfront"` (в `src/shared/Assets/Branding.luau`, текстах интерфейса, иконках и миниатюрах) на собственный бренд.
3. **Замена ID продуктов, подписки и стейджинга:**
   - В `src/shared/Data/Products.luau` прописаны ID оригинала (`takeover`, `crate`, `crate_first`, `crate3`, `crate10`, `unlock_*`, `starter_pack`, а также флаги/наборы через `Data/Shop` и `Assets/ShopFlags`). Перед публикацией заменить все `id` и `staging` на собственные Developer Products нашего Experience.
   - В `src/shared/Data/Subscription.luau` (`RoWorld General`, `399 R$/мес`) заменить `Subscription.ID`, `Subscription.STAGING` и `Subscription.NAME` на собственную подписку (или `""`, пока не создана).
   - Проверить `src/shared/Data/Staging.luau` и все `rbxassetid://` на доступность из-под нашего аккаунта / группы (чтобы не было приватных ассетов чужой группы).

---

## 4. УТП форка (`Variant A: Zombie Plague RTS`), детерминизм и GitHub-процесс

1. **Выбранный концепт — Вариант А: «Зомби-эпидемия / Био-угроза» (`Zombie Plague RTS`):**
   - Вместо 1:1 клона строим уникальную фишку поверх `src/shared/Core/` (`Sim.luau`, `SimState.luau`, `SimAttacks.luau`, `SimAI.luau`, `Rules.luau`, `Defs.luau`): режим **Zombie Horde / Bio-Plague** — на карте появляются очаги заражения («Нулевой пациент» / Орда), агрессивная экспансия и обращение захваченных наций/племён в заражённых, защитные карантинные бункеры / вакцина / выжигание границ ядерными ударами, возможность играть за выжившие державы или за сам штамм.
2. **Критическое правило lockstep-детерминизма ядра (`src/shared/Core/Sim.luau`):**
   - `Sim.luau` (`--!native`, `step()` на `10 Hz`) — чистая детерминированная логика, единая для клиента (Solo) и сервера (`MatchServer.luau`).
   - **НЕЛЬЗЯ** использовать `Instance`, `os.clock()`, `tick()`, `workspace` или `math.random()` внутри `src/shared/Core/*` — используй только `self.rng` (`Rng.luau`), а любые новые поля состояния и события аккуратно пробрасывай через `GameState.luau` / `Ev.luau` / `Net/Protocol.luau`.
3. **GitHub Fork Workflow (`AGPL-3.0`):**
   - `upstream` = `lukechatton/roworld` (только чтение, push отключён `DISABLED`).
   - `origin` = `https://github.com/ajct19/zombie-world-rts.git` (наш публичный форк на GitHub под лицензией `GNU AGPL-3.0`).
   - **Авторство коммитов:** всегда делать коммиты от имени владельца `ajct19` (`30310303+ajct19@users.noreply.github.com`); **строго запрещено** менять `git config user.name` / `user.email` на `Antigravity Agent` или локальные заглушки.
   - Завершённые и проверенные через MCP этапы фиксируй осмысленными коммитами и отправляй в `origin`.
4. **Двойная локализация (`EN` + `RU`):** все новые/изменённые тексты UI, названия режимов, подсказки и офферы монетизации должны поддерживать английский (`EN`, основной рынок Robux) и русский (`RU`) языки.
5. **Синхронизация с портфелем (`orchestrator-sync`):** после значимых этапов, смены приоритета или появления блокеров обновляй карточку проекта `C:\Users\Artem\Documents\project\obsidian\projects\roblox_game_3_roworld.md`.
