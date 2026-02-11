-- api.lua
local systemd = require("systemd")
local fileops = require("fileops")
local package = require("packages")
local permissions = require("permissions")
local git = require("git")

local tasks = {}
local perm = {
	sudo = false,
	aur = {
		enable = false,
		manager = nil,
	},
}

local api = {}

function api.service(tbl)
	systemd.service(tasks, tbl)
end

api.fileops = {
	create = {
		file = function(tbl)
			fileops.create_file(tasks, tbl)
		end,
		directory = function(tbl)
			fileops.create_directory(tasks, tbl)
		end,
	},
	copy = function(tbl)
		fileops.copy(tasks, tbl)
	end,
	symlink = function(tbl)
		fileops.symlink(tasks, tbl)
	end,
	remove = function(tbl)
		fileops.remove(tasks, tbl)
	end,
}

function api.perms(opts)
	permissions.set(perm, opts)
end

api.package = {
	install = function(tbl)
		package.install(tasks, tbl)
	end,
	remove = function(tbl)
		package.remove(tasks, tbl)
	end,
	aur = {
		install = function(tbl)
			package.aur_install(tasks, tbl)
		end,
		remove = function(tbl)
			package.aur_remove(tasks, tbl)
		end,
	},
}

function api.get_permissions()
	return perm
end

function api.get_tasks()
	return tasks
end

api.git = {
	clone = function(tbl)
		git.clone(tasks, tbl)
	end,
	-- pull = function(tbl)
	-- 	git.pull(tasks, tbl)
	-- end,
}

return api
