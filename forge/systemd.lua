local M = {}

function M.service(tasks, tbl)
	local valid_opts = {
		enable = "boolean",
		start = "boolean",
		stop = "boolean",
		restart = "boolean",
		status = "boolean",
		mask = "boolean",
		unmask = "boolean",
		cmd = "string", -- new explicit option
	}

	for _, t in ipairs(tbl or {}) do
		local name, opts
		if t[1] then
			name = t[1]
			opts = t[2] or {}
		else
			name = t.name
			opts = t.opts or {}
		end

		if not name then
			print("Error: Invalid service entry")
		else
			local valid = true
			for k, v in pairs(opts) do
				local expected = valid_opts[k]
				if not expected then
					print(
						string.format(
							"Warning: Unknown option '%s' for service %s -> If not one of the options use option cmd to input the command",
							k,
							name
						)
					)
				elseif type(v) ~= expected then
					print(
						string.format(
							"Error: Option '%s' for service %s should be %s, got %s",
							k,
							name,
							expected,
							type(v)
						)
					)
					valid = false
				end
			end

			if valid then
				table.insert(tasks, {
					type = "service",
					name = name,
					opts = opts,
				})
			end
		end
	end
end

return M
