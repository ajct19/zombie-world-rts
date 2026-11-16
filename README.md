# BioFront: Zombie World RTS

Real-time territorial strategy (RTS) for Roblox featuring the **Zombie Plague** survival & infection mode with dual **EN + RU** localization.

## Features
- **Zombie Plague Mode (Solo & Multiplayer):** Bio-outbreak hives erupt on the globe, assimilate fallen nations via bite leech and mutations, and spread across territory with procedural `#39FF14` bio-vein map visuals.
- **Survivor Counterplay:** Build Quarantine Bunkers (`8x` Horde attrition, blocks bite leech), deploy free Emergency Vaccine Surges (`+20%` troops & `20s` bio-shield), and purge outbreaks with Nukes (`2x` blast damage & `10x` fallout burn).
- **Play as Patient Zero (Solo):** Command Ground Zero with boosted starting troops and consume nations into the Horde.

**Русский:**
Стратегия в реальном времени (RTS) в мире Roblox с уникальным режимом **Зомби-эпидемия** (игра за Выживших или Нулевого пациента, карантинные бункеры, бесплатная Вакцинация, ядерная зачистка, процедуральный био-скин карты и полная поддержка `RU / EN`).

## Architecture & Build (Windows)
- `src/shared` -> `ReplicatedStorage.Airfront` (`Core/*` is strictly deterministic via `self.rng`).
- `src/server` -> `ServerScriptService.AirfrontServer` (`MemoryStore` lobbies out of the box).
- `src/client` -> `StarterPlayer.StarterPlayerScripts.AirfrontClient`.
- Build `.rbxl`: `argon build default.project.json -o roworld_dev.rbxl`
- Live sync in Studio: `argon serve default.project.json --port 18002 --sourcemap --yes`

## License & Attribution (`GNU AGPL-3.0`)
This project is a modified fork of [RoWorld](https://github.com/lukechatton/roworld), which is a Roblox port of OpenFront (`© OpenFront and Contributors`).
Distributed under the **GNU Affero General Public License v3.0** (`LICENSE`).
Public source repository: https://github.com/ajct19/zombie-world-rts
