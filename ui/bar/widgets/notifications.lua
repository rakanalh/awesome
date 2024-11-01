---@diagnostic disable: undefined-global
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local awful = require 'awful'
local helpers = require 'helpers'
local dpi = beautiful.xresources.apply_dpi

local notifications = wibox.widget {
    widget = wibox.widget.textbox,
    forced_width = 20,
    markup = '󰭹',
    valign = 'center',
    font = beautiful.nerd_font .. ' 15',
}

local tooltip = helpers.make_popup_tooltip('Notifications list', function (d)
    return awful.placement.bottom_right(d, {
        margins = {
            bottom = beautiful.bar_height + beautiful.useless_gap * 2,
            right = beautiful.useless_gap * 2 + 85,
        }
    })
end)

tooltip.attach_to_object(notifications)

notifications:add_button(awful.button({}, 1, function ()
    require 'ui.notifications'
    awesome.emit_signal('notifications::toggle')
end))

return notifications
