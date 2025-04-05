local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- GUI Erstellung
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoEggOpener"
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

-- Titelbar mit Buttons
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundTransparency = 1
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "✨ PET SIM 99 - AUTO EGG OPENER"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 170, 255)
Title.TextSize = 18
Title.Size = UDim2.new(1, -60, 1, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Minimieren Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Text = "_"
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 18
MinimizeButton.Position = UDim2.new(1, -50, 0, 0)
MinimizeButton.Size = UDim2.new(0, 25, 1, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Parent = TitleBar

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 6)
MinimizeCorner.Parent = MinimizeButton

-- Schließen Button
local CloseButton = Instance.new("TextButton")
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.Position = UDim2.new(1, -25, 0, 0)
CloseButton.Size = UDim2.new(0, 25, 1, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Hauptinhalt (für Minimieren)
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -30)
ContentFrame.Position = UDim2.new(0, 0, 0, 30)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainFrame

-- Drag-Funktion
local dragging = false
local dragStartPos
local frameStartPos

local function updateDrag(input)
    local delta = Vector2.new(input.Position.X, input.Position.Y) - dragStartPos
    MainFrame.Position = UDim2.new(
        frameStartPos.X.Scale, 
        frameStartPos.X.Offset + delta.X,
        frameStartPos.Y.Scale,
        frameStartPos.Y.Offset + delta.Y
    )
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = Vector2.new(input.Position.X, input.Position.Y)
        frameStartPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateDrag(input)
    end
end)

-- Minimieren-Funktion
local isMinimized = false
local originalSize = MainFrame.Size

MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, 0, 30)}):Play()
        TweenService:Create(ContentFrame, TweenInfo.new(0.3), {Position = UDim2.new(0, 0, 0, 30)}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = originalSize}):Play()
        TweenService:Create(ContentFrame, TweenInfo.new(0.3), {Position = UDim2.new(0, 0, 0, 30)}):Play()
    end
end)

-- Schließen-Funktion
CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    wait(0.2)
    ScreenGui:Destroy()
end)

-- GUI-Inhalt (in ContentFrame statt MainFrame)
local EggCountLabel = Instance.new("TextLabel")
EggCountLabel.Text = "Anzahl der Eier (1-1000):"
EggCountLabel.Font = Enum.Font.Gotham
EggCountLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
EggCountLabel.TextSize = 14
EggCountLabel.Position = UDim2.new(0, 20, 0, 30)
EggCountLabel.Size = UDim2.new(0, 200, 0, 20)
EggCountLabel.BackgroundTransparency = 1
EggCountLabel.TextXAlignment = Enum.TextXAlignment.Left
EggCountLabel.Parent = ContentFrame

local EggCountBox = Instance.new("TextBox")
EggCountBox.PlaceholderText = "1000"
EggCountBox.Text = "1000"
EggCountBox.Font = Enum.Font.Gotham
EggCountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
EggCountBox.Position = UDim2.new(0, 220, 0, 30)
EggCountBox.Size = UDim2.new(0, 100, 0, 25)
EggCountBox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
EggCountBox.BorderSizePixel = 0
EggCountBox.Parent = ContentFrame

local OpenEggsButton = Instance.new("TextButton")
OpenEggsButton.Text = "START AUTO-HATCH"
OpenEggsButton.Font = Enum.Font.GothamBold
OpenEggsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenEggsButton.TextSize = 16
OpenEggsButton.Position = UDim2.new(0.5, -100, 0, 90)
OpenEggsButton.Size = UDim2.new(0, 200, 0, 40)
OpenEggsButton.BackgroundColor3 = Color3.fromRGB(180, 80, 220)
OpenEggsButton.BorderSizePixel = 0
OpenEggsButton.Parent = ContentFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = OpenEggsButton

-- Animationen
OpenEggsButton.MouseEnter:Connect(function()
    TweenService:Create(OpenEggsButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 100, 240)}):Play()
end)

OpenEggsButton.MouseLeave:Connect(function()
    TweenService:Create(OpenEggsButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(180, 80, 220)}):Play()
end)

-- Egg-Opening Funktion
local function openEggs(amount)
    local eggs = workspace:FindFirstChild("Eggs") or workspace:WaitForChild("Eggs")
    if not eggs then return end

    for i = 1, math.min(tonumber(amount) or 1000, 1000) do
        for _, egg in ipairs(eggs:GetDescendants()) do
            if egg:IsA("Model") and egg.Name:match("Egg") then
                if egg:FindFirstChild("ClickDetector") then
                    fireclickdetector(egg.ClickDetector)
                end
            end
        end
        task.wait(0.1)
    end
end

OpenEggsButton.MouseButton1Click:Connect(function()
    openEggs(EggCountBox.Text)
end)

print("GUI geladen! Features: Drag, Minimieren, Schließen")
