local M = {}

function M.copy(tasks, tbl)
	for i, pair in ipairs(tbl or {}) do
		local src, dest

		if type(pair) == "table" then
			if pair[1] and pair[2] then
				src, dest = pair[1], pair[2]
			elseif pair.src and pair.dest then
				src, dest = pair.src, pair.dest
			end
		end

		if not src or not dest then
			print(string.format("Error: copy entry #%d is invalid, expected src and dest, got %s", i, tostring(pair)))
		else
			-- add the task
			table.insert(tasks, {
				type = "copy",
				src = src,
				dest = dest,
			})
		end
	end
end

return M
