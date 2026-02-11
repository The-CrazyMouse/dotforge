-- fileops.lua
-- File system operation task generators (copy, symlink, create, remove)
-- All functions append tasks to the provided tasks table

local M = {}

local function normalize_pair(entry, index, operation)
	local src, dest

	if type(entry) == "string" then
		-- Future extension: maybe allow single string as src (dest inferred?), but for now invalid
		print(
			string.format(
				"Warning: %s entry #%d is a string ¿ expected {src, dest} or {src=..., dest=...} ¿ skipped",
				operation,
				index
			)
		)
		return nil, nil
	end

	if type(entry) ~= "table" then
		print(
			string.format(
				"Error: %s entry #%d invalid (expected table, got %s) ¿ skipped",
				operation,
				index,
				type(entry)
			)
		)
		return nil, nil
	end

	-- Positional: { "/src", "/dest" }
	if entry[1] and entry[2] then
		src, dest = entry[1], entry[2]
		-- Named keys: { src = "...", dest = "..." }
	elseif entry.src and entry.dest then
		src, dest = entry.src, entry.dest
	end

	if not src or not dest then
		print(
			string.format(
				"Error: %s entry #%d missing src and/or dest ¿ got %s ¿ skipped",
				operation,
				index,
				vim.inspect and vim.inspect(entry) or tostring(entry)
			)
		)
		return nil, nil
	end

	if type(src) ~= "string" or type(dest) ~= "string" then
		print(
			string.format(
				"Error: %s entry #%d ¿ src/dest must be strings (got %s/%s) ¿ skipped",
				operation,
				index,
				type(src),
				type(dest)
			)
		)
		return nil, nil
	end

	return src, dest
end

function M.copy(tasks, entries)
	for i, entry in ipairs(entries or {}) do
		local src, dest = normalize_pair(entry, i, "copy")
		if src and dest then
			table.insert(tasks, {
				type = "copy",
				src = src,
				dest = dest,
			})
		end
	end
end

function M.symlink(tasks, entries)
	for i, entry in ipairs(entries or {}) do
		local src, dest = normalize_pair(entry, i, "symlink")
		if src and dest then
			table.insert(tasks, {
				type = "symlink",
				src = src,
				dest = dest,
			})
		end
	end
end

local function normalize_paths(input, operation)
	local paths = {}

	if type(input) == "string" then
		paths[1] = input
	elseif type(input) == "table" then
		for i, p in ipairs(input) do
			if type(p) == "string" then
				paths[#paths + 1] = p
			else
				print(
					string.format(
						"Warning: %s path at index %d is not a string (got %s) ¿ skipped",
						operation,
						i,
						type(p)
					)
				)
			end
		end
	else
		print(
			string.format(
				"Error: %s expects string or table of strings, got %s ¿ no paths added",
				operation,
				type(input)
			)
		)
		return {}
	end

	return paths
end

function M.create_file(tasks, input)
	local paths = normalize_paths(input, "create.file")
	for _, path in ipairs(paths) do
		table.insert(tasks, {
			type = "create_file",
			path = path,
		})
	end
end

function M.create_directory(tasks, input)
	local paths = normalize_paths(input, "create.directory")
	for _, path in ipairs(paths) do
		table.insert(tasks, {
			type = "create_dir",
			path = path,
		})
	end
end

function M.remove(tasks, input)
	local paths = normalize_paths(input, "remove")
	for _, path in ipairs(paths) do
		table.insert(tasks, {
			type = "remove",
			path = path,
		})
	end
end

return M
