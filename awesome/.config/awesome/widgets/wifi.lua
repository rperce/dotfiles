local updatetext = require('widgets/updatetext')

local cmd = "echo $(netctl list | grep -Po '(?<=\\* )(.+)')"
         .. " $(awk 'NR==3 {print $3}' /proc/net/wireless | sed 's/\\./%/')"
return updatetext(10, 'Network', cmd)
