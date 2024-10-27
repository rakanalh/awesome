-----------------------------------------------------------------------------------------------------------------------
--                                              Autostart app list                                                   --
-----------------------------------------------------------------------------------------------------------------------

-- Grab environment
local awful = require("awful")

-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local autostart = {}

-- Application list function
--------------------------------------------------------------------------------
function autostart.run()
	-- firefox sync
	-- awful.spawn.with_shell("python ~/scripts/firefox/ff-sync.py")

	-- utils
	awful.spawn.with_shell("unclutter -root")
	awful.spawn.with_shell("greenclip daemon")
	-- awful.spawn.with_shell("compton")
	awful.spawn.with_shell("udiskie")
	awful.spawn.with_shell("mpd")
	awful.spawn.with_shell("mpDris2")
	awful.spawn.with_shell("nm-applet")
	awful.spawn.with_shell("flameshot")
	awful.spawn.with_shell("volctl")
	awful.spawn.with_shell("xautolock -time 10 -locker 'i3lock-fancy-multimonitor -b=0x3'")

	-- apps
	awful.spawn.with_shell("firefox")
	awful.spawn.with_shell("emacs")
	awful.spawn.with_shell("alacritty -e tmux new-session -A -s ArchLinux")
	awful.spawn.with_shell("slack")
	awful.spawn.with_shell("telegram-desktop")
	awful.spawn.with_shell("pcmanfm")
	awful.spawn.with_shell("obsidian")
	-- awful.spawn.with_shell("ledger-live-desktop")
end

-- End
-----------------------------------------------------------------------------------------------------------------------
return autostart
