--!strict
-- The client's frame time: the real one (os.clock, RenderStepped's dt), except while a Studio film
-- (Dev/Film: the trailer, 2026-10-12) steps time itself,
-- a frame at a time, so a capture of each frame plays back smoothly. The session, the map and the HUD
-- take their dt from here and the map's animations their clock.
local FrameClock = {}

--- Dev/Film while filming: { t = seconds, dt = this frame's seconds }.
FrameClock.film = nil :: { t: number, dt: number }?

local _hb_conns: { [string]: RBXScriptConnection } = {}

function FrameClock.now(): number
	local f = FrameClock.film
	return if f ~= nil then f.t else os.clock()
end

function FrameClock.dt(real: number): number
	local f = FrameClock.film
	return if f ~= nil then f.dt else real
end

function FrameClock.unbind(name: string)
	local c = _hb_conns[name]
	if c ~= nil then
		_hb_conns[name] = nil
		c:Disconnect()
	end
	pcall(function()
		game:GetService("RunService"):UnbindFromRenderStep(name)
	end)
end

function FrameClock.bind(name: string, priority: number, fn: (number) -> ())
	FrameClock.unbind(name)
	local RunService = game:GetService("RunService")
	local last_render = 0.0
	RunService:BindToRenderStep(name, priority, function(dt: number)
		last_render = os.clock()
		fn(dt)
	end)
	_hb_conns[name] = RunService.Heartbeat:Connect(function(dt: number)
		if FrameClock.film == nil and os.clock() - last_render > 0.08 then
			fn(dt)
		end
	end)
end

return FrameClock
