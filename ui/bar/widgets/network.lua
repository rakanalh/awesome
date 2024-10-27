---@diagnostic disable: undefined-global
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local gfs = require 'gears.filesystem'
local awful = require 'awful'
local helpers = require 'helpers'

require "signal.network"

local function get_network()
    local network = wibox.widget {
        id = 'wifi_action_icon',
        widget = wibox.widget.textbox,
        markup = beautiful.network_connected,
        font = beautiful.nerd_font .. ' 15',
        forced_width = 20,
        valign = 'center',
    }

    local tooltip = helpers.make_popup_tooltip('Press to toggle network', function (d)
        return awful.placement.bottom_right(d, {
            margins = {
                bottom = beautiful.bar_height + beautiful.useless_gap * 2,
                right = beautiful.useless_gap * 2 + 85,
            }
        })
    end)

    tooltip.attach_to_object(network)

    network:add_button(awful.button({}, 1, function ()
        awful.spawn('bash ' .. gfs.get_configuration_dir() .. 'scripts/toggle-network.sh')
    end))

    awesome.connect_signal('network::connected', function (is_connected)
        network.markup = is_connected
            and beautiful.network_connected
            or beautiful.network_disconnected
    end)
    return network
end

return get_network()
