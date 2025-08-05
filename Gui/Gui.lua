local Gui = {}
Gui.CoreKeybind = {Toggle = Enum.KeyCode.RightShift, Destroy = Enum.KeyCode.Q}
Gui.SelectedItems = {}

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

function Gui.init()
    Gui.ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    Gui.ScreenGui.Name = "FinderXMainGui"
    Gui.NotificationGui = Instance.new("ScreenGui", game.CoreGui)
    Gui.NotificationGui.Name = "FinderXNotificationGui"
end

function Gui.MakeNotification(TitleText, DescriptionText, Length)
    local Frame = Instance.new("Frame", Gui.NotificationGui)
    Frame.BorderSizePixel = 0
    Frame.Size = UDim2.new(0.3, 0, 0.15, 0)
    Instance.new("UIAspectRatioConstraint", Frame).AspectRatio = 2.5
    Instance.new("UICorner", Frame)
    Frame.AnchorPoint = Vector2.new(1, 1)
    Frame.Position = UDim2.new(1, 0, 1, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

    local Title = Instance.new("TextLabel", Frame)
    Title.Size = UDim2.new(0.9, 0.2)
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0.05, 0, 0.1, 0)
    Title.TextSize = 24
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Text = tostring(TitleText)
    Title.Font = Enum.Font.GothamSemibold

    local Divider = Instance.new("Frame", Frame)
    Divider.Size = UDim2.new(0.975, 0, 0.01, 0)
    Divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Divider.BorderSizePixel = 0
    Divider.Position = UDim2.new(0.0125, 0, 0.225, 0)

    local Description = Instance.new("TextLabel", Frame)
    Description.Size = UDim2.new(0.9, 0, 0.6, 0)
    Description.Position = UDim2.new(0.05, 0, 0.3, 0)
    Description.BackgroundTransparency = 1
    Description.BorderSizePixel = 0
    Description.TextColor3 = Color3.fromRGB(255, 255, 255)
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.TextYAlignment = Enum.TextYAlignment.Top
    Description.TextWrapped = true
    Description.TextScaled = false
    Description.TextSize = 14
    Description.Font = Enum.Font.Gotham
    Description.Text = tostring(DescriptionText)

    local Timer = Instance.new("Frame", Frame)
    Timer.Size = UDim2.new(0.975, 0, 0.01, 0)
    Timer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Timer.BorderSizePixel = 0
    Timer.Position = UDim2.new(0.0125, 0, 0.95, 0)

    -- TweenService animation
    local goal = {}
    goal.Size = UDim2.new(0, 0, 0.01, 0) -- shrink to zero width

    local tweenInfo = TweenInfo.new(
        Length or 5,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out
    )

    local tween = TweenService:Create(Timer, tweenInfo, goal)
    tween:Play()

    tween.Completed:Connect(function()
        Frame:Destroy()
    end)
end

