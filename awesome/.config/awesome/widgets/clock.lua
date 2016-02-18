local updatetext = require('widgets/updatetext')

local scmd = '/home/robert/path/wordtime -t'
local lcmd = '/home/robert/path/wordtime'
return updatetext(10, 'Time', scmd, 'Date/Time', lcmd)
