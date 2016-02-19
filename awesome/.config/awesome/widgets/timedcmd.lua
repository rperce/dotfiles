local wibox      = require('wibox')
local awful      = require('awful')
local get_output = require('get_output')

timers = {get = function(index)
    if timers[index] ~= nil then
        return timers[index]
    else
        timers[index] = timer({ timeout = index })
        return timers[index]
    end
end}

hook_timer_with_cmd = function(timeout, obj, cmd)
    obj.timer = obj.timer or timers.get(timeout)
    if cmd ~= nil then
        obj.timer:connect_signal('timeout', function()
            text = get_output(cmd)
            if text ~= nil then
                obj:set_text(text)
                obj.text = text
            end
        end)
        obj.timer:emit_signal('timeout')
        obj.timer:start()
    end
end

out = {}
out.new = function(table)
    table.timeout = table.timeout or 10
    table.t_timeout = table.t_timeout or table.timeout

    local widget = wibox.widget.textbox()
    widget:set_text(table.default)
    hook_timer_with_cmd(table.timeout, widget, table.cmd)
    if table.t_default ~= nil then
        tooltip = awful.tooltip({ objects = { widget }})
        tooltip:set_text(table.t_default)
        hook_timer_with_cmd(table.t_timeout, tooltip, table.t_cmd)
    end
    return widget
end

return out
