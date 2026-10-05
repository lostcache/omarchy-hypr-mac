-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

-- Monitor scale is Hyprland's scale for the output. It sizes everything
-- Wayland-native, accepts fractions (1.6, 1.75), and applies immediately.
-- "auto" lets Hyprland pick per display.
local omarchy_monitor_scale = 1.6
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })

-- Pin workspaces to monitors: 1-5 on the external display, 6-10 on the
-- built-in display (10 is bound to the SUPER+0 key).
local omarchy_external_monitor = "desc:Sceptre Tech Inc X322BV-HDR 0x01010101"
local omarchy_builtin_monitor = "eDP-1"
-- External TV at native scale: the generic rule above would apply the laptop
-- scale (1.6/1.25) to it, which is far too zoomed on a 1360x768 display.
hl.monitor({ output = omarchy_external_monitor, mode = "preferred", position = "auto", scale = 0.75 })
for id = 1, 6 do
	hl.workspace_rule({ workspace = tostring(id), monitor = omarchy_external_monitor, default = true })
end
for id = 7, 10 do
	hl.workspace_rule({ workspace = tostring(id), monitor = omarchy_builtin_monitor, default = true })
end

-- GDK scale is GDK_SCALE, the factor GTK draws its own UI at. It's what
-- sizes X11/XWayland windows, which Omarchy leaves unscaled so they stay
-- crisp instead of being stretched by the compositor. GTK only honors whole
-- numbers, so use the nearest integer to the monitor scale, and restart an
-- app for a change to reach it.
local omarchy_gdk_scale = 2
hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
