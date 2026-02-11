local M = {}
function M.install(tasks, tbl)
	for _, pkg in ipairs(tbl or {}) do
		if type(pkg) == "string" then
			table.insert(tasks, {
				type = "pacman_install",
				pkg = pkg, -- single package name
			})
		else
			print("Warning: skipping non-string package entry: " .. tostring(pkg))
		end
	end
end

function M.remove(tasks, tbl)
	for _, pkg in ipairs(tbl or {}) do
		if type(pkg) == "string" then
			table.insert(tasks, {
				type = "pacman_remove",
				pkg = pkg, -- single package name
			})
		else
			print("Warning: skipping non-string package entry: " .. tostring(pkg))
		end
	end
end

function M.aur_install(tasks, tbl)
	for _, pkg in ipairs(tbl or {}) do
		if type(pkg) == "string" then
			table.insert(tasks, {
				type = "aur_install",
				pkg = pkg, -- single package name
			})
		else
			print("Warning: skipping non-string package entry: " .. tostring(pkg))
		end
	end
end

function M.aur_remove(tasks, tbl)
	for _, pkg in ipairs(tbl or {}) do
		if type(pkg) == "string" then
			table.insert(tasks, {
				type = "aur_remove",
				pkg = pkg, -- single package name
			})
		else
			print("Warning: skipping non-string package entry: " .. tostring(pkg))
		end
	end
end

return M
