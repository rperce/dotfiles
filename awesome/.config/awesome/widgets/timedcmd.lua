local wibox      = require('wibox')
local awful      = require('awful')

read = function(cmd)
    local file = io.popen(cmd, 'r')
    local output = file:read('*all')
    file:close()
    return output
end
timers = {get = function(index)
    if timers[index] ~= nil then
        return timers[index]
    else
        timers[index] = timer({ timeout = index })
        return timers[index]
    end
end}

hook_timer_with_cmd = function(timeout, obj, cmd, fn)
    timer = timers.get(timeout)
    if cmd ~= nil then
        timer:connect_signal('timeout', function()
            text = read(cmd)
            if text == nil then
                text = 'nil'
            end
            obj.markup = '<span>' .. text .. '</span>'
--            if fn ~= nil then
--                fn(obj, text)
--            end
        end)
        timer:emit_signal('timeout')
        timer:start()
    end
end

out = {}
out.new = function(table)
    table.timeout = table.timeout or 10
    table.t_timeout = table.t_timeout or table.timeout

    local widget = wibox.widget.textbox(table.default)
    hook_timer_with_cmd(table.timeout, widget, table.cmd, table.fn)
--    if table.t_default ~= nil then
--        tooltip = awful.tooltip({ objects = { widget }})
--        tooltip:set_text(table.t_default)
--        hook_timer_with_cmd(table.t_timeout, tooltip, table.t_cmd)
--    end
    return widget
end

return out
