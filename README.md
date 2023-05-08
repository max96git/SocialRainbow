<a href="https://github.com/max96git/max96git" target="_blank">
  <img src="assets/rainbowhair-oblox.png" alt="max96git" />
</a>

[![GitHub release](https://img.shields.io/github/v/release/max96git/SocialRainbow?logo=roblox)](https://github.com/max96git/SocialRainbow/releases)
[![GitHub top language](https://img.shields.io/github/languages/top/max96git/SocialRainbow?logo=lua)](https://github.com/search?q=repo%3Amax96git%2FSocialRainbow++language%3ALua&type=code)
[![GitHub license](https://img.shields.io/github/license/max96git/SocialRainbow?logo=apache)](LICENSE.txt)

**SocialRainbow** is a module for Roblox based on WinnersTakeAll's Shime module, but it's different, the shime is a... **Rainbow!**
# 📄 Documentation
# Summary

### Constructors
new(`item:` [`GuiObject`](https://create.roblox.com/docs/reference/engine/classes/GuiObject), `it:` [`string`](https://create.roblox.com/docs/scripting/luau/strings), `cooldown:` [`number`](https://create.roblox.com/docs/scripting/luau/numbers)?)|[]()
-|-
Returns a [`table`](https://create.roblox.com/docs/reference/engine/libraries/table) containing `Rainbow`'s metatable

### Properties

Property | Details
-|-
`itemType` | This property is the `it` parameter
`item` | This property is the `item` parameter
`cooldown` | This property is either the `cooldown` parameter or `0`
`name` | This property shows the name, Defaults to `RainbowEffect(itemName)`
isPlaying | This property checks if the rainbow is playing
isPaused | This property checks if the rainbow is paused
finished | This property checks if the rainbow finished

### Methods

`Play(): void` | []()
-|-
The `Play()` function starts the rainbow at the `item` Parameter

`Pause(seconds:` [`number`](https://create.roblox.com/docs/scripting/luau/numbers) `): void` | []()
-|-
The `Pause()` function pauses the rainbow at the `item` Parameter until the `seconds` parameter has passed

`Stop(): void` | []()
-|-
The `Stop()` function Stops the rainbow at the `item` Parameter

### Events

`Played(item:` [`GuiObject`](https://create.roblox.com/docs/reference/engine/classes/GuiObject)`):` [`RBXScriptSignal`](https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptSignal) | []()
-|-
This event will fire when the rainbow starts to play

`Paused(item:` [`GuiObject`](https://create.roblox.com/docs/reference/engine/classes/GuiObject)`):` [`RBXScriptSignal`](https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptSignal) | []()
-|-
This event will fire when the rainbow pauses

`Stopped(item:` [`GuiObject`](https://create.roblox.com/docs/reference/engine/classes/GuiObject)`):` [`RBXScriptSignal`](https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptSignal) | []()
-|-
This event will fire when the rainbow stops

# Constructors

### `rainbow.new()`

Creates a new `Rainbow` from the provided parameters

Parameter | Information
-|-
`item`: [`GuiObject`](https://create.roblox.com/docs/reference/engine/classes/GuiObject) | The [`GuiObject`](https://create.roblox.com/docs/reference/engine/classes/GuiObject) that will be used for the rainbow
`it:` [`string`](https://create.roblox.com/docs/scripting/luau/strings) | The Item Type it will be rainbowed, Currently accepts `"border", "background", "text"`
`cooldown:` [`number`](https://create.roblox.com/docs/scripting/luau/numbers)? | The cooldown after each color change, Defaults to `0`

---

# Properties

### `itemType`

This property will return either `"Border"`, `"Background"`, or `"Text"`, depending on the `it` parameter

**Code Samples**

The Below example would say: `"Background is correct"`

```lua
local rainbow = require(game:GetService("ReplicatedStorage"):WaitForChild("SocialRainbow"))

local r = rainbow.new(script.Parent, "Background", 0.1)

print(r.itemType.. "is correct")
```

### `item`
The property will return the `item` argument

**Code Samples**

The example below would print `"Frame is a good choice"`

```lua
local rainbow = require(game:GetService("ReplicatedStorage"):WaitForChild("SocialRainbow"))

local r = rainbow.new(script.Parent, "Background", 0.1)

print(r.item.ClassName.. "is correct")
```

### `cooldown`
This property will return the `cooldown` argument if there is, otherwise it's `0`

**Code Sample**

This example will run the rainbow 5 times, then stops it

```lua
local SocialRainbow = require(game:GetService("ReplicatedStorage"):WaitForChild("SocialRainbow"))

local r = SocialRainbow.new(script.Parent, "Background")

local coro = coroutine.create(function()
	for _ = 1, 5 do
		r:Play()
		task.wait(r.cooldown)
		r:Pause(r.cooldown)
	end
	r:Stop()
end)

coroutine.resume(coro)
```

### `name`
This property is the name of the `RenderStep` binding

**Code Sample**

This example would print `"RainbowEffectFrame is currently set"`

```lua
local SocialRainbow = require(game:GetService("ReplicatedStorage"):WaitForChild("SocialRainbow"))

local r = SocialRainbow.new(script.Parent, "Background")

print(r.name, "is currently set")
```

### `isPlaying`

This property checks if the rainbow is playing, However, If `RunService:UnbindFromRenderStep(r.name)`, the `isPlaying` will still be true, the workaround is done using `r:Stop()` or `r:Pause(5)` so `isPlaying` will be false and unbinds from `RenderStep`

### `isPaused`

This property checks if the rainbow is paused, However, If `RunService:UnbindFromRenderStep(r.name)`, the `isPaused` will still be true, the workaround is done using `r:Pause(5)` so `isPaused` will be false and unbinds from `RenderStep`

### isFinished

This property checks if the rainbow is finished, However, If `RunService:UnbindFromRenderStep(r.name)` , the `isFinished` will still be true, the workaround is done using `r:Stop()` so `isFinished` will be false and unbinds from `RenderStep`

# Methods

### `Play()`

Starts the `Rainbow` set by the UI Selected

**Returns**

> `void`

**Code Samples**

This sample gives a simple demonstration of what each of the Rainbow functions (Rainbow.Play, Rainbow.Stop and Rainbow.Pause).

```lua
-- Require the SocialRainbow module
local SocialRainbow = require(game:GetService("ReplicatedStorage"):WaitForChild("SocialRainbow"))

-- Create a new Rainbow and play it
local rainbow = Rainbow.new(script.Parent, "Background", 1)
rainbow:Play()

-- Pause the Rainbow when the mouse enters the GuiObject
script.Parent.MouseEnter:Connect(function()
	rainbow:Pause()
end)

-- Stop the Rainbow when the mouse leaves the GuiObject
script.Parent.MouseButton1Click:Connect(function()
	rainbow:Stop()
end)
```

### `Pause()`

Pauses the `Rainbow` until a certain amount of seconds have passed

**Parameters**

[]()|[]()
-|-
`seconds:` [`number`](https://create.roblox.com/docs/scripting/luau/numbers) | the seconds to pass after the `Rainbow` is paused, The minimum is `0.1`, and the maximum is `100,000`, and automatically clamps the value

**Returns**

> `void`

**Code Samples**

This sample gives a simple demonstration of what each of the Rainbow functions (Rainbow.Play, Rainbow.Stop and Rainbow.Pause).

```lua
-- Require the SocialRainbow module
local SocialRainbow = require(game:GetService("ReplicatedStorage"):WaitForChild("SocialRainbow"))

-- Create a new Rainbow and play it
local rainbow = Rainbow.new(script.Parent, "Background", 1)
rainbow:Play()

-- Pause the Rainbow when the mouse enters the GuiObject
script.Parent.MouseEnter:Connect(function()
	rainbow:Pause()
end)

-- Stop the Rainbow when the mouse leaves the GuiObject
script.Parent.MouseButton1Click:Connect(function()
	rainbow:Stop()
end)
```

### `Stop()`

Stops the `Rainbow` and is permanent unlike `Rainbow:Pause(seconds)`

**Returns**

> void

**Code Samples**

This sample gives a simple demonstration of what each of the Rainbow functions (Rainbow.Play, Rainbow.Stop and Rainbow.Pause).

```lua
-- Require the SocialRainbow module
local SocialRainbow = require(game:GetService("ReplicatedStorage"):WaitForChild("SocialRainbow"))

-- Create a new Rainbow and play it
local rainbow = Rainbow.new(script.Parent, "Background", 1)
rainbow:Play()

-- Pause the Rainbow when the mouse enters the GuiObject
script.Parent.MouseEnter:Connect(function()
	rainbow:Pause()
end)

-- Stop the Rainbow when the mouse leaves the GuiObject
script.Parent.MouseButton1Click:Connect(function()
	rainbow:Stop()
end)
```

# Events

### `Played`

This event will fire when the `Rainbow` starts to play

**Parameters**
[]()|[]()
-|-
`item:` [`GuiObject`](https://create.roblox.com/docs/reference/engine/classes/GuiObject) | The [`GuiObject`](https://create.roblox.com/docs/reference/engine/classes/GuiObject) being used in the `Rainbow`

**Code Sample**

This Code Example would print out `"Frame has started"`

```lua
local SocialRainbow = require(game.ReplicatedStorage.SocialRainbow)

local rainbow = SocialRainbow.new(script.Parent, "Background", 0.5)

rainbow.Played:Connect(function(item)
	print(item, "has started")
end)
```

### `Paused`

This Event would fire when the `Rainbow` was paused for a certain amount of time

**Parameters**

[]()|[]()
-|-
`item:` [`GuiObject`](https://create.roblox.com/docs/reference/engine/classes/GuiObject) | The [`GuiObject`](https://create.roblox.com/docs/reference/engine/classes/GuiObject) being used in the `Rainbow`
`seconds:` [`number`](https://create.roblox.com/docs/scripting/luau/numbers) | The amount of seconds being used in the pause

**Code Sample**

This sample would print `"Frame has paused for 5 seconds"`

```lua
local SocialRainbow = require(game.ReplicatedStorage.SocialRainbow)

local rainbow = SocialRainbow.new(script.Parent, "Background", 0.5)

rainbow.Paused:Connect(function(item, seconds)
	print(item, "has paused for", seconds, "seconds")
end)
```

### `Finished`

This event will fire when the `Rainbow` finishes

**Parameters**
[]()|[]()
-|-
`item:` [`GuiObject`](https://create.roblox.com/docs/reference/engine/classes/GuiObject) | The [`GuiObject`](https://create.roblox.com/docs/reference/engine/classes/GuiObject) being used in the `Rainbow`

**Code Sample**

This Code Example would print out `"Frame has finished!"`

```lua
local SocialRainbow = require(game.ReplicatedStorage.SocialRainbow)

local rainbow = SocialRainbow.new(script.Parent, "Background", 0.5)

rainbow.Finished:Connect(function(item)
	print(item, "has finished")
end)
```

> IMPORTANT: All of this is documented by @VSCPlays for @max96git's <SocialRainbow as he created the module for the resource

