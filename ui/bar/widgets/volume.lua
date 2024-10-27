---@diagnostic disable: undefined-global
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local awful = require 'awful'
local helpers = require 'helpers'
local dpi = beautiful.xresources.apply_dpi

local VOLUME_ON_ICON = ''
local VOLUME_OFF_ICON = ''

local volume = wibox.widget {
    widget = wibox.widget.textbox,
    forced_width = 20,
    markup = VOLUME_ON_ICON,
    valign = 'center',
    font = beautiful.nerd_font .. ' 15',
}

local tooltip = helpers.make_popup_tooltip('Press to mute/unmute', function (d)
    return awful.placement.bottom_right(d, {
        margins = {
            bottom = beautiful.bar_height + beautiful.useless_gap * 2,
            right = beautiful.useless_gap * 2 + 85,
        }
    })
end)

tooltip.attach_to_object(volume)

volume:add_button(awful.button({}, 1, function ()
    VolumeSignal.toggle_muted()
end))

awesome.connect_signal('volume::muted', function (is_muted)
    volume.text = is_muted
        and VOLUME_OFF_ICON
        or VOLUME_ON_ICON
end)

return volume
