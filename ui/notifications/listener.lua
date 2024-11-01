---@diagnostic disable: undefined-global

local awful = require 'awful'

local function get_notifications_object()
    return awful.screen.focused().notifications
end

-- listens for requests to toggle the dashboad in focused screen.
awesome.connect_signal('notifications::toggle', function ()
    get_notifications_object().toggle()
end)

awesome.connect_signal('notifications::visibility', function (v)
    if v then
        get_notifications_object().show()
    else
        get_notifications_object().hide()
    end
end)
