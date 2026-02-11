-- config.lua

permissions({
	sudo = true,
	aur = {
		enable = true,
		manager = "yay",
	},
})

-- services
services({
	{ "NetworkManager", { enable = true, start = true } },
	{ "sshd",           { start = true } },
})

fileops.create.file({
	"/tmp/forge-test.txt",
	"/tmp/banana/dog.md",
})

fileops.create.directory({
	"/tmp/forge-dir",
	"/tmp/forge-dir2",
})

-- copy files
fileops.copy({
	{ "/etc/hosts",   "/tmp/forge-hosts-copy" },
	{ "/etc/hosts2w", "/tmp/forge-hosts-copy4" },
})

-- remove stuff
fileops.remove({
	{ "/tmp/forge-test.txt" },
})

services({
	{ "Dog",  { enable = true, start = true, stop = false } },
	{ "sshd", { start = true } },
})

git.clone({
	{
		repo = "link",
		branch = "main",
	},
})
