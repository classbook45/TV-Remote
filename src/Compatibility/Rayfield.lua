
-- TV Remote Rayfield compatibility adapter.
-- This translates supported calls into TV Remote descriptors.
-- It does not copy Rayfield source code.

local Adapter = {}

function Adapter.new(remote)
    assert(remote, "TV Remote instance required")

    local Rayfield = {}

    function Rayfield:CreateWindow(config)
        config = config or {}

        local window = {Tabs = {}}

        function window:CreateTab(name, icon)
            local tab = remote:MakeTab(name, icon)
            table.insert(self.Tabs, tab)
            return tab
        end

        return window
    end

    return Rayfield
end

return Adapter
