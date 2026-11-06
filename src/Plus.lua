
local Plus = {}

function Plus.GetInformation(remote)
    local features = remote:GetFeatures()
    local count = 0

    for _ in pairs(features) do
        count = count + 1
    end

    return {
        Version = remote:GetVersion(),
        FeatureCount = count,
        TabCount = #remote:GetTabs()
    }
end

return Plus
