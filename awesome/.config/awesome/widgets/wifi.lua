local timedcmd = require('widgets/timedcmd')

local cmd = "echo $(netctl list | grep -Po '(?<=\\* )(.+)')"
         .. " $(awk 'NR==3 {print $3}' /proc/net/wireless | sed 's/\\./%/')"
return timedcmd({   default = 'Network',
                    cmd     = cmd })
