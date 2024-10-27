---@diagnostic disable: undefined-global
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local gfs = require 'gears.filesystem'
local awful = require 'awful'
local helpers = require 'helpers'

local function get_brightness()
    local brightness = wibox.widget {
        id = 'brightness_action_icon',
        widget = wibox.widget.textbox,
        markup = '󰃞',
        font = beautiful.nerd_font .. ' 15',
        forced_width = 20,
        valign = 'center',
    }

    brightness:add_button(awful.button({}, 1, function ()
        require 'ui.brightness'
        awesome.emit_signal('brightness::toggle')
    end))

    return brightness
end

return get_brightness()
