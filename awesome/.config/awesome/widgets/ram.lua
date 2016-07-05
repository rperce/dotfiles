local wibox     = require('wibox')
local ramwidget = wibox.widget.textbox()
local get_output= require('get_output')
local ram_cmd = function(get, file)
    return 'cat /proc/meminfo '
        .. '| grep "' .. get .. ':" '
        .. '| perl -ne \'$_ =~ /([0-9]+)/; print $1."\n"\''
 end

ramwidget:set_text('Ram Usage')
ramtimer = timer({ timeout = 5 })
ramtimer:connect_signal("timeout",
    function()
        local file = '~/.config/awesome/ramusage'
        os.execute(ram_cmd('Active') .. '>> ' .. file)
        os.execute('tail -n 9 ' .. file .. ' | sponge ' .. file)
        os.execute('cat ' .. file .. ' > ' .. file .. '.full')
        os.execute(ram_cmd('MemTotal') .. '>> ' .. file .. '.full')
        text = get_output('cat ' .. file .. '.full '
                       .. '| sparklines '
                       .. '| sed "s/.$//"')
        ramwidget:set_text(text)
    end
)
ramtimer:start()

return ramwidget
