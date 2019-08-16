local skynet = require "skynet"
local sprotoloader = require "sprotoloader"
local ffi = require "ffi"
local config = require("appconfig")

require("utility.init")
local debug = require("mobdebug.mobdebug")
debug.start("0.0.0.0")
  
local max_client = 64

local function ffi_test()

	for k,v in pairs(ffi) do 
		print(k,v)
	end

	local testffi = ffi.cdef [[
		int printf ( const char * format, ... );
		int fprintf ( void* stream, const char * format, ... );
	]]
	local ffir = ffi.C.printf("testffi: %s\n", "fooffffffffff")
	print(">>>ffir", ffir)
	local f = io.open("./app/ffi.test.txt", "a")
	ffi.C.fprintf(f, "test: %s\n", "foo")
	ffi.C.fprintf(io.stdout, "io.stdout: test: %s\n", "foo")
end

skynet.start(function()
	print("Server start")

	skynet.uniqueservice("game")

	if not skynet.getenv "daemon" then
		local console = skynet.newservice("console")
	end
	
	skynet.newservice("debug_console",8000)
	-- skynet.newservice("simpledb")

	local watchdog = skynet.newservice("watchdog")
	local watchdog_port = 8888
	skynet.call(watchdog, "lua", "start", {
		port = watchdog_port,
		maxclient = max_client,
		nodelay = true,
	})
	print("Watchdog listen on", watchdog_port)

	-- ffi_test()

	skynet.exit()
end)
