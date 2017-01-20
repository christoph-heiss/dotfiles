-- Use anycomplete
local anycomplete = require "anycomplete/anycomplete"
anycomplete.registerDefaultBindings()


-- Hyperdock-like shortcuts
-- command + alt + <arrow>
--   cmd + alt + left/right arrow lets the window fill the left/right half of the screen
--   cmd + alt + up maximizes the window
--   cmd + alt + down minimizes the window
local frame_cache = {}

function toggle_window_state(state)
	local win = hs.window.focusedWindow()
	local id = win:id()

	if frame_cache[id] then
		win:setFrame(frame_cache[id])
		frame_cache[id] = nil
	else
		frame_cache[id] = win:frame()
		win:moveToUnit(state)
	end
end

hs.hotkey.bind({'cmd', 'alt'}, 'left', function()
	toggle_window_state('[0, 0, 50, 100]')
end)

hs.hotkey.bind({'cmd', 'alt'}, 'right', function()
	toggle_window_state('[50, 0, 100, 100]')
end)

hs.hotkey.bind({'cmd', 'alt'}, 'up', function()
	toggle_window_state('[0, 0, 100, 50]')
end)

hs.hotkey.bind({'cmd', 'alt'}, 'down', function()
	toggle_window_state('[0, 50, 100, 100]')
end)

hs.hotkey.bind({'cmd', 'alt'}, ']', function()
	toggle_window_state('[100, 0, 50, 50]')
end)

hs.hotkey.bind({'cmd', 'alt'}, '[', function()
	toggle_window_state('[0, 0, 50, 50]')
end)

hs.hotkey.bind({'cmd', 'alt'}, "'", function()
	toggle_window_state('[0, 100, 50, 50]')
end)

hs.hotkey.bind({'cmd', 'alt'}, '\\', function()
	toggle_window_state('[100, 100, 50, 50]')
end)

hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'up', function()
	toggle_window_state('[0, 0, 100, 100]')
end)


-- A minimalistic Amphetamine.
local caffeine = hs.menubar.new()

function set_caffeine_menubar(state)
	caffeine:setTitle(state and 'W' or 'S')
end

function toggle_caffeine_menubar(state)
	set_caffeine_menubar(hs.caffeinate.toggle('displayIdle'))
end

set_caffeine_menubar(hs.caffeinate.get('displayIdle'))
caffeine:setClickCallback(toggle_caffeine_menubar)

hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'l', toggle_caffeine_menubar)


local app_watcher = hs.application.watcher.new(function(app_name, even_type, app)
	if (event_type == hs.application.watcher.activated) then
		if (app_name == 'Finder') then
			app:selectMenuItem({'Window', 'Bring All to Front'})
		end
	end
end)


-- A minimalistic f.lux
local redshift = hs.menubar.new()
local redshift_enabled = true
local redshift_times = {sunrise = '07:00', sunset = '20:00'}
hs.location.start()

function redshift_enable()
	redshift_enabled = true
	redshift:returnToMenuBar()

	hs.redshift.start(3600, redshift_times.sunset, redshift_times.sunrise)
end

function redshift_disable()
	redshift_enabled = false
	redshift:removeFromMenuBar()

	hs.redshift.stop()
end

redshift:setTitle('R')
redshift:setClickCallback(redshift_disable)

hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'k', function()
	if redshift_enabled then
		redshift_disable()
	else
		redshift_enable()
	end
end)

hs.timer.doAfter(1, function()
	local location = hs.location.get()
	hs.location.stop()

	if location then
		local tz_offset = tonumber(string.sub(os.date('%z'), 1, -3))
		for i, v in pairs({'sunrise', 'sunset'}) do
			redshift_times[v] = os.date('%H:%M',
				hs.location[v](location.latitude, location.longitude, tz_offset))
		end
	end

	redshift_enable()
end)
