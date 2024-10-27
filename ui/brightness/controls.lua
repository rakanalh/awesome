---@diagnostic disable: undefined-global
local awful = require 'awful'
local wibox = require 'wibox'
local helpers = require 'helpers'
local beautiful = require 'beautiful'
local gears = require 'gears'

local dpi = beautiful.xresources.apply_dpi

local function base_slider (name, number)
    return wibox.widget {
        {
            {
                {
                    {
                        markup = name,
                        font = beautiful.nerd_font .. '20',
                        widget = wibox.widget.textbox,
                    },
                    bottom = dpi(8),
                    widget = wibox.container.margin,
                },
                fg = beautiful.grey,
                widget = wibox.container.background,
            },
            {
                {
                    {
                        id = 'slider',
                        bar_shape = gears.shape.rounded_bar,
                        bar_height = 25,
                        bar_active_color = beautiful.blue,
                        bar_color = beautiful.grey,
                        handle_color = beautiful.blue,
                        handle_shape = gears.shape.circle,
                        handle_width = 25,
                        handle_border_width = 1,
                        value = 0,
                        forced_width = 350,
                        forced_height = 1,
                        widget = wibox.widget.slider,
                    },
                    {
                        {
                            {
                                id = 'icon_role',
                                markup = '',
                                valign = 'center',
                                align = 'left',
                                font = beautiful.nerd_font .. ' 15',
                                widget = wibox.widget.textbox,
                            },
                            fg = beautiful.bg_normal,
                            widget = wibox.container.background,
                        },
                        left = dpi(7),
                        widget = wibox.container.margin,
                    },
                    layout = wibox.layout.stack,
                },
                bottom = dpi(8),
                widget = wibox.container.margin,
            },
            layout = wibox.layout.fixed.vertical,
        },
        layout = wibox.layout.fixed.vertical,
        set_value = function (self, value)
            self:get_children_by_id('slider')[1].value = value
        end,
        set_icon = function (self, new_icon)
            self:get_children_by_id('icon_role')[1].markup = new_icon
        end,
        get_slider = function (self)
            return self:get_children_by_id('slider')[1]
        end
    }
end

local container = wibox.layout.fixed.vertical()
awesome.connect_signal('brightness::monitors', function(monitors)
    for index, monitor in ipairs(monitors) do
       local monitor_name = monitor[1]
       local monitor_number = monitor[2]
       local monitor_brightness = monitor[3]
       if monitor_name ~= nil and monitor_name ~= '' then
            -- brightness
            local brightness_slider = base_slider(monitor_name, monitor_number)
            brightness_slider.value = tonumber(monitor_brightness)

            -- signals
            brightness_slider.slider:connect_signal('property::value', function (_, new_br)
                BrightnessSignal.set(monitor_number, new_br)
            end)

            container:add(brightness_slider)
       end
    end
end)

local controls = wibox.widget {
    {
        {
            {
                {
                    {
                        {
                            markup = 'Controls',
                            font = beautiful.nerd_font .. '25',
                            widget = wibox.widget.textbox,
                        },
                        bottom = dpi(8),
                        widget = wibox.container.margin,
                    },
                    fg = beautiful.grey,
                    widget = wibox.container.background,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            {
                container,
                spacing = dpi(12),
                layout = wibox.layout.fixed.vertical,
            },
            nil,
            layout = wibox.layout.align.vertical,
        },
        margins = dpi(12),
        widget = wibox.container.margin,
    },
    shape = helpers.mkroundedrect(),
    bg = beautiful.bg_contrast,
    widget = wibox.container.background,
}

return controls
