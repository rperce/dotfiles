local timedcmd = require('widgets/timedcmd')

return timedcmd.new({
    default     = 'Time',
    cmd         = '/home/robert/path/wordtime -t',
    t_default   = 'Date/Time',
    t_cmd       = '/home/robert/path/wordtime'
})
