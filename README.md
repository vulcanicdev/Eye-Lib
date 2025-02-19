# EyeLib - Roblox GUI Library

A roblox library for people.

## Features

*   Easy window creation with various themes and sizes.
*   Support for tabs and sections to organize your GUI.
*   Buttons, toggles, and sliders for user interaction.
*   Notifications for displaying messages.
*   Horizontal and Vertical Flipping Support

## Installation

1.  Use loadstring with this link:

    ```lua
    loadstring(game:HttpGet("https://pastebin.com/raw/QULDYFE4"))()
    ```

## Usage

### Creating a Window

```lua
local EyeLib = loadstring(game:HttpGet("https://pastebin.com/raw/QULDYFE4"))()

local window = EyeLib:Window(
    "My Window",        -- Title of the window
    "Medium",           -- Size: "Small", "Medium", or "Large"
    "A cool window",    -- Subtitle
    "YourName",         -- Author
    "Default",          -- Theme: "Pink", "Brown", "White", "Silver", "Diamond", or "Default"
    "Loading...",       -- Loading title
    "None"             -- Flip: "Horizontal", "Vertical", or "None"
)

window:Show() -- Display the window after it's created
```

### Adding Tabs and Sections

```lua
local playerTab = window:AddTab("Player")
local playerSection = playerTab:AddSection("Player Settings")
```

### Adding a Button

```lua
playerSection:AddButton("Click Me", function()
    print("Button clicked!")
end)
```

### Adding a Toggle

```lua
playerSection:AddToggle("Enable Feature", function(state)
    print("Feature enabled:", state)
end)
```

### Adding a Slider

```lua
local walkSpeedSlider = playerSection:AddSlider(
    "WalkSpeed",    -- Text label
    5,              -- Minimum value
    100,            -- Maximum value
    16,             -- Initial value
    function(value)  -- Callback function
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
)
```

### Setting Window Position

```lua
window:SetPosition(200, 100) -- X, Y coordinates
```

### Setting Window Size

```lua
window:SetSize(600, 700) -- Width, Height
```

### Showing Notifications

```lua
window:ShowNotification("Hello, world!", 3) -- Message, duration (seconds)
```

## Themes

Available themes:

*   Pink
*   Brown
*   White
*   Silver
*   Diamond
*   Default


## Window Sizes

Available sizes:

*   Small
*   Medium
*   Large

