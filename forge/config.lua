-- config.lua
-- executed inside forge with a restricted env

-- services
services({
	{ "NetworkManager", { enable = true, start = true } },
	{ "sshd",           { start = true } },
})

-- create files and directories
-- fileops.create.file({
--     { "/tmp/forge-test.txt" },
-- })

-- fileops.create.directory({
--     { "/tmp/forge-dir" },
-- })

-- copy files
fileops.copy({
	{ "/etc/hosts", "/tmp/forge-hosts-copy" },
})

-- -- remove stuff
-- fileops.remove({
--     { "/tmp/forge-test.txt" },
-- })

services({
	{ "Dog",  { enable = true, start = true, stop = false } },
	{ "sshd", { start = true } },
})
