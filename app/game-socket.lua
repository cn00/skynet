local skynet = require "skynet"
local socket = require "socket.socket"
local proto, ptid, bfbs_names = require ("proto.proto")()
local ffi = require("ffi")
local p7z = require("p7zip")
local lfg = lfb

local lfs = require("utility.lfs")

local config = require("appconfig")

package.cpath = package.cpath .. ";luaclib/?.dylib"

local this = {
	client = {},
	Ip = "*",
	Port = 8001,
}

local mode , id = ...

-- print("p7zip", p7z)
-- for k,v in pairs(p7z) do
-- 	print(k,v)
-- end
-- p7z.execute("7z a test.7z app -p123")
-- print("p7zip", p7z)

-- for k,v in pairs(lfs) do
-- 	print("lfs.", k,v)
-- end
-- print("lfs.currentdir", lfs.currentdir())
-- print("lfs.link", lfs.link("test", "test-link", true))

local function digest(protoid, data )
	return {name = tostring(data)}
end

local function printt( t, indent )
	indent = indent or 0
	for k,v in pairs(t) do
		print(("\t"):rep(indent),k,type(v) == "string" and v:gsub("[\r\n]", "\\n"):gsub("[\0-\13]","") or tostring(v))
		if type(v) == "table" then
			printt(v, indent + 1)
		end
	end
end

local function send( id, protoid, buf )
	-- body
end

local function serve(id)
	socket.start(id)

	while true do
		local protoid = tonumber(socket.read(id, 8))
		local size = tonumber(socket.read(id, 8)) - 10000000
		-- local offset = tonumber(socket.read(id, 4)) - 1000
		local data = socket.read(id, size)
		if data and proto[protoid] then
			print("id:"..id, "protoid:"..protoid, "size:"..size, "#data:" .. #data, data:gsub("[\0-\13]",""))
			
			local t = assert(lfb:decode(protopath, proto[protoid], data))
			printt(t)
			t.name = "ssssss-Monster_c2s"

			local response = digest(protoid, t)
			if response ~= nil then
				local bbuf =  assert(lfb:encode(protopath, proto[protoid + 10000000], response))
				print(#bbuf, bbuf:gsub("[\0-\13]",""))

				socket.write(id, protoid + 10000000)
				socket.write(id, 10000000+#bbuf)
				socket.write(id, bbuf)
			end
		else
			error("unknow protoid", protoid)
			-- socket.close(id)
			-- return
		end
	end
end

local function accept(id)
	socket.start(id)
	-- socket.write(id, "0000000000000000\n")
	skynet.newservice(SERVICE_NAME, "agent", id)
	-- notice: Some data on this connection(id) may lost before new service start.
	-- So, be careful when you want to use start / abandon / start .
	socket.abandon(id)
end
if mode == "agent" then
	id = tonumber(id)
	skynet.start(function()
		print("agent", id)
		skynet.fork(function()
			serve(id)
			skynet.exit()
		end)
	end)
else
	skynet.start(function()
		local server, err = socket.bind(this.Ip, this.Port, 1)
		print("server:", server, err)

		socket.start(id , function(cid, addr)
			print("connect from " .. addr .. " " .. cid)
			-- you have choices :
			-- 1. skynet.newservice("testsocket", "agent", cid)
			-- 2. skynet.fork(echo, cid)
			-- 3. accept(cid)
			accept(cid)
		end)
	end)
end