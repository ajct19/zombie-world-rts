--!nonstrict
-- NEXT MATCH (2026-11-13): after a new player's first match, two big ways into the next one: another
-- solo match against the computer, or a public match with real players. Of the new players who
-- reached ten minutes in their first match, 28% never started a second one in that session (the
-- dashboard's Onboarding funnel, Nov 6-13); the results screen offered PLAY AGAIN beside two other
-- buttons, and nothing about public matches.
-- It opens over the results screen a moment after it (DELAY_S: the outcome and the Stars land first);
-- "See results" closes it. Game admins and Rofront Staging can open it from the title's menu to try it
-- (PauseMenu, "Next-match screen").
--
-- API: NextMatch.new(ctx); open(map_name); close(); apply_layout(); signals solo, public, closed.

local UITheme = require("./UITheme")
local W = require("./Widgets")
local GlassPanel = require("./GlassPanel")
local UICtx = require("./UICtx")
local Signal = UITheme.core("Signal")

local NextMatch = W.class(W.Control)

--- Seconds after the results screen opens.
NextMatch.DELAY_S = 2.5

function NextMatch.new(c: any)
	local self = setmetatable({}, NextMatch.__mt)
	W.Control._init(self)
	self.ctx = c
	self.solo = Signal.new()
	self.public = Signal.new()
	self.closed = Signal.new()
	self.is_open = false
	local T = UITheme
	self:set_anchors_and_offsets_preset(W.PRESET_FULL_RECT)
	self:set_mouse_filter(W.MOUSE_STOP)
	self:set_visible(false)
	self._dim = W.ColorRect.new(T.rgba(0.01, 0.015, 0.05, 0.62))
	self._dim:set_anchors_and_offsets_preset(W.PRESET_FULL_RECT)
	self:add_child(self._dim)
	self._panel = GlassPanel.new(24.0, 22.0, 18, true, 34)
	self._panel:set_tint(T.rgba(0.045, 0.065, 0.13, 0.95))
	self:add_child(self._panel)
	local v = T.vbox(16)
	self._panel:add_child(v)
	local head = T.vbox(4)
	self._title = T.label(UICtx.t("next_title"), 26, 800, T.TEXT, 4)
	self._title.horizontal_alignment = W.ALIGN_CENTER
	head:add_child(self._title)
	self._sub = T.label(UICtx.t("next_sub"), 14, 500, T.TEXT_2)
	self._sub.horizontal_alignment = W.ALIGN_CENTER
	head:add_child(self._sub)
	v:add_child(head)
	local row = T.hbox(14)
	row:set_alignment(W.ALIGN_CENTER)
	v:add_child(row)
	self._cards = {}
	local function card(icon: string, heading: string, text: string, button: string, fire: any): (any, any, any)
		local p = GlassPanel.new(18.0, 16.0, T.R_MD, true, 20)
		p:set_border(T.c(T.CYAN, 0.35))
		local cv = T.vbox(10)
		p:add_child(cv)
		local top = T.hbox(10)
		local disc = W.Panel.new()
		disc:set_mouse_filter(W.MOUSE_IGNORE)
		disc:set_min_size(Vector2.new(38, 38))
		disc.size_flags_vertical = W.SHRINK_CENTER
		disc:add_theme_stylebox_override("panel", T.flat(T.c(T.CYAN, 0.16), 19, T.c(T.CYAN, 0.5), 1))
		local ic = T.icon_rect(icon, 20.0, T.CYAN)
		ic.size_flags_horizontal = W.SHRINK_CENTER
		ic.size_flags_vertical = W.SHRINK_CENTER
		disc:add_child(ic)
		top:add_child(disc)
		local h = T.label(heading, 20, 800, T.TEXT, 2)
		h.size_flags_vertical = W.SHRINK_CENTER
		top:add_child(h)
		cv:add_child(top)
		local l = T.label(text, 13, 500, T.TEXT_2)
		l:set_autowrap(true)
		l.size_flags_vertical = W.EXPAND_FILL
		cv:add_child(l)
		local b = T.button(button, "PrimaryButton", "play", 56.0)
		b.pressed:Connect(function()
			if self.is_open then
				fire:Fire()
			end
		end)
		cv:add_child(b)
		row:add_child(p)
		table.insert(self._cards, { panel = p, heading = h, text = l, button = b })
		return l, h, b
	end
	self._solo_text, self._solo_head, self._solo_btn = card("troops", UICtx.t("next_solo_head"), "", UICtx.t("title_play_solo"), self.solo)
	self._online_text, self._online_head, self._online_btn =
		card("users", UICtx.t("next_online_head"), UICtx.t("next_online_body"), UICtx.t("next_online_btn"), self.public)
	self._back = T.button(UICtx.t("next_results"), "GhostButton", "", 40.0)
	self._back.size_flags_horizontal = W.SHRINK_CENTER
	self._back:set_font_size(13)
	self._back.pressed:Connect(function()
		self:close()
	end)
	v:add_child(self._back)
	self._map_name = nil :: string?
	self._over_results = true
	return self
end

function NextMatch.refresh_locale(self)
	if self._title ~= nil then
		self._title:set_text(UICtx.t("next_title"))
	end
	if self._sub ~= nil then
		self._sub:set_text(UICtx.t("next_sub"))
	end
	if self._solo_head ~= nil then
		self._solo_head:set_text(UICtx.t("next_solo_head"))
	end
	if self._solo_btn ~= nil then
		self._solo_btn:set_text(UICtx.t("title_play_solo"))
	end
	if self._online_head ~= nil then
		self._online_head:set_text(UICtx.t("next_online_head"))
	end
	if self._online_text ~= nil then
		self._online_text:set_text(UICtx.t("next_online_body"))
	end
	if self._online_btn ~= nil then
		self._online_btn:set_text(UICtx.t("next_online_btn"))
	end
	if self._solo_text ~= nil and self._map_name ~= nil then
		self._solo_text:set_text(UICtx.t("next_solo_body", self._map_name))
	end
	if self._back ~= nil then
		self._back:set_text(UICtx.t(if self._over_results == false then "next_close" else "next_results"))
	end
end

--- `map_name`: the map a solo match would be on; `over_results`: it stands over a results screen
--- (its foot button goes back to it).
function NextMatch.open(self, map_name: string?, over_results: boolean?)
	local ctx = self.ctx
	self._map_name = if map_name ~= nil and map_name ~= "" then map_name else "World"
	self._over_results = over_results
	self:refresh_locale()
	self.is_open = true
	self:set_visible(true)
	self:apply_layout()
	self._dim:set_modulate_a(0.0)
	W.fade(self._dim, 1.0, 0.25)
	UICtx.pop_in(self._panel, 0.0, 0.92, 0.35)
	ctx:sfx("open")
end

function NextMatch.close(self)
	if not self.is_open then
		return
	end
	self.is_open = false
	self.ctx:sfx("close")
	local t = self:create_tween():set_parallel(true)
	t:tween_property(self._dim, "modulate:a", 0.0, 0.15)
	t:tween_property(self._panel, "modulate:a", 0.0, 0.15)
	t:chain():tween_callback(function()
		if not self.is_open then
			self:set_visible(false)
			self._panel:set_modulate_a(1.0)
		end
	end)
	self.closed:Fire()
end

function NextMatch.apply_layout(self)
	local ctx = self.ctx
	local c = ctx.compact
	local w = if c then 220.0 else 270.0
	for _, cd in self._cards do
		cd.panel:set_min_size(Vector2.new(w, 0))
		cd.text:set_min_size(Vector2.new(w - 36.0, if c then 34.0 else 40.0))
		cd.text:set_font_size(if c then 12 else 13)
		cd.button:set_min_size(Vector2.new(0, if c then 48.0 else 56.0))
	end
	self._title:set_font_size(if c then 22 else 26)
	self._panel:reset_size()
	local sz = self._panel:get_combined_minimum_size()
	local area = ctx:clear_rect()
	local p = area.Min + (Vector2.new(area.Width, area.Height) - sz) * 0.5
	local rp = Vector2.new(math.floor(p.X + 0.5), math.floor(math.max(p.Y, area.Min.Y + 4.0) + 0.5))
	self._panel:set_offsets(rp.X, rp.Y, rp.X, rp.Y)
	self._panel:reset_size()
end

return NextMatch
