
# TV Remote Architecture

## Core
The main framework provides instances, feature registration,
execution, tab descriptors and local communication links.

## Plus
Optional extensions for additional information and utilities.

## Compatibility
A separate Rayfield-style compatibility adapter.

## Communication
Built-in links are local to the same Lua environment.
Cross-client and client/server communication requires an explicit
Roblox RemoteEvent or RemoteFunction transport.

## Executor support
The executor loader uses game:HttpGet and loadstring.
These are executor-specific APIs, not standard Studio APIs.
Compatibility depends on the executor environment.

## Visual interface
The current tab API creates control descriptors. A visual renderer
is a separate component and is not included yet.
