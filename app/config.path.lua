root = "./"

luaservice = "./?.lua;"
    .. root .. "service/?.lua;"
    .. root .. "app/?.lua;"
    .. root .. "app/?/init.lua;"

lualoader = root .. "lualib/loader.lua"

lua_path = root .. "./?.lua;"
    .. root .. "lualib/?.lua;"
    .. root .. "lualib/?/init.lua;" 
    .. root .. "app/?.lua;"
    .. root .. "examples/?.lua;"
    .. root .. "sharelua/?.lua;"
    .. root .. "sharelua/utility/?.lua;"
    .. root .. "sharelua/?/init.lua;"

lua_cpath = "?.so;?.dylib;lib?.so;lib?.dylib;"
    .. root .. "luaclib/?.so;"
    .. root .. "luaclib/?.dylib;"
    .. root .. "bin/Debug/?.so;"
    .. root .. "bin/Debug/?.dylib;"

snax = root.."app/?.lua;"
    .. root.."app/?.lua"
