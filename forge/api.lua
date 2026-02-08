-- api.lua
local systemd = require("systemd")
local fileops = require("fileops")

local tasks = {}

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
			fileops.create_dir(tasks, tbl)
		end,
	},
	copy = function(tbl)
		fileops.copy(tasks, tbl)
	end,
	remove = function(tbl)
		fileops.remove(tasks, tbl)
	end,
}

function api.get_tasks()
	return tasks
end

return api
