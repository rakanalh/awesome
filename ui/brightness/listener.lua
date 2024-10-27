---@diagnostic disable: undefined-global

local awful = require 'awful'

local function get_brightness_object()
    return awful.screen.focused().brightness
end

-- listens for requests to toggle the dashboad in focused screen.
awesome.connect_signal('brightness::toggle', function ()
    get_brightness_object().toggle()
end)

awesome.connect_signal('brightness::visibility', function (v)
    if v then
        get_brightness_object().show()
    else
        get_brightness_object().hide()
    end
end)
