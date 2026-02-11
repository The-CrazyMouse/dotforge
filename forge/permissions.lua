-- permissions.lua
-- Collects and prints ALL configuration issues as warnings
-- Only hard errors on catastrophic cases (double call, completely broken input)
-- Applies best-effort / fallback values whenever reasonable

local M = {}

local used = false

function M.set(perms, opts)
	if used then
		error("permissions.set can only be called once") -- this one stays hard error
	end
	used = true

	-- Handle sudo
	if opts.sudo ~= nil then
		if type(opts.sudo) ~= "boolean" then
			print("Warning: 'sudo' should be boolean, got " .. type(opts.sudo) .. " — ignoring")
		else
			perms.sudo = opts.sudo
		end
	end

	-- Handle AUR
	if opts.aur ~= nil then
		local aur_input = opts.aur
		local final_enable = false
		local final_manager = nil

		if type(aur_input) == "boolean" then
			-- shorthand: aur = true / false
			final_enable = aur_input
			final_manager = aur_input and "auto" or nil
		elseif type(aur_input) == "table" then
			-- table form
			local input_enable = aur_input.enable
			local input_manager = aur_input.manager

			-- enable handling
			if input_enable ~= nil then
				if type(input_enable) ~= "boolean" then
					print(
						"Warning: aur.enable should be boolean, got "
						.. type(input_enable)
						.. " — defaulting to false"
					)
				else
					final_enable = input_enable
				end
			end -- else stays false (default)

			-- manager handling
			if input_manager ~= nil then
				if not final_enable then
					print("Warning: aur.manager is set but aur.enable is false — manager ignored")
				elseif type(input_manager) ~= "string" then
					print("Warning: aur.manager should be string, got " .. type(input_manager) .. " — ignored")
				elseif input_manager ~= "auto" and input_manager ~= "yay" then
					print(
						"Warning: unknown aur.manager '"
						.. tostring(input_manager)
						.. "' — only 'auto' and 'yay' are supported — falling back to 'auto'"
					)
					final_manager = "auto"
				else
					final_manager = input_manager
				end
			end

			-- If enable=true but no manager was given → default
			if final_enable and final_manager == nil then
				final_manager = "auto"
			end
		else
			print("Warning: aur must be boolean or table — got " .. type(aur_input) .. " — AUR support disabled")
			-- final_enable stays false, final_manager stays nil
		end

		-- Apply whatever we ended up with
		perms.aur.enable = final_enable
		perms.aur.manager = final_manager
	end
end

return M
