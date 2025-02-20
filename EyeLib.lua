-- EyeLib
-- Current Date and Time (UTC): 2025-02-19 13:54:45
-- User's Login: vulcanicdev

local EyeLib = {}

local windowSizes = {
    Small = { width = 300, height = 400 },
    Medium = { width = 500, height = 600 },
    Large = { width = 700, height = 800 }
}

local themes = {
    Pink = { backgroundColor = Color3.fromRGB(255, 192, 203), titleColor = Color3.fromRGB(255, 105, 180) },
    Brown = { backgroundColor = Color3.fromRGB(139, 69, 19), titleColor = Color3.fromRGB(210, 105, 30) },
    White = { backgroundColor = Color3.fromRGB(255, 255, 255), titleColor = Color3.fromRGB(200, 200, 200) },
    Silver = { backgroundColor = Color3.fromRGB(192, 192, 192), titleColor = Color3.fromRGB(169, 169, 169) },
    Diamond = { backgroundColor = Color3.fromRGB(185, 242, 255), titleColor = Color3.fromRGB(120, 144, 156) },
    Default = { backgroundColor = Color3.fromRGB(31, 25, 44), titleColor = Color3.fromRGB(18, 15, 24) }
}

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Helper function to create new instances
local function Create(className, properties)
    local instance = Instance.new(className)
    for k, v in pairs(properties) do
        instance[k] = v
    end
    return instance
end

-- Drag functionality
function EyeLib:Drag(frame, parent)
    parent = parent or frame
    
    local dragToggle, dragSpeed, dragStart, startPos = nil, 0.25, nil, nil
    local dragInput

    local function updateInput(input)
        local delta = input.Position - dragStart
        local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        TweenService:Create(parent, TweenInfo.new(dragSpeed), {Position = position}):Play()
    end

    frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragToggle = true
            dragStart = input.Position
            startPos = parent.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragToggle then
            updateInput(input)
        end
    end)
end

-- Sound effect function
local function PlaySound(parent, pitch)
    local sound = Create("Sound", {
        Parent = parent,
        SoundId = "rbxassetid://552900451",
        Volume = 2,
        Pitch = pitch or 1
    })
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 1)
end

