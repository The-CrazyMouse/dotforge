local M = {}

function M.clone(tasks, input)
	local entries = {}

	-- Normalize input to always be a list of entry tables
	if type(input) == "string" then
		table.insert(entries, { repo = input })
	elseif type(input) == "table" then
		for _, item in ipairs(input) do
			if type(item) == "string" then
				table.insert(entries, { repo = item })
			elseif type(item) == "table" then
				table.insert(entries, item)
			end
		end
	else
		print("Error: git.clone expects string or table")
		return
	end

	for i, entry in ipairs(entries) do
		-- Get repo (support multiple common key names / positions)
		local repo = entry.repo or entry.url or entry[1] or entry.link

		if not repo or type(repo) ~= "string" then
			print(string.format("Error: git.clone entry #%d missing required repo/url (got: %s)", i, tostring(repo)))
			goto continue
		end

		-- Optional fields (no defaults yet – can be nil)
		local task = {
			type = "git_clone",
			repo = repo,
			dest = entry.dest or entry[2] or entry.path,
			branch = entry.branch or entry[3],
		}

		table.insert(tasks, task)

		::continue::
	end
end

return M
