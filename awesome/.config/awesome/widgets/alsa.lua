local awful     = require("awful")
local naughty   = require("naughty")
local vicious   = require("vicious")
local alsawidget = {
    control = "pactl",
    card = "1",
    step = "5%",
    colors = {
		unmute = "#AECF96",
		mute = "#FF5656"
	},
	mixer = "pavucontrol", -- or whatever your preferred sound mixer is
    notifications = {
        icons = {},
		font = "Monospace 11", -- must be a monospace font for the bar to be sized consistently
		icon_size = 48,
		bar_size = 20 -- adjust to fit your font if the bar doesn't fit
	},
}
alsawidget.amixer_cmd = function(op, cmd)
    return alsawidget.control .. ' ' alsawidget.op .. ' ' .. alsawidget.card .. ' ' .. cmd
end
alsawidget.fn_spawn_mixer = function()
    awful.util.spawn(alsawidget.mixer)
end
alsawidget.fn_toggle_mute = function()
    awful.util.spawn(alsawidget.amixer_cmd('set-sink-mute', 'toggle'))
    vicious.force ({ alsawidget.bar })
end
alsawidget.fn_vol_up = function()
    awful.util.spawn(alsawidget.amixer_cmd('set-sink-mute', '0'))
    awful.util.spawn(alsawidget.amixer_cmd('set-sink-volume', '+'..alsawidget.step))
    vicious.force ({ alsawidget.bar })
end
alsawidget.fn_vol_down = function()
    awful.util.spawn(alsawidget.amixer_cmd('set-sink-mute', '0'))
    awful.util.spawn (alsawidget.amixer_cmd('set-sink-volume', '-'..alsawidget.step))
    vicious.force ({ alsawidget.bar })
end

-- widget
alsawidget.bar = awful.widget.progressbar ()
alsawidget.bar:set_width (10)
alsawidget.bar:set_height(10)
alsawidget.bar:set_vertical (true)
alsawidget.bar:set_background_color ("#494B4F")
alsawidget.bar:set_color (alsawidget.colors.unmute)
alsawidget.bar:buttons (awful.util.table.join (
	awful.button ({}, 1, alsawidget.fn_spawn_mixer),
	awful.button ({}, 3, alsawidget.fn_toggle_mute),
	awful.button ({}, 4, alsawidget.fn_vol_up),
	awful.button ({}, 5, alsawidget.fn_vol_down)
))

-- tooltip
alsawidget.tooltip = awful.tooltip ({ objects = { alsawidget.bar } })
-- naughty notifications
alsawidget._current_level = 0
alsawidget._muted = false
--
-- register the widget through vicious
vicious.register (alsawidget.bar, vicious.widgets.volume, function (widget, args)
	alsawidget._current_level = args[1]
	if args[2] == "♩"
	then
		alsawidget._muted = true
		alsawidget.tooltip:set_text (" [Muted] ")
		widget:set_color (alsawidget.colors.mute)
		return 100
	end
	alsawidget._muted = false
	alsawidget.tooltip:set_text (" " .. alsawidget.channel .. ": " .. args[1] .. "% ")
	widget:set_color (alsawidget.colors.unmute)
	return args[1]
end, 5, alsawidget.channel) -- relatively high update time, use of keys/mouse will force update

return alsawidget
