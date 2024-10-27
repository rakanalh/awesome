---@diagnostic disable: undefined-global
local awful = require 'awful'
local helpers = require 'helpers'
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local gears = require 'gears'

local function update_tags(self, index, s)
    local markup_role = self:get_children_by_id('circle_tag')[1]

    local found = false
    local i = 1

    while i <= #s.selected_tags do
        if s.selected_tags[i].index == index then
            found = true
        end
        i = i + 1
    end

    if found then
        markup_role.bg = beautiful.white
    else
        markup_role.bg = beautiful.darkgrey
        for _, c in ipairs(client.get(s)) do
            for _, t in ipairs(c:tags()) do
                if t.index == index then
                    markup_role.bg = beautiful.lightgrey
                end
            end
        end
    end
end

local function get_taglist(s)
    return awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = {
            layout = wibox.layout.fixed.horizontal,
            spacing = 10,
        },
        style = {
            shape = gears.shape.circle,
        },
        buttons = {
            awful.button({}, 1, function (t)
                t:view_only()
            end),
            awful.button({}, 4, function (t)
                awful.tag.viewprev(t.screen)
            end),
            awful.button({}, 5, function (t)
                awful.tag.viewnext(t.screen)
            end)
        },
        widget_template = {
            {
                id = "circle_tag",
                forced_width = 10,
                shape = gears.shape.circle,
                widget = wibox.container.background,
            },
            widget = wibox.container.margin,
            update_callback = function (self, _, index)
                update_tags(self, index, s)
            end,
            create_callback = function (self, c3, index)
                update_tags(self, index, s)
            end,
        },
    }
end

return get_taglist
