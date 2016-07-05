local timedcmd = require('widgets/timedcmd')

return timedcmd.new({
    default     = 'Time',
    cmd         = '~/path/wordtime -t',
    t_default   = 'Date/Time',
    t_cmd       = '~/path/wordtime'
})
