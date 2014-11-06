local wibox = require("wibox")
local function popen(cmd)
    f = assert(io.popen(cmd, "r"))
    s = f:read('*l*')
    f:close()
    return s or ''
end
wifi = {
    con='nil',
    str='?',
    widget = wibox.widget.textbox(),
    timer = timer({ timeout = 5 })
}
local function update()
    local c = popen("netctl list | grep -Po '(?<=\\* )(.+)'")
    if c:find("wifi") then
        wifi.con=(c)
        wifi.str=popen("awk 'NR==3 {print $3}' /proc/net/wireless | sed 's/\\./%/'")
    elseif c:find("eth") then
        wifi.con='enp'
        wifi.str=''
    else
        wifi.con='nil'
        wifi.str='?'
    end
    --(wifi.widget):set_text(" | "..(c).." | ")
    (wifi.widget):set_text(" | "..(wifi.con).." "..(wifi.str).." | ")
end

wifi.widget:set_text(" | Internet | ")
wifi.timer = timer({ timeout = 5 })
wifi.timer:connect_signal("timeout",
    function()  
        update()
    end
)
return wifi

