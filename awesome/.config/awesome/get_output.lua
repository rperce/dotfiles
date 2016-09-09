return function(cmd)
    fh = assert(io.popen(cmd, "r"))
    text = fh:read("*l*")
    fh:close()
    return text
end

