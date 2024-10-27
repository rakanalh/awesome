---@diagnostic disable: undefined-global
local awful = require 'awful'
local beautiful = require 'beautiful'
local gears = require 'gears'
local wibox = require 'wibox'
local helpers = require 'helpers'
local dpi = beautiful.xresources.apply_dpi
local gfs = gears.filesystem

-- enable visibility listener.
require 'ui.brightness.listener'

awful.spawn.easy_async_with_shell('python ' .. gfs.get_configuration_dir() .. 'scripts/brightness.py list', function (out)
    local monitors = {}
    local screens = gears.string.split(out, "\n")
    for index, screen in ipairs(screens) do
      local screen_info = gears.string.split(screen, ",")
      monitors[index] = screen_info
    end
    awesome.emit_signal('brightness::monitors', monitors)
end)

awful.screen.connect_for_each_screen(function (s)
    s.brightness = {}

    -- making it as a function to make sure it's loaded when i want.
    local function mkwidget ()
        local controls = require 'ui.brightness.controls'

        return wibox.widget {
            {
                {
                    {
                        {
                            controls,
                            spacing = dpi(12),
                            layout = wibox.layout.flex.horizontal,
                        },
                        margins = dpi(15),
                        widget = wibox.container.margin,
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

    s.brightness.popup = awful.popup {
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

    local self = s.brightness.popup

    -- the next functions are made like this to solve
    -- performace issues with the lot of signals inside the brightness.
    function s.brightness.toggle()
        if self.visible then
            s.brightness.hide()
        else
            s.brightness.show()
        end
    end

    function s.brightness.show()
        self.widget = mkwidget()
        self.visible = true
    end

    function s.brightness.hide()
        self.visible = false
        self.widget = wibox.widget {
            bg = beautiful.bg_normal,
            widget = wibox.container.background
        }
        collectgarbage('collect')
    end
end)
