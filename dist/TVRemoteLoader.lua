
-- TV Remote executor loader
-- Requires an environment supporting game:HttpGet and loadstring.

local url = "https://raw.githubusercontent.com/classbook45/TV-Remote/main/src/TVRemote.lua"

local ok, source = pcall(function()
    return game:HttpGet(url)
end)

assert(ok, "TV Remote download failed: " .. tostring(source))

local factory, err = loadstring(source)
assert(factory, "TV Remote compile failed: " .. tostring(err))

local TVRemote = factory()
local remote = TVRemote.new()

local env = _G
if type(getgenv) == "function" then
    env = getgenv()
end

env.TVRemote = remote

print("[TV Remote] Loaded " .. remote:GetVersion())
return remote
