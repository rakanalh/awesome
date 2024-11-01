---@diagnostic disable: undefined-global
local awful = require 'awful'
local naughty = require 'naughty'
local beautiful = require 'beautiful'
local gears = require 'gears'
local wibox = require 'wibox'
local helpers = require 'helpers'
local dpi = beautiful.xresources.apply_dpi
local gfs = gears.filesystem

-- enable visibility listener.
require 'ui.notifications.listener'

awful.screen.connect_for_each_screen(function (s)
    s.notifications = {}

    local function mkwidget ()
        return wibox.widget {
            {
                {
                    {
                        base_layout = wibox.widget {
                            spacing_widget = wibox.widget {
                                orientation = "vertical",
                                span_ratio  = 0.5,
                                widget      = wibox.widget.separator,
                            },
                            forced_height = 30,
                            spacing       = 3,
                            layout        = wibox.layout.flex.horizontal
                        },
                        widget_template = {
                            {
                                naughty.widget.icon,
                                {
                                    naughty.widget.title,
                                    naughty.widget.message,
                                    {
                                        layout = wibox.widget {
                                            -- Adding the wibox.widget allows to share a
                                            -- single instance for all spacers.
                                            spacing_widget = wibox.widget {
                                                orientation = "vertical",
                                                span_ratio  = 0.9,
                                                widget      = wibox.widget.separator,
                                            },
                                            spacing = 3,
                                            layout  = wibox.layout.flex.horizontal
                                        },
                                        widget = naughty.list.widgets,
                                    },
                                    layout = wibox.layout.align.vertical
                                },
                                spacing = 10,
                                fill_space = true,
                                layout  = wibox.layout.fixed.horizontal
                            },
                            margins = 5,
                            widget  = wibox.container.margin
                        },
                        widget = naughty.list.notifications,
                    },
                    bg = beautiful.bg_normal,
                    widget = wibox.container.background,
                    shape = function (cr, w, h)
                        return gears.shape.partially_rounded_rect(cr, w, h, true, true, false, false, dpi(12))
                    end
                },
                nil,
                spacing = dpi(15),
                layout = wibox.layout.align.vertical,
            },
            bg = beautiful.bg_lighter,
            fg = beautiful.fg_normal,
            widget = wibox.container.background,
            shape = helpers.mkroundedrect(),
        }
    end

    s.notifications.popup = awful.popup {
        placement = function (d)
            return awful.placement.bottom_right(d, {
                margins = {
                    bottom = beautiful.bar_height + beautiful.useless_gap * 2,
                },
            })
        end,
        ontop = true,
        visible = false,
        shape = helpers.mkroundedrect(),
        bg = '#00000000',
        minimum_width = dpi(455),
        fg = beautiful.fg_normal,
        screen = s,
        widget = wibox.widget {
            bg = beautiful.bg_normal,
            widget = wibox.container.background,
        },
    }

    local self = s.notifications.popup

    -- the next functions are made like this to solve
    -- performace issues with the lot of signals inside the notifications.
    function s.notifications.toggle()
        if self.visible then
            s.notifications.hide()
        else
            s.notifications.show()
        end
    end

    function s.notifications.show()
        self.widget = mkwidget()
        self.visible = true
    end

    function s.notifications.hide()
        self.visible = false
        self.widget = wibox.widget {
            bg = beautiful.bg_normal,
            widget = wibox.container.background
        }
        collectgarbage('collect')
    end
end)
