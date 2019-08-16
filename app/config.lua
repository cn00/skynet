include "config.path.lua"

-- preload = "./examples/preload.lua"	-- run preload.lua before every lua service run
thread = 8
logger = nil
logpath = "."
harbor = 1
address = "127.0.0.1:2526"
master = "127.0.0.1:2013"
start = "main"	-- main script
bootstrap = "snlua bootstrap"	-- The service for bootstrap
standalone = "0.0.0.0:2013"
-- snax_interface_g = "snax_g"
cpath = "./?.so;./?.dylib;"
    .. root .. "cservice/?.so;" 
    .. root .. "cservice/?.dylib;"
    .. root .. "bin/Debug/?.so;"
    .. root .. "bin/Debug/?.dylib"
-- daemon = "./skynet.pid"
