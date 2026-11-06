
local TVRemote = require(path.to.TVRemote)
local remote = TVRemote.new()

remote:RegisterFeature("Hello", function()
    print("Hello from TV Remote!")
end, "Example feature")

remote:Execute("Hello")

local tab = remote:MakeTab("Home", "home")

tab:AddButton({
    Name = "Example",
    Callback = function()
        print("Button clicked!")
    end
})
