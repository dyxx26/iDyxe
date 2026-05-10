-- [[ iDyxe HUB - Universal Scripts for iDyxe ]] --
-- A copy of the Siexther Hub, branded for iDyxe.

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Variables
local isFlying = false
local isSpinning = false
local walkSpeed = 16
local flingPower = 50
local isFlingingAll = false
local espEnabled = false
local espBoxes = {}

-- Function to create visual elements
local function createVisualElement(instanceName, propertyTable, parentInstance)
    local instance = Instance.new(instanceName)
    for property, value in pairs(propertyTable) do
        instance[property] = value
    end
    instance.Parent = parentInstance
    return instance
end

-- Create GUI
local screenGui = createVisualElement("ScreenGui", {Name = "iDyxeHub", ResetOnSpawn = false}, game.CoreGui)
local mainFrame = createVisualElement("Frame", {
    Name = "iDyxeMainFrame",
    Size = UDim2.new(0, 300, 0, 400),
    Position = UDim2.new(0.5, -150, 0.5, -200),
    BackgroundColor3 = Color3.fromRGB(20, 20, 30),
    BorderSizePixel = 0,
    Draggable = true,
    Active = true,
}, screenGui)
createVisualElement("UICorner", {CornerRadius = UDim.new(0, 8)}, mainFrame)

-- Top Bar
local topBar = createVisualElement("Frame", {
    Name = "iDyxeTopBar",
    Size = UDim2.new(1, 0, 0, 40),
    BackgroundColor3 = Color3.fromRGB(30, 30, 40),
    BorderSizePixel = 0,
}, mainFrame)
createVisualElement("UICorner", {CornerRadius = UDim.new(0, 8)}, topBar)

