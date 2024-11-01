---@diagnostic disable: undefined-global
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local awful = require 'awful'
local helpers = require 'helpers'
local dpi = beautiful.xresources.apply_dpi

local keyboard_layout = wibox.widget {
    widget = wibox.widget.textbox,
    forced_width = 20,
    markup = 'EN',
    valign = 'center',
    font = beautiful.nerd_font .. ' 15',
}

keyboard_layout:add_button(awful.button({}, 1, function ()

end))

awesome.connect_signal('xkb::group_changed', function ()
    keyboard_layout.text = "Hello"
end)

return keyboard_layout
