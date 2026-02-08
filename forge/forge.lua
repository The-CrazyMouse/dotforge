local api = require("api")

local config_env = {
	env = require("env"),
	services = api.service,
	fileops = api.fileops,
}

local config

if #arg == 0 then
	config = config_env.env.HOME .. ".dotforge/config/dotforge"
elseif #arg == 1 then
	config = arg[1]
else
	print([[
        forge — declarative system setup tool

        Usage:
                forge <dotforge.lua>

        Description:
                Forge reads a Lua configuration file and executes the declared tasks
                in order (services, copy, symlink, run commands, etc).

                If no path to the config entry point the program will use:
                $HOME/.dotforge/config/dotforge.lua

        Examples:
                forge
                forge config.lua
        ]])
end

local f = assert(loadfile(config, "t", config_env))
f()

local tasks = api.get_tasks()

print("Planned tasks:\n")

for i, t in ipairs(tasks) do
	if t.type == "service" then
		io.write(string.format("%2d. service %-20s : ", i, t.name))

		local first = true
		for k, v in pairs(t.opts) do
			if v then
				if not first then
					io.write(", ")
				end
				io.write(k)
				first = false
			end
		end

		if first then
			io.write("no options")
		end

		io.write("\n")
	elseif t.type == "copy" then
		io.write(string.format("%2d. copy    %-30s → %s\n", i, t.src, t.dest))
	end
end
