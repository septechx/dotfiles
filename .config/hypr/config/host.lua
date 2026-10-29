local M = {}

local helper = (os.getenv("HOME") or "") .. "/.config/hypr/scripts/host-profile.sh"
local pipe = io.popen('bash "' .. helper .. '" 2>/dev/null')
local profile = pipe and pipe:read("*l") or nil

if pipe then
	pipe:close()
end

if profile ~= "laptop" and profile ~= "desktop" then
	profile = "desktop"
end

M.profile = profile
M.is_laptop = profile == "laptop"
M.is_desktop = profile == "desktop"

return M
