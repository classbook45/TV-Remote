
from pathlib import Path

root = Path(__file__).resolve().parents[1]

required = [
    "README.md",
    "LICENSE",
    "src/TVRemote.lua",
    "src/Plus.lua",
    "src/Compatibility/Rayfield.lua",
    "dist/TVRemoteLoader.lua",
    "examples/Basic.lua",
    "docs/ARCHITECTURE.md",
]

for name in required:
    path = root / name
    assert path.exists(), f"Missing {name}"
    assert path.stat().st_size > 10, f"Empty {name}"

core = (root / "src/TVRemote.lua").read_text()

for symbol in [
    "function TVRemote.new",
    "function TVRemote:RegisterFeature",
    "function TVRemote:MakeTab",
    "function TVRemote:CreateLink",
]:
    assert symbol in core, f"Missing {symbol}"

print("TV Remote project checks passed!")
