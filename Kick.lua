-- 1. GUI SETUP (CREATION)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local NameInput = Instance.new("TextBox")
local ScanKickBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")

-- Protect GUI from being deleted (CoreGui is best for executors)
local success, err = pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)
if not success then ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end

-- Main Window Design
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.5, -110, 0.4, -80)
MainFrame.Size = UDim2.new(0, 220, 0, 160)
MainFrame.Active = true
MainFrame.Draggable = true

-- Title Bar
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Text = "REMOTE ADMIN V1"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16

-- Close Button
CloseBtn.Parent = MainFrame
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Username Input Field
NameInput.Parent = MainFrame
NameInput.Position = UDim2.new(0.1, 0, 0.35, 0)
NameInput.Size = UDim2.new(0.8, 0, 0, 30)
NameInput.PlaceholderText = "Target Username..."
NameInput.Text = ""
NameInput.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
NameInput.TextColor3 = Color3.new(0, 0, 0)

-- SCAN & KICK Button
ScanKickBtn.Parent = MainFrame
ScanKickBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
ScanKickBtn.Size = UDim2.new(0.8, 0, 0, 40)
ScanKickBtn.Text = "SCAN & KICK"
ScanKickBtn.BackgroundColor3 = Color3.fromRGB(130, 0, 0)
ScanKickBtn.TextColor3 = Color3.new(1, 1, 1)
ScanKickBtn.Font = Enum.Font.SourceSansBold
ScanKickBtn.TextSize = 14

-- 2. SCAN & KICK ENGINE
ScanKickBtn.MouseButton1Click:Connect(function()
    local targetName = NameInput.Text
    local target = game.Players:FindFirstChild(targetName)
    
    if targetName == "" or not target then
        ScanKickBtn.Text = "PLAYER NOT FOUND"
        wait(1.5)
        ScanKickBtn.Text = "SCAN & KICK"
        return
    end

    print("Executing global scan for: " .. targetName)
    ScanKickBtn.Text = "SCANNING..."
    ScanKickBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)

    -- Function to search and trigger RemoteEvents
    local function deepScan(folder)
        for _, remote in ipairs(folder:GetDescendants()) do
            if remote:IsA("RemoteEvent") then
                pcall(function()
                    -- Common remote vulnerability parameters
                    remote:FireServer("Kick", targetName)
                    remote:FireServer("Ban", targetName, "Exploiting")
                    remote:FireServer(target, "Kick")
                    remote:FireServer("admin", "kick", targetName)
                    remote:FireServer(targetName, "kick")
                    remote:FireServer("Moderation", "Kick", targetName)
                    remote:FireServer("server", "kick", targetName)
                end)
            end
        end
    end

    -- Run scan in most likely places
    deepScan(game:GetService("ReplicatedStorage"))
    deepScan(game:GetService("Workspace"))
    deepScan(game:GetService("JointsService"))

    wait(1)
    ScanKickBtn.Text = "FINISHED!"
    ScanKickBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 0)
    wait(1.5)
    ScanKickBtn.Text = "SCAN & KICK"
    ScanKickBtn.BackgroundColor3 = Color3.fromRGB(130, 0, 0)
end)

