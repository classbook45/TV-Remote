
local TVRemote = {}
TVRemote.__index = TVRemote
TVRemote.Version = "1.0.0"

local Registry = {}

function TVRemote.new(config)
    local self = setmetatable({}, TVRemote)
    self.Config = config or {}
    self._features = {}
    self._tabs = {}
    self._links = {}
    return self
end

function TVRemote:GetVersion()
    return TVRemote.Version
end

function TVRemote:RegisterFeature(name, callback, description)
    assert(type(name) == "string", "Feature name required")
    assert(type(callback) == "function", "Callback required")

    self._features[name] = {
        Name = name,
        Callback = callback,
        Description = description or ""
    }

    return self._features[name]
end

function TVRemote:GetFeatures()
    local result = {}
    for name, feature in pairs(self._features) do
        result[name] = {
            Name = feature.Name,
            Description = feature.Description
        }
    end
    return result
end

function TVRemote:Execute(name, ...)
    local feature = self._features[name]
    if not feature then
        return false, "Feature not found: " .. tostring(name)
    end
    return pcall(feature.Callback, ...)
end

function TVRemote:MakeTab(name, icon)
    local tab = {
        Name = name,
        Icon = icon,
        Controls = {}
    }

    function tab:AddButton(options)
        assert(type(options) == "table")
        local item = {
            Type = "Button",
            Name = options.Name or "Button",
            Callback = options.Callback
        }
        table.insert(self.Controls, item)
        return item
    end

    function tab:AddToggle(options)
        assert(type(options) == "table")
        local item = {
            Type = "Toggle",
            Name = options.Name or "Toggle",
            CurrentValue = options.CurrentValue or false,
            Callback = options.Callback
        }
        table.insert(self.Controls, item)
        return item
    end

    table.insert(self._tabs, tab)
    return tab
end

function TVRemote:GetTabs()
    return self._tabs
end

-- Local-only communication links.
function TVRemote:CreateLink(name)
    assert(type(name) == "string")

    local endpoint = {
        Name = name,
        Handlers = {},
        RequestHandlers = {},
        Closed = false
    }

    Registry[name] = Registry[name] or {}
    table.insert(Registry[name], endpoint)
    table.insert(self._links, endpoint)

    local link = {}

    function link:On(eventName, callback)
        assert(type(callback) == "function")
        endpoint.Handlers[eventName] =
            endpoint.Handlers[eventName] or {}
        table.insert(endpoint.Handlers[eventName], callback)
        return link
    end

    function link:OnRequest(callback)
        assert(type(callback) == "function")
        table.insert(endpoint.RequestHandlers, callback)
        return link
    end

    function link:Send(payload)
        if endpoint.Closed then
            return false, "Link closed"
        end

        for _, target in ipairs(Registry[name] or {}) do
            if target ~= endpoint and not target.Closed then
                for _, callback in ipairs(
                    target.Handlers.Message or {}
                ) do
                    task.spawn(callback, payload, name)
                end
            end
        end
        return true
    end

    function link:Close()
        endpoint.Closed = true
        for i = #(Registry[name] or {}), 1, -1 do
            if Registry[name][i] == endpoint then
                table.remove(Registry[name], i)
            end
        end
        return true
    end

    return link
end

function TVRemote:Destroy()
    for _, endpoint in ipairs(self._links) do
        endpoint.Closed = true
        local list = Registry[endpoint.Name] or {}
        for i = #list, 1, -1 do
            if list[i] == endpoint then
                table.remove(list, i)
            end
        end
    end
    self._links = {}
end

return TVRemote
