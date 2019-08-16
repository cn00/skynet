root = "./"

luaservice = "./?.lua;"
    .. root .. "service/?.lua;"
    .. root .. "app/?.lua;"
    .. root .. "app/?/init.lua;"

lualoader = root .. "lualib/loader.lua"

lua_path = root.."lualib/?.lua;"
    .. root .. "lualib/?/init.lua;" 
    .. root .. "app/?.lua;"
    .. root .. "../Assets/BundleRes/lua/?.lua;" 

lua_cpath = "./?.so;./?.dylib;"
    .. root .. "luaclib/?.so;"
    .. root .. "luaclib/?.dylib;"
    .. root .. "bin/Debug/?.so;"
    .. root .. "bin/Debug/?.dylib;"

snax = root.."app/?.lua;"
    .. root.."app/?.lua"
