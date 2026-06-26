---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "hyprlauncher"
local browser     = "firefox"
local wallpaper = "skwd wall toggle"
local wlauncher = "/home/miyazaki/.config/scripts/launch.sh"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier


-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))

local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(wallpaper))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(wlauncher))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("quickshell -p ~/.config/quickshell/asura ipc call launcher toggle"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
--for i = 1, 10 do
--    local key = i % 10 -- 10 maps to key 0
--    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
--    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
--end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

local function wsForward()
    hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 5, bezier = "loft",     style = "slidefade right 15%" })
    hl.animation({ leaf = "workspacesOut", enabled = true, speed = 5, bezier = "throwOut", style = "slidefade right 15%" })
end

local function wsBackward()
    hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 5, bezier = "loft",     style = "slidefade left 15%" })
    hl.animation({ leaf = "workspacesOut", enabled = true, speed = 5, bezier = "throwOut", style = "slidefade left 15%" })
end

for i = 1, 9 do
    local target = i
    hl.bind(mainMod .. " + " .. i, function()
        local current = hl.get_active_workspace().id
        if target > current then wsForward() else wsBackward() end
        hl.dispatch(hl.dsp.focus({ workspace = target }))
    end)
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- this uses the mouse scroll
hl.bind(mainMod .. " + mouse_up", function()
    wsForward()
    hl.dispatch(hl.dsp.focus({ workspace = "+1" }))
end, { mouse = true })

hl.bind(mainMod .. " + mouse_down", function()
    wsBackward()
    hl.dispatch(hl.dsp.focus({ workspace = "-1" }))
end, { mouse = true })


-- this is keyboard only, i use ALT but you can use whatever
hl.bind("ALT + Right", function()
    wsForward()
    hl.dispatch(hl.dsp.focus({ workspace = "+1" }))
end)

hl.bind("ALT + Left", function()
    wsBackward()
    hl.dispatch(hl.dsp.focus({ workspace = "-1" }))
end)