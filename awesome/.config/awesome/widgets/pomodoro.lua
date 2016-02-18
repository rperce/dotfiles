local beautiful = require('beautiful')
local wibox     = require('wibox')
local awful     = require('awful')
local naughty   = require('naughty')

local pomodoro      = {}
pomodoro.rest       = 301
pomodoro.work       = 1501

pomodoro.rest_done  = {title = 'Break finished.', text = 'Get back to work!'}
pomodoro.work_done  = {title = 'Work complete.', text  = 'Time for a break!'}

pomodoro.widget     = wibox.widget.textbox()
pomodoro.tooltip    = awful.tooltip({ objects = {pomodoro.widget} })
pomodoro.timer      = timer({ timeout         = 1})

pomodoro.doing      = 'none'
pomodoro.time_left  = pomodoro.rest

function pomodoro:notify(contents)
    naughty.notify({
        title = contents.title,
        text  = contents.text
    })
end
local function set_tomato(color)
    if color ~= nil then
        pomodoro.color = color
    end
    pomodoro.widget:set_markup(string.format(
        '<b><span size="x-large" foreground="%s">&#x1f345;</span></b>',
        pomodoro.color))

    if pomodoro.color == beautiful.fg_normal then
        pomodoro.tooltip:set_markup(string.format(
            '<span size="xx-large" foreground="%s"><b>&#x1f345; </b></span><span size="x-large">Pomodoro timer</span>',
            pomodoro.color))
    else
        local m = pomodoro.time_left // 60
        local s = pomodoro.time_left - m * 60
        pomodoro.tooltip:set_markup(string.format(
            '<span size="xx-large" foreground="%s"><b>&#x1f345; </b></span><span size="x-large"><b>%dm %ds</b> remaining</span>',
            pomodoro.color, m, s))
    end
end
pomodoro.timer:connect_signal('timeout', function()
    pomodoro.time_left = pomodoro.time_left - 1
    if (pomodoro.time_left == 0) then
        if pomodoro.doing == 'rest' then
            pomodoro:notify(pomodoro.rest_done)
            pomodoro.time_left = pomodoro.work
            set_tomato('red')
            pomodoro.doing = 'work'
        elseif pomodoro.doing == 'work' then
            pomodoro:notify(pomodoro.work_done)
            pomodoro.time_left = pomodoro.rest
            set_tomato('green')
            pomodoro.doing = 'rest'
        end
    end
    set_tomato()
end)

pomodoro.widget:buttons(
    awful.util.table.join(
        awful.button({ }, 1, function()
            if pomodoro.doing == 'none' then
                pomodoro.doing = 'work'
                set_tomato('red')
                pomodoro.time_left = pomodoro.work
                pomodoro.timer:start()
                pomodoro.timer:emit_signal('timeout')
            elseif pomodoro.doing == 'work' then
                pomodoro.timer:stop()
                pomodoro.doing = 'work_pause'
                set_tomato('#a50')
            elseif pomodoro.doing == 'work_pause' then
                pomodoro.doing = 'work'
                set_tomato('red')
                pomodoro.timer:start()
            elseif pomodoro.doing == 'rest' then
                pomodoro.timer:stop()
                pomodoro.doing = 'rest_pause'
                set_tomato('#dc0')
            elseif pomodoro.doing == 'rest_pause' then
                pomodoro.doing = 'rest'
                set_tomato('#1c0')
                pomodoro.timer:start()
            end
        end),
        awful.button({ }, 3, function() -- right click
            if pomodoro.doing == 'work' or pomodoro.doing == 'work_pause' then
                pomodoro.timer:stop()
                pomodoro.doing = 'rest'
                set_tomato('#1c0')
                pomodoro.time_left = pomodoro.rest
                pomodoro.timer:again()
                pomodoro.timer:emit_signal('timeout')
            elseif pomodoro.doing == 'rest' or pomodoro.doing == 'rest_pause' then
                pomodoro.timer:stop()
                pomodoro.doing = 'work'
                set_tomato('red')
                pomodoro.time_left = pomodoro.work
                pomodoro.timer:again()
                pomodoro.timer:emit_signal('timeout')
            end
        end),
        awful.button({ }, 2, function() -- middle click
            pomodoro.timer:stop()
            pomodoro.doing = 'none'
            set_tomato(beautiful.fg_normal)
        end)
    )
)



set_tomato(beautiful.fg_normal)

return pomodoro.widget

