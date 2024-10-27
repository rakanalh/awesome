
local ruled = require "ruled"
local awful = require "awful"

local function setup_rules ()
    ruled.client.connect_signal("request::rules", function()
        ruled.client.append_rule {
            id         = "global",
            rule       = { },
            properties = {
                focus     = awful.client.focus.filter,
                raise     = true,
                screen    = awful.screen.preferred,
                placement = awful.placement.no_overlap+awful.placement.no_offscreen
            }
        }
        ruled.client.append_rule {
            id       = "floating",
            rule_any = {
                instance = { "copyq", "pinentry" },
                class    = {
                    "Arandr", "Blueman-manager", "Wpa_gui", "mpv",
                    "gnome-calculator", "deepin-calculator", "dde-calendar"
                },
                name    = {
                    "Event Tester",  -- xev.
                },
                role    = {
                    "AlarmWindow",    -- Thunderbird's calendar.
                    "ConfigManager",  -- Thunderbird's about:config.
                    "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
                }
            },
            properties = { floating = true }
        }

        ruled.client.append_rule {
            id = "maximized",
            rule = {
                class = { "Emacs", "Alacritty", "neovide" }
            },
            properties = { maximized_vertical = true, maximized_horizontal = true }
        }
        ruled.client.append_rule {
            id         = "titlebars",
            rule_any   = { type = { "normal", "dialog" } },
            properties = { titlebars_enabled = true }
        }

		ruled.client.append_rule {
			rule_any = { type = { "normal" } },
			properties = { placement = awful.placement.no_overlap + awful.placement.no_offscreen },
		}
		ruled.client.append_rule {
			rule = { class = "firefox" },
			properties = { screen = screen_primary, tag = screen.primary.tags[1] },
		}
		ruled.client.append_rule {
			rule = { class = "qutebrowser" },
			properties = { screen = screen_primary, tag = screen.primary.tags[1] },
		}
		ruled.client.append_rule {
			rule = { class = "Google-chrome" },
			properties = { screen = screen_primary, tag = screen.primary.tags[1] },
		}
		ruled.client.append_rule {
			rule = { class = "vivaldi-stable" },
			properties = { screen = screen_primary, tag = screen.primary.tags[1] },
		}
		ruled.client.append_rule {
			rule = { class = "Emacs" },
			properties = { screen = screen_primary, tag = screen.primary.tags[3] },
		}
		ruled.client.append_rule {
			rule = { class = "URxvt" },
			properties = { screen = screen_primary, tag = screen.primary.tags[2] },
		}
		ruled.client.append_rule {
			rule = { class = "Alacritty" },
			properties = { screen = screen_primary, tag = screen.primary.tags[2] },
		}
		ruled.client.append_rule {
			rule = { class = "Slack" },
			properties = { screen = screen_secondary, tag = screen.primary.tags[4] },
		}
		ruled.client.append_rule {
			rule = { class = "discord" },
			properties = { screen = screen_secondary, tag = screen.primary.tags[4] },
		}
		ruled.client.append_rule {
			rule = { class = "Element" },
			properties = { screen = screen_secondary, tag = screen.primary.tags[4] },
		}
		ruled.client.append_rule {
			rule = { class = "Rocket.Chat" },
			properties = { screen = screen_secondary, tag = screen.primary.tags[4] },
		}
		ruled.client.append_rule {
			rule = { class = "zoom" },
			properties = { screen = screen_secondary, tag = screen.primary.tags[7] },
		}
		ruled.client.append_rule {
			rule = { class = "TelegramDesktop" },
			properties = { screen = screen_secondary, tag = screen.primary.tags[4] },
		}
		ruled.client.append_rule {
			rule = { class = "Thunderbird" },
			properties = { screen = screen_secondary, tag = screen.primary.tags[4] },
		}
		ruled.client.append_rule {
			rule = { class = "polar-bookshelf" },
			properties = { screen = screen_primary, tag = screen.primary.tags[6] },
		}
		ruled.client.append_rule {
			rule = { class = "Zeal" },
			properties = { screen = screen_primary, tag = screen.primary.tags[3] },
		}
		ruled.client.append_rule {
			rule = { class = "obsidian" },
			properties = { screen = screen_primary, tag = screen.primary.tags[6] },
		}
		ruled.client.append_rule {
			rule = { class = "Pcmanfm" },
			properties = { screen = screen_primary, tag = screen.primary.tags[7] },
		}
		ruled.client.append_rule {
			rule = { class = "Ledger Live" },
			properties = { screen = screen_secondary, tag = screen.primary.tags[8] },
		}
		-- Tags placement
		ruled.client.append_rule {
			rule = { instance = "Xephyr" },
			properties = { tag = screen.primary.tags[9], fullscreen = true },
		}

		-- Jetbrains splash screen fix
		ruled.client.append_rule {
			rule_any = { class = { "jetbrains-%w+", "java-lang-Thread" } },
			callback = function(jetbrains)
				if jetbrains.skip_taskbar then
					jetbrains.floating = true
				end
			end,
		}
    end)

    ruled.notification.connect_signal("request::rules", function ()
        ruled.notification.append_rule {
            rule = { },
            properties = {
                screen = awful.screen.preferred,
                implicit_timeout = 5,
            }
        }
    end)
end

setup_rules()
