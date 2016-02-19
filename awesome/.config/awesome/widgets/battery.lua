local timedcmd   = require('widgets/timedcmd')
local get_output = require('get_output')
local naughty    = require('naughty')

out = timedcmd.new({
    default = 'Battery',
    cmd     = '/home/robert/path/shortacpi'
})

out.last = 100
out.timer:connect_signal('timeout', function()
    updown = get_output('echo ' .. out.text .. ' | cut -d" " -f4')
    if updown ~= "⚡" then
        if out.last == -1 then
            out.last = 100
        end
        percent = tonumber(get_output('echo ' .. out.text .. ' | cut -d% -f1'))
        if out.last > 3 and percent < 3 then
            naughty.notify({ title='VERY LOW POWER!', text='FIND POWER' })
            out:set_markup('<span color="red">'..out.text..'</span>')
            out.last = 2
        elseif out.last > 6 and percent < 6 then
            naughty.notify({ title='Low Power!', text='Plug your computer in as soon as possible!' })
            out:set_markup('<span color="red">'..out.text..'</span>')
            out.last = 5
        elseif out.last > 16 and percent < 16 then
            naughty.notify({ title='Losing Power!', text='Maybe find some power' })
            out:set_markup('<span color="#c60">'..out.text..'</span>')
            out.last = 15
        end
    else
        out.last = -1
        out:set_markup(out.text)
    end
end)
return out
