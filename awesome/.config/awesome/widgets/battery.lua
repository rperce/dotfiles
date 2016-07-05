local timedcmd   = require('widgets/timedcmd')
local get_output = require('get_output')
local naughty    = require('naughty')
local beautiful  = require('beautiful')

stops = {
    { percent = 100,
      title   = 'Discharging',
      text    = '',
      color   = beautiful.widget_good or '#2f2' },
    { percent = 50,
      title   = 'Halfway Depleted',
      text    = "You've got a while",
      color   = beautiful.fg_normal },
    { percent = 15,
      title   = 'Losing Power!',
      text    = 'Maybe go find some power?',
      color   = beautiful.widget_okay or '#c71' },
    { percent = 5,
      title   = 'Low Power!',
      text    = 'Plug your laptop in as soon as possible!',
      color   = beautiful.widget_bad or '#f44' },
    { percent = 2,
      title   = 'CRITICALLY LOW POWER',
      text    = 'OMG YOUR LAPTOP IS GOING TO DIE',
      color   = beautiful.widget_bad or '#f44' },
}

out = timedcmd.new({
    default = 'Battery',
    cmd     = '~/path/shortacpi'
})

out.last = -1
out.timer:connect_signal('timeout', function()
    updown = get_output('echo ' .. out.text .. ' | cut -d" " -f4')
    if updown == "⚡" then
        out.last = -1
        out:set_markup(out.text)
    else
        if out.last == -1 then
            out.last = 102
        end
        percent = tonumber(get_output('echo ' .. out.text .. ' | cut -d% -f1'))
        if percent == nil then percent = 100 end
        for i = #stops, 1, -1 do
            stop = stops[i]
            if out.last > stop.percent + 1 and percent < stop.percent + 1 then
                naughty.notify({ title=stop.title, text=stop.text })
                out.color = stop.color
                out.last = stop.percent
            end
        end
        out:set_markup('<span color="' .. out.color .. '">' .. out.text .. '</span>')
    end
end)
return out