createVisualElement("TextLabel", {
    Name = "iDyxeTitle",
    Size = UDim2.new(1, -60, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    Text = "iDyxe HUB: GLITCH V1",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 20,
    Font = Enum.Font.Ubuntu,
    BackgroundTransparency = 1,
}, topBar)

-- Close Button
local closeButton = createVisualElement("TextButton", {
    Name = "iDyxeClose",
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(1, -40, 0, 5),
    Text = "X",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 18,
    BackgroundColor3 = Color3.fromRGB(150, 0, 0),
    BorderSizePixel = 0,
}, topBar)
createVisualElement("UICorner", {CornerRadius = UDim.new(0, 5)}, closeButton)
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Scrolling Frame for Tab Content
local scrollingFrame = createVisualElement("ScrollingFrame", {
    Name = "iDyxeScroll",
    Size = UDim2.new(1, -20, 1, -60),
    Position = UDim2.new(0, 10, 0, 50),
    CanvasSize = UDim2.new(0, 0, 0, 800), -- Adjust canvas size
    BackgroundTransparency = 1,
    ScrollBarThickness = 5,
}, mainFrame)

createVisualElement("UIListLayout", {Padding = UDim.new(0, 10), HorizontalAlignment = Enum.HorizontalAlignment.Center}, scrollingFrame)

-- Create common button function
local function createHubButton(name, text, parentInstance)
    local button = createVisualElement("TextButton", {
        Name = name,
        Size = UDim2.new(0.9, 0, 0, 40),
        Text = text,
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 16,
        BackgroundColor3 = Color3.fromRGB(40, 40, 50),
        BorderSizePixel = 0,
    }, parentInstance)
    createVisualElement("UICorner", {CornerRadius = UDim.new(0, 5)}, button)
    return button
end

-- Create Fly Button
local flyButton = createHubButton("iDyxeFly", "iDyxe Fly", scrollingFrame)
flyButton.MouseButton1Click:Connect(function()
    isFlying = not isFlying
    if isFlying then
        flyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        -- Fly implementation using BodyVelocity
        local character = LocalPlayer.Character
        local torso = character and (character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso"))
        local humanoid = character and character:FindFirstChild("Humanoid")

        if torso and humanoid then
            humanoid.PlatformStand = true
            local bv = Instance.new("BodyVelocity")
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.velocity = Vector3.new(0, 0, 0)
            bv.Parent = torso

            local bg = Instance.new("BodyGyro")
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = torso.CFrame
            bg.Parent = torso

            RunService.RenderStepped:Connect(function()
                if isFlying and torso and character and character.Parent then
                    local camera = workspace.CurrentCamera
                    local moveDir = (CFrame.new(torso.Position, camera.CFrame.Position).LookVector * -humanoid.WalkSpeed).Unit
                    
                    local velocity = Vector3.new(0, 0, 0)
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        velocity = moveDir * humanoid.WalkSpeed
                    elseif UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        velocity = -moveDir * humanoid.WalkSpeed
                    end

                    -- Add up/down movement
                    if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
                        velocity = velocity + Vector3.new(0, -50, 0)
                    elseif UserInputService:IsKeyDown(Enum.KeyCode.E) then
                        velocity = velocity + Vector3.new(0, 50, 0)
                    end

                    bv.velocity = velocity
                    bg.cframe = camera.CFrame * CFrame.Angles(-math.rad(camera.CFrame.Position.Unit.Y * 90), 0, 0)
                elseif not isFlying and bv and bg then
                    bv:Destroy()
                    bg:Destroy()
                    humanoid.PlatformStand = false
                end
            end)
        end
    else
        flyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        local character = LocalPlayer.Character
        local torso = character and (character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso"))
        local humanoid = character and character:FindFirstChild("Humanoid")
        if torso then
            local bv = torso:FindFirstChildOfClass("BodyVelocity")
            local bg = torso:FindFirstChildOfClass("BodyGyro")
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
        end
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
end)

-- Create Spin Button
local spinButton = createHubButton("iDyxeSpin", "iDyxe Spin", scrollingFrame)
spinButton.MouseButton1Click:Connect(function()
    isSpinning = not isSpinning
    if isSpinning then
        spinButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        local character = LocalPlayer.Character
        local torso = character and (character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso"))
        if torso then
            local bav = Instance.new("BodyAngularVelocity")
            bav.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bav.angularvelocity = Vector3.new(0, 1000, 0)
            bav.Parent = torso
        end
    else
        spinButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        local character = LocalPlayer.Character
        local torso = character and (character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso"))
        if torso then
            local bav = torso:FindFirstChildOfClass("BodyAngularVelocity")
            if bav then bav:Destroy() end
        end
    end
end)

-- Create WalkSpeed Slider and Label
local speedLabel = createVisualElement("TextLabel", {
    Name = "iDyxeSpeedLabel",
    Size = UDim2.new(0.9, 0, 0, 20),
    Text = "iDyxe Speed: X16",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 16,
    Font = Enum.Font.Ubuntu,
    BackgroundTransparency = 1,
}, scrollingFrame)

local speedSliderFrame = createVisualElement("Frame", {
    Name = "iDyxeSpeedSliderFrame",
    Size = UDim2.new(0.9, 0, 0, 10),
    BackgroundColor3 = Color3.fromRGB(100, 100, 100),
    BorderSizePixel = 0,
}, scrollingFrame)
createVisualElement("UICorner", {CornerRadius = UDim.new(0, 5)}, speedSliderFrame)

local speedSliderIndicator = createVisualElement("Frame", {
    Name = "iDyxeSpeedSliderIndicator",
    Size = UDim2.new(0.1, 0, 1.2, 0),
    Position = UDim2.new(0, 0, -0.1, 0),
    BackgroundColor3 = Color3.new(1, 1, 1),
    BorderSizePixel = 0,
    Draggable = true,
    Active = true,
}, speedSliderFrame)
createVisualElement("UICorner", {CornerRadius = UDim.new(0, 5)}, speedSliderIndicator)

speedSliderIndicator.Changed:Connect(function(property)
    if property == "Position" then
        local currentX = speedSliderIndicator.Position.X.Offset
        local maxX = speedSliderFrame.AbsoluteSize.X - speedSliderIndicator.AbsoluteSize.X
        currentX = math.clamp(currentX, 0, maxX)
        speedSliderIndicator.Position = UDim2.new(0, currentX, speedSliderIndicator.Position.Y.Scale, speedSliderIndicator.Position.Y.Offset)
        
        walkSpeed = 16 + (currentX / maxX) * (200 - 16)
        speedLabel.Text = "iDyxe Speed: X" .. math.floor(walkSpeed)
        
        local character = LocalPlayer.Character
        local humanoid = character and character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = walkSpeed
        end
    end
end)

-- Create Fling All Button
local flingAllButton = createHubButton("iDyxeFlingAll", "iDyxe Fling All Player", scrollingFrame)
flingAllButton.MouseButton1Click:Connect(function()
    isFlingingAll = not isFlingingAll
    if isFlingingAll then
        flingAllButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        -- Fling All implementation
        local function flingPlayer(targetPlayer)
            local targetCharacter = targetPlayer.Character
            local targetTorso = targetCharacter and (targetCharacter:FindFirstChild("Torso") or targetCharacter:FindFirstChild("UpperTorso"))
            if targetTorso then
                local bav = Instance.new("BodyAngularVelocity")
                bav.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                bav.angularvelocity = Vector3.new(9e9, 9e9, 9e9)
                bav.Parent = targetTorso
                delay(0.5, function()
                    if bav then bav:Destroy() end
                end)
            end
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                flingPlayer(player)
            end
        end
        flingAllButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        isFlingingAll = false
    end
end)

-- Create Teleport Button
local teleportButton = createHubButton("iDyxeTeleport", "iDyxe Teleport", scrollingFrame)
teleportButton.MouseButton1Click:Connect(function()
    -- Use a simple prompt function
    local function simplePrompt(title, placeholderText)
        local promptFrame = createVisualElement("Frame", {
            Size = UDim2.new(0, 200, 0, 100),
            Position = UDim2.new(0.5, -100, 0.5, -50),
            BackgroundColor3 = Color3.fromRGB(30, 30, 40),
            BorderSizePixel = 0,
        }, screenGui)
        createVisualElement("UICorner", {CornerRadius = UDim.new(0, 8)}, promptFrame)

        createVisualElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, 30),
            Text = title,
            TextColor3 = Color3.new(1, 1, 1),
            TextSize = 16,
            BackgroundTransparency = 1,
        }, promptFrame)

        local inputTextBox = createVisualElement("TextBox", {
            Size = UDim2.new(0.8, 0, 0, 30),
            Position = UDim2.new(0.1, 0, 0.4, 0),
            Text = "",
            PlaceholderText = placeholderText,
            TextColor3 = Color3.new(1, 1, 1),
            TextSize = 14,
            BackgroundColor3 = Color3.fromRGB(40, 40, 50),
            BorderSizePixel = 0,
        }, promptFrame)
        createVisualElement("UICorner", {CornerRadius = UDim.new(0, 5)}, inputTextBox)

        local okButton = createVisualElement("TextButton", {
            Size = UDim2.new(0, 50, 0, 30),
            Position = UDim2.new(0.3, 0, 0.75, 0),
            Text = "OK",
            TextColor3 = Color3.new(1, 1, 1),
            TextSize = 14,
            BackgroundColor3 = Color3.fromRGB(150, 0, 0),
            BorderSizePixel = 0,
        }, promptFrame)
        createVisualElement("UICorner", {CornerRadius = UDim.new(0, 5)}, okButton)
        okButton.MouseButton1Click:Connect(function()
            promptFrame:Destroy()
            local targetPlayerName = inputTextBox.Text
            local targetPlayer = Players:FindFirstChild(targetPlayerName)
            if targetPlayer then
                LocalPlayer.Character:MoveTo(targetPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
            end
        end)
    end
    simplePrompt("iDyxe Teleport", "Enter Player Name")
end)

-- Create ESP Button
local espButton = createHubButton("iDyxeESP", "iDyxe ESP", scrollingFrame)
espButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        espButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        -- ESP implementation
        local function createESPBox(player)
            if espBoxes[player] then espBoxes[player]:Destroy() end
            if player.Character and player.Character:FindFirstChild("Torso") then
                local espBox = createVisualElement("BoxHandleAdornment", {
                    Adornee = player.Character.Torso,
                    Size = Vector3.new(4, 6, 2), -- Box size
                    Transparency = 0.5,
                    Color3 = Color3.new(1, 0, 0), -- ESP Color
                    ZIndex = 1,
                    AlwaysOnTop = true,
                }, workspace)
                espBoxes[player] = espBox
            end
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                createESPBox(player)
            end
        end
        
        RunService.RenderStepped:Connect(function()
            if espEnabled then
                for player, _ in pairs(espBoxes) do
                    if not player.Parent then
                        espBoxes[player]:Destroy()
                        espBoxes[player] = nil
                    end
                end
            end
        end)
    else
        espButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        for _, box in pairs(espBoxes) do
            box:Destroy()
        end
        espBoxes = {}
    end
end)

-- Notify
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "iDyxe HUB",
        Text = "iDyxe HUB v1.0 Loaded. Selamat datang, Tuan iDyxe! 😈",
        Duration = 5,
    })
end)
