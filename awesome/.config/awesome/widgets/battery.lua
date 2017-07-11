local timedcmd   = require('widgets/timedcmd')
local naughty    = require('naughty')
local beautiful  = require('beautiful')
local awful      = require('awful')

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
    cmd     = '/home/robert/path/shortacpi',
    fn      = function(self, output)
        self.last = self.last or -1
        updown = read('echo "' .. output .. '" | cut -d" " -f4')
        if updown == "⚡" then
            self.last = -1
            --self.markup = output
        else
            if self.last == -1 then
                self.last = 102
            end
            percent = tonumber(read('echo ' .. output .. ' | cut -d% -f1'))
            if percent == nil then percent = 100 end
            for i = #stops, 1, -1 do
                stop = stops[i]
                if self.last > stop.percent and percent <= stop.percent then
                    naughty.notify({ title=stop.title, text=stop.text })
                    self.color = stop.color
                end
            end
            self.last = percent
            self.markup = '<span color="' .. self.color .. '">' .. output .. '</span>'
        end
    end
})
return out