function EyeLib:Window(windowTitle, size, theme)
    windowTitle = windowTitle or "EyeLib"
    size = size or "Medium"
    theme = theme or "Default"

    local windowSize = windowSizes[size]
    local windowTheme = themes[theme]

    -- Create main GUI elements
    local ScreenGui = Create("ScreenGui", {
        Name = "EyeLibGui",
        Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui"),
        ResetOnSpawn = false
    })

    local Main = Create("Frame", {
        Name = "Main",
        Parent = ScreenGui,
        BackgroundColor3 = windowTheme.backgroundColor,
        Position = UDim2.new(0.5, -windowSize.width/2, 0.5, -windowSize.height/2),
        Size = UDim2.new(0, windowSize.width, 0, windowSize.height),
        ClipsDescendants = true
    })

    Create("UICorner", {
        Parent = Main,
        CornerRadius = UDim.new(0, 15)
    })

    local TopBar = Create("Frame", {
        Name = "TopBar",
        Parent = Main,
        BackgroundColor3 = windowTheme.titleColor,
        Size = UDim2.new(1, 0, 0, 45),
        ZIndex = 5
    })

    Create("UICorner", {
        Parent = TopBar,
        CornerRadius = UDim.new(0, 15)
    })

    local Title = Create("TextLabel", {
        Name = "Title",
        Parent = TopBar,
        BackgroundTransparency = 1,
        Position = UDim2.new(0.02, 0, 0, 0),
        Size = UDim2.new(0.7, 0, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = windowTitle,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local CloseButton = Create("TextButton", {
        Name = "CloseButton",
        Parent = TopBar,
        BackgroundColor3 = Color3.fromRGB(255, 75, 75),
        Position = UDim2.new(1, -35, 0.5, -10),
        Size = UDim2.new(0, 20, 0, 20),
        Font = Enum.Font.GothamBold,
        Text = "×",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 20
    })

    Create("UICorner", {
        Parent = CloseButton,
        CornerRadius = UDim.new(0, 10)
    })

    local MinimizeButton = Create("TextButton", {
        Name = "MinimizeButton",
        Parent = TopBar,
        BackgroundColor3 = Color3.fromRGB(75, 75, 255),
        Position = UDim2.new(1, -65, 0.5, -10),
        Size = UDim2.new(0, 20, 0, 20),
        Font = Enum.Font.GothamBold,
        Text = "-",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 20
    })

    Create("UICorner", {
        Parent = MinimizeButton,
        CornerRadius = UDim.new(0, 10)
    })

    local TabContainer = Create("Frame", {
        Name = "TabContainer",
        Parent = Main,
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        Position = UDim2.new(0, 10, 0, 55),
        Size = UDim2.new(0.25, 0, 0.9, -65),
        BackgroundTransparency = 0.5
    })

    Create("UICorner", {
        Parent = TabContainer,
        CornerRadius = UDim.new(0, 10)
    })

    local TabList = Create("ScrollingFrame", {
        Name = "TabList",
        Parent = TabContainer,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 5, 0, 5),
        Size = UDim2.new(1, -10, 1, -10),
        ScrollBarThickness = 2,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    })

    local TabListLayout = Create("UIListLayout", {
        Parent = TabList,
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    local ContentContainer = Create("Frame", {
        Name = "ContentContainer",
        Parent = Main,
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        Position = UDim2.new(0.27, 0, 0, 55),
        Size = UDim2.new(0.72, -10, 0.9, -65),
        BackgroundTransparency = 0.5
    })

    Create("UICorner", {
        Parent = ContentContainer,
        CornerRadius = UDim.new(0, 10)
    })

    -- Enable dragging
    EyeLib:Drag(TopBar, Main)

    -- Handle minimize/close functionality
    local minimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        PlaySound(MinimizeButton, minimized and 0.8 or 1.2)
        ContentContainer.Visible = not minimized
        TabContainer.Visible = not minimized
        Main:TweenSize(
            minimized and UDim2.new(0, windowSize.width, 0, 45) or 
            UDim2.new(0, windowSize.width, 0, windowSize.height),
            Enum.EasingDirection.InOut,
            Enum.EasingStyle.Quad,
            0.3,
            true
        )
    end)

    CloseButton.MouseButton1Click:Connect(function()
        PlaySound(CloseButton, 0.8)
        ScreenGui:Destroy()
    end)

    local Window = {
        Gui = ScreenGui,
        Main = Main,
        Tabs = {},
        Theme = windowTheme,
        Size = windowSize
    }

    function Window:CreateTab(tabName)
        local tab = {
            Name = tabName,
            Elements = {}
        }

        local TabButton = Create("TextButton", {
            Name = tabName.."Tab",
            Parent = TabList,
            BackgroundColor3 = Color3.fromRGB(60, 60, 60),
            Size = UDim2.new(1, 0, 0, 30),
            Font = Enum.Font.GothamSemibold,
            Text = tabName,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 14
        })

        Create("UICorner", {
            Parent = TabButton,
            CornerRadius = UDim.new(0, 8)
        })

        local TabContent = Create("ScrollingFrame", {
            Name = tabName.."Content",
            Parent = ContentContainer,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 5, 0, 5),
            Size = UDim2.new(1, -10, 1, -10),
            ScrollBarThickness = 2,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false
        })

        local ContentLayout = Create("UIListLayout", {
            Parent = TabContent,
            Padding = UDim.new(0, 5),
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        -- Show first tab by default
        if #self.Tabs == 0 then
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        end

        TabButton.MouseButton1Click:Connect(function()
            -- Hide all other tabs
            for _, t in pairs(self.Tabs) do
                t.Content.Visible = false
                t.Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            end
            -- Show this tab
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            PlaySound(TabButton, 1)
        end)

        tab.Button = TabButton
        tab.Content = TabContent
        tab.Layout = ContentLayout

        -- Add element creation functions
        function tab:AddButton(text, callback)
            local Button = Create("TextButton", {
                Parent = TabContent,
                BackgroundColor3 = Color3.fromRGB(60, 60, 60),
                Size = UDim2.new(1, -10, 0, 32),
                Font = Enum.Font.GothamSemibold,
                Text = text,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14
            })

            Create("UICorner", {
                Parent = Button,
                CornerRadius = UDim.new(0, 6)
            })

            Button.MouseButton1Click:Connect(function()
                PlaySound(Button, 1)
                callback()
            end)

            return Button
        end

        function tab:AddToggle(text, default, callback)
            local ToggleFrame = Create("Frame", {
                Parent = TabContent,
                BackgroundColor3 = Color3.fromRGB(60, 60, 60),
                Size = UDim2.new(1, -10, 0, 32)
            })

            Create("UICorner", {
                Parent = ToggleFrame,
                CornerRadius = UDim.new(0, 6)
            })

            local ToggleButton = Create("TextButton", {
                Parent = ToggleFrame,
                BackgroundColor3 = default and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(255, 64, 64),
                Position = UDim2.new(0, 5, 0.5, -10),
                Size = UDim2.new(0, 20, 0, 20),
                Text = "",
            })

            Create("UICorner", {
                Parent = ToggleButton,
                CornerRadius = UDim.new(0, 4)
            })

            local ToggleText = Create("TextLabel", {
                Parent = ToggleFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 35, 0, 0),
                Size = UDim2.new(1, -40, 1, 0),
                Font = Enum.Font.GothamSemibold,
                Text = text,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })

            local toggled = default
            ToggleButton.MouseButton1Click:Connect(function()
                toggled = not toggled
                PlaySound(ToggleButton, toggled and 1.2 or 0.8)
                ToggleButton.BackgroundColor3 = toggled and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(255, 64, 64)
                callback(toggled)
            end)

            return ToggleFrame
        end

        function tab:AddSlider(text, min, max, default, callback)
            local SliderFrame = Create("Frame", {
                Parent = TabContent,
                BackgroundColor3 = Color3.fromRGB(60, 60, 60),
                Size = UDim2.new(1, -10, 0, 50)
            })

            Create("UICorner", {
                Parent = SliderFrame,
                CornerRadius = UDim.new(0, 6)
            })

            local SliderText = Create("TextLabel", {
                Parent = SliderFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 5, 0, 0),
                Size = UDim2.new(1, -10, 0.5, 0),
                Font = Enum.Font.GothamSemibold,
                Text = text,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })

            local SliderValue = Create("TextLabel", {
                Parent = SliderFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(1, -40, 0, 0),
                Size = UDim2.new(0, 35, 0.5, 0),
                Font = Enum.Font.GothamBold,
                Text = tostring(default),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Right
            })

            local SliderBack = Create("Frame", {
                Parent = SliderFrame,
                BackgroundColor3 = Color3.fromRGB(80, 80, 80),
                Position = UDim2.new(0, 5, 0.75, -5),
                Size = UDim2.new(1, -10, 0, 10)
            })

            Create("UICorner", {
                Parent = SliderBack,
                CornerRadius = UDim.new(0, 5)
            })

            local SliderFill = Create("Frame", {
                Parent = SliderBack,
                BackgroundColor3 = Color3.fromRGB(0, 255, 128),
                Size = UDim2.new(default / max, 0, 1, 0)
            })

            Create("UICorner", {
                Parent = SliderFill,
                CornerRadius = UDim.new(0, 5)
            })

            local dragging = false
            local function update(input)
                local delta = input.Position.X - SliderBack.AbsolutePosition.X
                local percent = math.clamp(delta / SliderBack.AbsoluteSize.X, 0, 1)
                local value = math.floor(min + (max - min) * percent)
                SliderFill:TweenSize(UDim2.new(percent, 0, 1, 0), "Out", "Quad", 0.1, true)
                SliderValue.Text = tostring(value)
                callback(value)
            end

            SliderBack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    update(input)
                end
            end)

            SliderBack.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            UIS.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    update(input)
                end
            end)

            return SliderFrame
        end

        function tab:AddLabel(text)
            local Label = Create("TextLabel", {
                Parent = TabContent,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -10, 0, 32),
                Font = Enum.Font.GothamSemibold,
                Text = text,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            return Label
        end

        table.insert(self.Tabs, tab)
        return tab
    end

    return Window
end

return EyeLib