function Gui.MakeWindow(Name)
    local windows = {}
    for _, v in pairs(Gui.ScreenGui:GetChildren()) do
        if v:IsA("Frame") and v.Name == "WindowFrame" then
            table.insert(windows, v)
        end
    end

    local Frame = Instance.new("Frame", Gui.ScreenGui)
    Frame.Name = "WindowFrame"
    Frame.BorderSizePixel = 0
    Frame.Size = UDim2.new(0.2, 0, 0.1, 0)
    Frame.Position = UDim2.new(0 + (#windows * 0.205), 0, 0.02, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Instance.new("UICorner", Frame)
    Gui[Name] = Frame

    local Title = Instance.new("TextLabel", Frame)
    Title.Size = UDim2.new(0.9, 0.9)
    Title.BorderSizePixel = 0
    Title.AnchorPoint = Vector2.new(0.5, 0.5)
    Title.Position = UDim2.new(0.5, 0, 0.5, 0)
    Title.TextSize = 24
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Text = tostring(Name)
    Title.Font = Enum.Font.GothamSemibold
end

function Gui.MakeButton(Name, Parent, Function)
    local inputs = {}
    for _, v in pairs(Gui[Parent]:GetChildren()) do
        if v:IsA("Frame") and v.Name == "InputFrame" then
            table.insert(inputs, v)
        end
    end

    local Frame = Instance.new("Frame", Gui[Parent])
    Frame.Name = "InputFrame"
    Frame.BorderSizePixel = 0
    Frame.Size = UDim2.new(1, 0, 2/3, 0)
    Frame.Position = UDim2.new(0, 0, (#inputs * 2/3) + 1, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Instance.new("UICorner", Frame)

    local Title = Instance.new("TextLabel", Frame)
    Title.Size = UDim2.new(0.9, 0.9)
    Title.BorderSizePixel = 0
    Title.AnchorPoint = Vector2.new(0.5, 0.5)
    Title.Position = UDim2.new(0.5, 0, 0.5, 0)
    Title.TextSize = 24
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Text = tostring(Name)
    Title.Font = Enum.Font.Gotham

    local ClickDetector = Instance.new("TextButton", Frame)
    ClickDetector.Size = UDim2.new(1, 0, 1, 0)
    ClickDetector.BackgroundTransparency = 1
    ClickDetector.Text = ""
    ClickDetector.BorderSizePixel = 0

    ClickDetector.MouseButton1Click:Connect(function()
        loadstring(Function)()
    end)
end

function Gui.MakeTextBox(Name, Parent, Placeholder)
    local inputs = {}
    for _, v in pairs(Gui[Parent]:GetChildren()) do
        if v:IsA("Frame") and v.Name == "InputFrame" then
            table.insert(inputs, v)
        end
    end

    local Frame = Instance.new("Frame", Gui[Parent])
    Frame.Name = "InputFrame"
    Frame.BorderSizePixel = 0
    Frame.Size = UDim2.new(1, 0, 2/3, 0)
    Frame.Position = UDim2.new(0, 0, (#inputs * 2/3) + 1, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.Active = true
    Frame.ClipsDescendants = true
    Instance.new("UICorner", Frame)

    local TextBox = Instance.new("TextBox", Frame)
    TextBox.Size = UDim2.new(0.9, 0, 0.9, 0)
    TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
    TextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
    TextBox.BorderSizePixel = 0
    TextBox.TextSize = 18
    TextBox.TextScaled = true
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.PlaceholderText = tostring(Placeholder)
    TextBox.Font = Enum.Font.Gotham
    TextBox.BackgroundTransparency = 1
    TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TextBox.ClearTextOnFocus = false
    TextBox.Text = ""
    Instance.new("UITextSizeConstraint", TextBox).MaxTextSize = 18
    Gui[Name] = TextBox
end

function Gui.MakeSelectionBox(Name, Parent, Options, MultiSelect)
    local Selected = {}
    local inputs = {}
    for _, v in pairs(Gui[Parent]:GetChildren()) do
        if v:IsA("Frame") and v.Name == "InputFrame" then
            table.insert(inputs, v)
        end
    end

    local Frame = Instance.new("Frame", Gui[Parent])
    Frame.Name = "InputFrame"
    Frame.BorderSizePixel = 0
    Frame.Size = UDim2.new(1, 0, 2/3, 0)
    Frame.Position = UDim2.new(0, 0, (#inputs * 2/3) + 1, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.Active = true
    Instance.new("UICorner", Frame)

    local OptionsFrame = Instance.new("ScrollingFrame", Frame)
    OptionsFrame.Size = UDim2.new(1, 0, 4, 0)
    OptionsFrame.Position = UDim2.new(0, 0, 1, 0)
    OptionsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    OptionsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    OptionsFrame.ScrollBarThickness = 0
    OptionsFrame.BorderSizePixel = 0
    OptionsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    local layout = Instance.new("UIListLayout", OptionsFrame)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 4)

    local function CreateDropdownButton(Name)
        local ItemFrame = Instance.new("Frame", OptionsFrame)
        ItemFrame.Name = "InputFrame"
        ItemFrame.BorderSizePixel = 0
        ItemFrame.Size = UDim2.new(1, 0, 1/4, 0)
        ItemFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        ItemFrame.Active = true
        Instance.new("UICorner", ItemFrame)

        local Title = Instance.new("TextLabel", ItemFrame)
        Title.Size = UDim2.new(0.9, 0.9)
        Title.BorderSizePixel = 0
        Title.AnchorPoint = Vector2.new(0.5, 0.5)
        Title.Position = UDim2.new(0.5, 0, 0.5, 0)
        Title.TextSize = 24
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.Text = tostring(Name)
        Title.Font = Enum.Font.Gotham

        local ClickDetector = Instance.new("TextButton", ItemFrame)
        ClickDetector.Size = UDim2.new(1, 0, 1, 0)
        ClickDetector.BackgroundTransparency = 1
        ClickDetector.Text = ""
        ClickDetector.BorderSizePixel = 0

        ClickDetector.MouseButton1Click:Connect(function()
            if MultiSelect then
                if table.find(Options, Name) then
                    table.remove(Options, Name)
                else
                    table.insert(Options, Name)
                end
            else
                table.clear(Options)
                table.insert(Options, Name)
            end
        end)
    end

    local Title = Instance.new("TextLabel", Frame)
    Title.Size = UDim2.new(0.9, 0.9)
    Title.BorderSizePixel = 0
    Title.AnchorPoint = Vector2.new(0.5, 0.5)
    Title.Position = UDim2.new(0.5, 0, 0.5, 0)
    Title.TextSize = 24
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Text = tostring(Name)
    Title.Font = Enum.Font.Gotham

    local ClickDetector = Instance.new("TextButton", Frame)
    ClickDetector.Size = UDim2.new(1, 0, 1, 0)
    ClickDetector.BackgroundTransparency = 1
    ClickDetector.Text = ""
    ClickDetector.BorderSizePixel = 0

    ClickDetector.MouseButton1Click:Connect(function()
        Options.Visible = not Options.Visible
    end)

    for _, v in pairs(Options) do
        CreateDropdownButton(v)
    end
end

-- Gui.init()
-- Gui.MakeWindow("Test")
-- Gui.MakeWindow("Test 2")
-- Gui.MakeWindow("Test 3")
-- Gui.MakeButton("Test", "Test")
-- Gui.MakeButton("Test", "Test")
-- Gui.MakeButton("Test", "Test 2", "game.Players.LocalPlayer:Kick('Succesfully fixing functions')")
-- Gui.MakeButton("Test", "Test 3")
-- Gui.MakeTextBox("Tester", "Test 3", "Webhook")
-- Gui.MakeSelectionBox("Testing", "Test", {"La Vacca Saturno Saturnita", "Los Tralaleritos"}, false)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed and not input.KeyCode == Gui.CoreKeybind.Toggle then return end
    if input.KeyCode == Gui.CoreKeybind.Toggle then
        Gui.ScreenGui.Enabled = not Gui.ScreenGui.Enabled
    -- elseif input.KeyCode == Gui.CoreKeybind.Destroy then
    --     Gui.ScreenGui:Destroy()
    --     Gui.NotificationGui:Destroy()
    --     print("Destroyed gui.")
    end
end)
Gui.init()

return Gui
