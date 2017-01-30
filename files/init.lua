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
