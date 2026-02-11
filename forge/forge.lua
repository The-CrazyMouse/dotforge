local api = require("api")

local config_env = {
	env = require("env"),
	services = api.service,
	fileops = api.fileops,
	packages = api.package,
	git = api.git,
	permissions = api.perms,
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
local perms = api.get_permissions() -- get the set permissions

-- ────────────────────────────────────────────────
-- Print Permissions first
-- ────────────────────────────────────────────────
print("Current permissions:\n")
print("  sudo     : " .. tostring(perms.sudo))
print("  aur      : " .. tostring(perms.aur.enable))
if perms.aur.enable then
	print("  aur manager : " .. (perms.aur.manager or "auto (default)"))
end
print("") -- empty line

-- ────────────────────────────────────────────────
-- Print Planned tasks
-- ────────────────────────────────────────────────
print("Planned tasks:\n")

for i, t in ipairs(tasks) do
	if t.type == "service" then
		io.write(string.format("%2d. service %-20s : ", i, t.name or "?"))

		local first = true
		for k, v in pairs(t.opts or {}) do
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
		io.write(string.format("%2d. copy    %-30s → %s\n", i, t.src or "?", t.dest or "?"))
	elseif t.type == "symlink" then
		io.write(string.format("%2d. symlink %-30s → %s\n", i, t.src or "?", t.dest or "?"))
	elseif t.type == "create_file" then
		io.write(string.format("%2d. create file  %s\n", i, t.path or "?"))
	elseif t.type == "create_dir" then
		io.write(string.format("%2d. create dir   %s\n", i, t.path or "?"))
	elseif t.type == "remove" then
		io.write(string.format("%2d. remove      %s\n", i, t.path or "?"))
	elseif t.type == "pacman_install" then
		io.write(string.format("%2d. pacman install  %s\n", i, t.pkg or "?"))
	elseif t.type == "pacman_remove" then
		io.write(string.format("%2d. pacman remove   %s\n", i, t.pkg or "?"))
	elseif t.type == "aur_install" then
		io.write(string.format("%2d. aur install     %s\n", i, t.pkg or "?"))
	elseif t.type == "aur_remove" then
		io.write(string.format("%2d. aur remove      %s\n", i, t.pkg or "?"))
	elseif t.type == "git_clone" then
		local branch_part = t.branch and (" @ " .. t.branch) or ""
		local dest_part = t.dest and (" → " .. t.dest) or " (default dest)"
		io.write(string.format("%2d. git clone %-35s%s%s\n", i, t.repo or "?", branch_part, dest_part))
	else
		-- fallback for unknown/new task types
		io.write(string.format("%2d. %-15s %s\n", i, t.type, vim.inspect(t):gsub("\n", " ")))
	end
end

print("") -- final empty line
