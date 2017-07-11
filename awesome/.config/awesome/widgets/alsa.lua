local awful     = require('awful')
local naughty   = require('naughty')
local vicious   = require('vicious')
local wibox     = require('wibox')
local margins = {
    right = 5,
    left = 0,
    top = 3,
    bottom = 3
}
local alsawidget = {
    step = '5%',
    control = 'amixer -D pulse',
    channel = 'Master',
    colors = {
        unmute = '#AECF96',
        mute = '#FF5656'
    },
    mixer = 'pavucontrol', -- or whatever your preferred sound mixer is
    notifications = {
        icons = {},
        font = 'Monospace 11', -- must be a monospace font for the bar to be sized consistently
        icon_size = 48,
        bar_size = 20 -- adjust to fit your font if the bar doesn't fit
    },
}
alsawidget.amixer_cmd = function(op, cmd)
    return alsawidget.control .. ' ' .. op .. ' ' .. alsawidget.channel .. ' ' .. cmd
end
alsawidget.fn_spawn_mixer = function()
    awful.util.spawn(alsawidget.mixer)
end
alsawidget.fn_toggle_mute = function()
    awful.util.spawn(alsawidget.amixer_cmd('sset', 'toggle'))
    vicious.force ({ alsawidget.bar })
end
alsawidget.fn_vol_up = function()
    awful.util.spawn(alsawidget.amixer_cmd('sset', alsawidget.step..'+'))
    vicious.force ({ alsawidget.bar })
end
alsawidget.fn_vol_down = function()
    awful.util.spawn (alsawidget.amixer_cmd('sset', alsawidget.step..'-'))
    vicious.force ({ alsawidget.bar })
end

-- widget
alsawidget.bar = wibox.widget{
    background_color    = '#494b4f',
    widget              = wibox.widget.progressbar,
    color               = alsawidget.colors.unmute,
}
alsawidget.widget = wibox.container.margin(wibox.widget{
    alsawidget.bar,
    forced_height       = 12,
    forced_width        = 12,
    direction           = 'east',
    layout              = wibox.container.rotate
}, 5, 0, 1, 1)
--alsawidget.bar:set_background_color ('#494B4F')
alsawidget.widget:buttons (awful.util.table.join (
    awful.button ({}, 1, alsawidget.fn_spawn_mixer),
    awful.button ({}, 3, alsawidget.fn_toggle_mute),
    awful.button ({}, 4, alsawidget.fn_vol_up),
    awful.button ({}, 5, alsawidget.fn_vol_down)
))

-- tooltip
alsawidget.tooltip = awful.tooltip ({ objects = { alsawidget.widget } })
-- naughty notifications
alsawidget._current_level = 0
alsawidget._muted = false
--
-- register the widget through vicious
vicious.register (alsawidget.bar, vicious.widgets.volume, function (widget, args)
    alsawidget._current_level = args[1]
    alsawidget.bar:set_value(args[1])
    if args[2] == '♩' then
        alsawidget._muted = true
        alsawidget.tooltip:set_text (' [Muted] ')
        alsawidget.bar.color = alsawidget.colors.mute
        return 100
    end
    alsawidget._muted = false
    alsawidget.tooltip:set_text (' ' .. alsawidget.channel .. ': ' .. args[1] .. '% ')
    alsawidget.bar.color = alsawidget.colors.unmute
    --widget:set_color(alsawidget.colors.unmute)
    return args[1]
end, 5, alsawidget.channel) -- relatively high update time, use of keys/mouse will force update

return alsawidget
