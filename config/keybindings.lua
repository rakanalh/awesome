local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"

local function move_to_screen(dir)
	return function()
		if client.focus then
			client.focus:move_to_screen(dir == "right" and client.focus.screen.index + 1 or client.focus.screen.index - 1)
			client.focus:raise()
		end
	end
end

local function set_keybindings()
    awful.keyboard.append_global_keybindings(
        {
            awful.key({modkey}, "s", hotkeys_popup.show_help, {description = "show help", group = "awesome"}),
            awful.key({modkey, "Control"}, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),
            awful.key({modkey, "Shift"}, "q", awesome.quit, {description = "quit awesome", group = "awesome"}),
            awful.key(
                {modkey,}, "Return",
                function()
                    awful.spawn("/home/rakan/.config/rofi/launchers/type-1/launcher.sh")
                end,
                {description = "Open rofi", group = "launcher"}
            ),
            awful.key(
                { modkey, "Control" }, "Return",
                function() awful.spawn("/home/rakan/.config/rofi/launchers/type-1/calc.sh") end,
                { description = "Rofi Calc", group = "Actions" }
            ),
            awful.key(
                { modkey, "Control" }, "p",
                function()
                    awful.spawn("rofi -modi \"clipboard:greenclip print\" -show clipboard -run-command '{cmd}'")
                end,
                { description = "Clipboard manager", group = "Actions" }
            ),
            awful.key(
                {modkey, "Shift"}, "p",
                function()
                    awful.spawn("rofi-pass --last-used")
                end,
                {description = "Open rofi-pass", group = "launcher"}
            ),
            awful.key(
                {modkey}, "t",
                function()
                    awful.spawn(terminal)
                end,
                {description = "open a terminal", group = "launcher"}
            ),
            awful.key(
                { modkey, "Shift" }, "x", function() awful.spawn("i3lock-fancy-multimonitor -b=0x3") end,
                { description = "Lock screen", group = "Actions" }
            ),
        }
    )

    -- Media keys
    awful.keyboard.append_global_keybindings(
		{
			awful.key({}, "XF86AudioRaiseVolume", volume_raise, { description = "Increase volume", group = "Volume control" }),
			awful.key({}, "XF86AudioLowerVolume", volume_lower, { description = "Reduce volume", group = "Volume control" }),
			awful.key({}, "XF86AudioMute", volume_mute, { description = "Mute audio", group = "Volume control" }),
		}
    )

    -- Tags related keybindings
    awful.keyboard.append_global_keybindings({
            awful.key({modkey}, "Escape", awful.tag.history.restore, {description = "go back", group = "tag"})
    })
    -- @DOC_NUMBER_KEYBINDINGS@
    awful.keyboard.append_global_keybindings(
        {
            awful.key {
                modifiers = {modkey},
                keygroup = "numrow",
                description = "only view tag",
                group = "tag",
                on_press = function(index)
                    local screen = awful.screen.focused()
                    local tag = screen.tags[index]
                    if tag then
                        tag:view_only()
                    end
                end
            },
            awful.key {
                modifiers = {modkey, "Shift"},
                keygroup = "numrow",
                description = "move focused client to tag",
                group = "tag",
                on_press = function(index)
                    if client.focus then
                        local tag = client.focus.screen.tags[index]
                        if tag then
                            client.focus:move_to_tag(tag)
                        end
                    end
                end
            },
        }
    )

    -- center a floating window
    awful.keyboard.append_global_keybindings(
        {
            awful.key(
                {modkey},
                "Down",
                function()
                    awful.placement.centered(
                        client.focus,
                        {
                            honor_workarea = true
                        }
                    )
                end,
                {description = "Center a floating window", group = "client"}
            )
        }
    )

    -- Focus related keybindings
    awful.keyboard.append_global_keybindings(
        {
            awful.key(
                {modkey},
                "l",
                function()
                    awful.client.focus.byidx(1)
                end,
                {description = "focus next by index", group = "client"}
            ),
            awful.key(
                {modkey},
                "h",
                function()
                    awful.client.focus.byidx(-1)
                end,
                {description = "focus previous by index", group = "client"}
            ),
            awful.key(
                {modkey},
                "Tab",
                function()
                    awful.client.focus.history.previous()
                    if client.focus then
                        client.focus:raise()
                    end
                end,
                {description = "go back", group = "client"}
            ),
            awful.key(
                {modkey, "Control"},
                "n",
                function()
                    local c = awful.client.restore()
                    -- Focus restored client
                    if c then
                        c:activate {raise = true, context = "key.unminimize"}
                    end
                end,
                {description = "restore minimized", group = "client"}
            )
        }
    )

    -- Layout related keybindings
    awful.keyboard.append_global_keybindings(
        {
            awful.key(
                {modkey, "Shift"},
                "j",
                function()
                    awful.client.swap.byidx(1)
                end,
                {description = "swap with next client by index", group = "client"}
            ),
            awful.key(
                {modkey, "Shift"},
                "k",
                function()
                    awful.client.swap.byidx(-1)
                end,
                {description = "swap with previous client by index", group = "client"}
            ),
            awful.key(
                {modkey, "Control", "Shift"}, "h",
                move_to_screen("left"),
                { description = "Move client to the next screen", group = "Client swap"}
            ),
            awful.key(
                {modkey, "Control", "Shift"}, "l",
                move_to_screen("right"),
                { description = "Move client to the next screen", group = "Client swap"}
            ),
            awful.key(
                { modkey,}, ",",
                function()
                    awful.screen.focus_bydirection("left")
                    if client.focus then client.focus:raise() end
                end,
                { description = "Go to previous monitor", group = "Client focus"}
            ),
            awful.key(
                { modkey,}, ".",
                function()
                    awful.screen.focus_bydirection("right")
                    if client.focus then client.focus:raise() end
                end,
                { description = "Go to next monitor", group = "Client focus"}
            ),
            awful.key(
                {modkey},
                "u",
                awful.client.urgent.jumpto,
                {description = "jump to urgent client", group = "client"}
            ),
            awful.key(
                {modkey},
                "l",
                function()
                    awful.tag.incmwfact(0.05)
                end,
                {description = "increase master width factor", group = "layout"}
            ),
            awful.key(
                {modkey},
                "h",
                function()
                    awful.tag.incmwfact(-0.05)
                end,
                {description = "decrease master width factor", group = "layout"}
            ),
            awful.key(
                {modkey, "Shift"},
                "h",
                function()
                    awful.tag.incnmaster(1, nil, true)
                end,
                {description = "increase the number of master clients", group = "layout"}
            ),
            awful.key(
                {modkey, "Shift"},
                "l",
                function()
                    awful.tag.incnmaster(-1, nil, true)
                end,
                {description = "decrease the number of master clients", group = "layout"}
            ),
            awful.key(
                {modkey, "Control"},
                "h",
                function()
                    awful.tag.incncol(1, nil, true)
                end,
                {description = "increase the number of columns", group = "layout"}
            ),
            awful.key(
                {modkey, "Control"},
                "l",
                function()
                    awful.tag.incncol(-1, nil, true)
                end,
                {description = "decrease the number of columns", group = "layout"}
            ),
            awful.key(
                {modkey},
                "Tab",
                function()
                    awful.layout.inc(1)
                end,
                {description = "select next", group = "layout"}
            ),
            awful.key(
                {modkey, "Shift"},
                "Tab",
                function()
                    awful.layout.inc(-1)
                end,
                {description = "select previous", group = "layout"}
            )
        }
    )


    -- @DOC_CLIENT_KEYBINDINGS@
    client.connect_signal(
        "request::default_keybindings",
        function()
            awful.keyboard.append_client_keybindings(
                {
                    awful.key(
                        {modkey},
                        "f",
                        function(c)
                            c.fullscreen = not c.fullscreen
                            c:raise()
                        end,
                        {description = "toggle fullscreen", group = "client"}
                    ),
                    awful.key(
                        {modkey},
                        "q",
                        function(c)
                            c:kill()
                        end,
                        {description = "close", group = "client"}
                    ),
                    awful.key(
                        {modkey, "Control"},
                        "f",
                        awful.client.floating.toggle,
                        {description = "toggle floating", group = "client"}
                    ),
                    awful.key(
                        {modkey},
                        "o",
                        function(c)
                            c:move_to_screen()
                        end,
                        {description = "move to screen", group = "client"}
                    ),
                    awful.key(
                        {modkey},
                        "t",
                        function(c)
                            c.ontop = not c.ontop
                        end,
                        {description = "toggle keep on top", group = "client"}
                    ),
                    awful.key(
                        {modkey},
                        "n",
                        function(c)
                            -- The client currently has the input focus, so it cannot be
                            -- minimized, since minimized clients can't have the focus.
                            c.minimized = true
                        end,
                        {description = "minimize", group = "client"}
                    ),
                    awful.key(
                        {modkey},
                        "m",
                        function(c)
                            c.maximized = not c.maximized
                            c:raise()
                        end,
                        {description = "(un)maximize", group = "client"}
                    ),
                    awful.key(
                        {modkey, "Control"},
                        "m",
                        function(c)
                            c.maximized_vertical = not c.maximized_vertical
                            c:raise()
                        end,
                        {description = "(un)maximize vertically", group = "client"}
                    ),
                    awful.key(
                        {modkey, "Shift"},
                        "m",
                        function(c)
                            c.maximized_horizontal = not c.maximized_horizontal
                            c:raise()
                        end,
                        {description = "(un)maximize horizontally", group = "client"}
                    )
                }
            )
        end
    )
end

set_keybindings()
