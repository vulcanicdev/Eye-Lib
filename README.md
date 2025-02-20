# EyeLib - Roblox GUI Library

A roblox library for people.

## Features

*   Easy window creation with various themes and sizes.
*   Support for tabs and sections to organize your GUI.
*   Buttons, toggles, and sliders for user interaction.
*   Notifications for displaying messages.
*   Horizontal and Vertical Flipping Support
*   Prebuilt Keysystem
*   Fun UI, simple usage.
## Installation

1.  Use loadstring with this link:

    ```lua
    loadstring(game:HttpGet("https://pastebin.com/raw/2G92QnhV"))()
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

## Full EyeLib

``local EyeLib = loadstring(game:HttpGet("https://pastebin.com/raw/2G92QnhV"))()

-- Key system settings (optional)
local keySettings = {
    KeyEnabled = true,
    KeyTitle = "Enter Code",
    KeyGet = "Please enter the code to access this UI:",
    Key = "mySecret",
    KeySuccess = function()
        print("Access Granted!")
    end,
    KeyFail = function()
        print("Access Denied!")
    end
}

-- Create the window
local window = EyeLib:Window("My Awesome UI", "Medium", "Diamond", keySettings)

-- Create the first tab
local tab1 = window:CreateTab("Settings")

-- Add a button to the first tab
tab1:AddButton("Click Me", function()
    print("Button Clicked!")
end)

-- Add a toggle to the first tab
tab1:AddToggle("Enable Feature", false, function(state)
    print("Feature Enabled:", state)
end)

-- Create the second tab
local tab2 = window:CreateTab("Volume")

-- Add a slider to the second tab
tab2:AddSlider("Volume Level", 0, 100, 50, function(value)
    print("Volume Level:", value)
end)

-- Add a label to the second tab
tab2:AddLabel("Adjust the volume using the slider above.")``
