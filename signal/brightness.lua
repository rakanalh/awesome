---@diagnostic disable: undefined-global
local gears = require 'gears'
local awful = require 'awful'
local gfs = gears.filesystem

gears.timer {
    timeout = 5,
    call_now = true,
    autostart = true,
    callback = function ()
        awful.spawn.easy_async_with_shell(script, function (out)
            awesome.emit_signal('brightness::value', tonumber(out))
        end)
    end
}

local function set(number, val)
    awful.spawn('python ' .. gfs.get_configuration_dir() .. 'scripts/brightness.py set --monitor ' .. number .. ' --value ' .. val )
end

return { set = set }
