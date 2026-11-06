
# TV Remote

A modular Roblox Luau framework for features, local communication,
compatibility adapters and extensible development.

## Quick start

```lua
local TVRemote = require(path.to.TVRemote)
local remote = TVRemote.new()

remote:RegisterFeature("Hello", function()
    print("Hello from TV Remote!")
end)

remote:Execute("Hello")
```

## Features

- Instance-based core
- Feature registration and execution
- Tab and control descriptors
- Local communication links
- Optional Plus module
- Rayfield-style compatibility adapter
- Executor loader

## Executor loader

See `dist/TVRemoteLoader.lua`.

The loader requires executor-specific `game:HttpGet` and `loadstring`.

## Important limitations

Local links do not automatically connect separate clients or the server.
A networking transport must be implemented separately.

The compatibility adapter does not recreate Rayfield's visual interface.

## Project structure

- src/TVRemote.lua
- src/Plus.lua
- src/Compatibility/Rayfield.lua
- dist/TVRemoteLoader.lua
- examples/Basic.lua
- docs/ARCHITECTURE.md
- tests/validate_project.py

License: MIT
