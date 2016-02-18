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

return function(time, text, cmd, t_text, t_cmd)
    local widget = wibox.widget.textbox()
    widget:set_text(text)
    w_timer = timers.get(time)
    if cmd ~= nil then
        w_timer:connect_signal('timeout', function()
            text = get_output(cmd)
            if text ~= nil then
                widget:set_text(text)
            end
        end)
        w_timer:emit_signal('timeout')
        w_timer:start()
    end
    if t_text ~= nil then
        widget_t = awful.tooltip({ objects = { widget },})
        widget_t:set_text(t_text)
        if t_cmd ~= nil then
            w_timer:connect_signal('timeout', function()
                text = get_output(t_cmd)
                if text ~= nil then
                    widget_t:set_text(text)
                end
            end)
            w_timer:emit_signal('timeout')
            w_timer:start()
        end
    end
    return widget
end
