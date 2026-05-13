-- ╔══════════════════════════════════════╗
-- ║         iDyxe 8.5 Script            ║
-- ║     github.com/iDyxe                ║
-- ╚══════════════════════════════════════╝

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")
local Camera = workspace.CurrentCamera

-- ============================================================
-- OVERHEAD TITLE SYSTEM
-- ============================================================

local TitlePresets = {
    { name = "❌ None",          text = "",               color = Color3.new(1,1,1),              stroke = Color3.new(0,0,0) },
    { name = "⚡ Admin",         text = "⚡ ADMIN",        color = Color3.fromRGB(255, 60,  60),   stroke = Color3.fromRGB(120, 0,   0) },
    { name = "💎 VIP",           text = "💎 VIP",          color = Color3.fromRGB(255, 215, 0),    stroke = Color3.fromRGB(150, 100, 0) },
    { name = "👑 Owner",         text = "👑 OWNER",        color = Color3.fromRGB(255, 170, 0),    stroke = Color3.fromRGB(120, 60,  0) },
    { name = "🛡️ Moderator",     text = "🛡️ MOD",          color = Color3.fromRGB(80,  160, 255),  stroke = Color3.fromRGB(20,  60,  140) },
    { name = "🔥 iDyxe",         text = "🔥 iDyxe",        color = Color3.fromRGB(66,  135, 245),  stroke = Color3.fromRGB(20,  50,  130) },
    { name = "☠️ Hacker",        text = "☠️ HACKER",       color = Color3.fromRGB(180, 0,   255),  stroke = Color3.fromRGB(70,  0,   110) },
    { name = "🌈 Rainbow",       text = "✨ iDyxe ✨",     color = Color3.fromRGB(255, 100, 200),  stroke = Color3.fromRGB(100, 0,   80) },
    { name = "🤖 Bot",           text = "🤖 BOT",          color = Color3.fromRGB(50,  200, 150),  stroke = Color3.fromRGB(0,   80,  60) },
    { name = "💀 God",           text = "💀 GOD MODE",     color = Color3.fromRGB(255, 255, 255),  stroke = Color3.fromRGB(60,  60,  60) },
    { name = "🎮 Gamer",         text = "🎮 GAMER",        color = Color3.fromRGB(0,   230, 100),  stroke = Color3.fromRGB(0,   80,  30) },
    { name = "⭐ Star",           text = "⭐ STAR",         color = Color3.fromRGB(255, 240, 80),   stroke = Color3.fromRGB(120, 100, 0) },
    { name = "🔱 Legend",        text = "🔱 LEGEND",       color = Color3.fromRGB(200, 100, 255),  stroke = Color3.fromRGB(80,  0,   150) },
    { name = "💥 Destroyer",     text = "💥 DESTROYER",    color = Color3.fromRGB(255, 120, 30),   stroke = Color3.fromRGB(120, 40,  0) },
}

local currentBillboard = nil
local rainbowTitleConn = nil
local currentTitleIndex = 1
local previewLbl -- forward declare (set later in TITLE tab)

local function RemoveTitle()
    if rainbowTitleConn then rainbowTitleConn:Disconnect() rainbowTitleConn = nil end
    if currentBillboard then currentBillboard:Destroy() currentBillboard = nil end
end

local function ApplyTitle(preset)
    RemoveTitle()
    if preset.text == "" then return end

    local head = Character:FindFirstChild("Head")
    if not head then return end

    -- BillboardGui parented to Head = visible to ALL players in server
    local bb = Instance.new("BillboardGui")
    bb.Name = "iDyxeTitle"
    bb.Size = UDim2.new(0, 220, 0, 46)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = false
    bb.ResetOnSpawn = false
    bb.Parent = head
    currentBillboard = bb

    -- Pill background
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(10, 12, 20)
    bg.BackgroundTransparency = 0.2
    bg.BorderSizePixel = 0
    bg.Parent = bb
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)

    local bgStroke = Instance.new("UIStroke")
    bgStroke.Color = preset.color
    bgStroke.Thickness = 2.5
    bgStroke.Parent = bg

    -- Title text
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 1, 0)
    lbl.Position = UDim2.new(0, 5, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = preset.text
    lbl.TextColor3 = preset.color
    lbl.TextScaled = true
    lbl.Font = Enum.Font.GothamBold
    lbl.TextStrokeColor3 = preset.stroke
    lbl.TextStrokeTransparency = 0.2
    lbl.Parent = bb

    -- Rainbow special
    if preset.name == "🌈 Rainbow" then
        local hue = 0
        rainbowTitleConn = RunService.Heartbeat:Connect(function()
            hue = (hue + 0.008) % 1
            local c = Color3.fromHSV(hue, 1, 1)
            lbl.TextColor3 = c
            bgStroke.Color = c
        end)
    end
end

LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    RootPart = newChar:WaitForChild("HumanoidRootPart")
    Humanoid = newChar:WaitForChild("Humanoid")
    currentBillboard = nil
    task.wait(1)
    if currentTitleIndex > 1 then
        ApplyTitle(TitlePresets[currentTitleIndex])
    end
    if godModeActive then
        Humanoid.MaxHealth = math.huge
        Humanoid.Health = math.huge
    end
end)

-- ============================================================
-- MAIN GUI
-- ============================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "iDyxeGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

local isMinimized = false
local FULL_HEIGHT = 340
local MINI_HEIGHT = 36

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 480, 0, FULL_HEIGHT)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(66, 135, 245)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 36)
TitleBar.BackgroundColor3 = Color3.fromRGB(14, 16, 24)
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 5
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 8)

-- Blue dot logo
local LogoDot = Instance.new("Frame")
LogoDot.Size = UDim2.new(0, 10, 0, 10)
LogoDot.Position = UDim2.new(0, 12, 0.5, -5)
LogoDot.BackgroundColor3 = Color3.fromRGB(66, 135, 245)
LogoDot.BorderSizePixel = 0
LogoDot.ZIndex = 6
LogoDot.Parent = TitleBar
Instance.new("UICorner", LogoDot).CornerRadius = UDim.new(1, 0)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0.5, 0, 1, 0)
TitleLabel.Position = UDim2.new(0, 28, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "iDYXE 8.5"
TitleLabel.TextColor3 = Color3.fromRGB(66, 135, 245)
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 6
TitleLabel.Parent = TitleBar

-- Button holder (right side of title bar)
local BtnHolder = Instance.new("Frame")
BtnHolder.Size = UDim2.new(0, 70, 0, 28)
BtnHolder.Position = UDim2.new(1, -76, 0.5, -14)
BtnHolder.BackgroundTransparency = 1
BtnHolder.ZIndex = 6
BtnHolder.Parent = TitleBar

local BtnLayout = Instance.new("UIListLayout")
BtnLayout.FillDirection = Enum.FillDirection.Horizontal
BtnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
BtnLayout.VerticalAlignment = Enum.VerticalAlignment.Center
BtnLayout.Padding = UDim.new(0, 4)
BtnLayout.Parent = BtnHolder

-- Minimize Button (yellow)
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.BackgroundColor3 = Color3.fromRGB(230, 170, 0)
MinBtn.Text = "─"
MinBtn.TextColor3 = Color3.new(1,1,1)
MinBtn.TextSize = 14
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0
MinBtn.ZIndex = 7
MinBtn.LayoutOrder = 1
MinBtn.Parent = BtnHolder
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

-- Close Button (red)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 7
CloseBtn.LayoutOrder = 2
CloseBtn.Parent = BtnHolder
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- Hover effects on buttons
MinBtn.MouseEnter:Connect(function() TweenService:Create(MinBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 200, 30)}):Play() end)
MinBtn.MouseLeave:Connect(function() TweenService:Create(MinBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(230, 170, 0)}):Play() end)
CloseBtn.MouseEnter:Connect(function() TweenService:Create(CloseBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(240, 80, 80)}):Play() end)
CloseBtn.MouseLeave:Connect(function() TweenService:Create(CloseBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(200, 50, 50)}):Play() end)

-- Minimize logic with smooth tween
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    local targetH = isMinimized and MINI_HEIGHT or FULL_HEIGHT
    TweenService:Create(MainFrame, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 480, 0, targetH)
    }):Play()
    MinBtn.Text = isMinimized and "▲" or "─"
end)

CloseBtn.MouseButton1Click:Connect(function()
    RemoveTitle()
    ScreenGui:Destroy()
end)

-- Divider line
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, 0, 0, 1)
Divider.Position = UDim2.new(0, 0, 0, 36)
Divider.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 110, 1, -37)
Sidebar.Position = UDim2.new(0, 0, 0, 37)
Sidebar.BackgroundColor3 = Color3.fromRGB(14, 16, 22)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local SidebarList = Instance.new("UIListLayout")
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Padding = UDim.new(0, 4)
SidebarList.Parent = Sidebar

local SidebarPad = Instance.new("UIPadding")
SidebarPad.PaddingTop = UDim.new(0, 8)
SidebarPad.PaddingLeft = UDim.new(0, 6)
SidebarPad.PaddingRight = UDim.new(0, 6)
SidebarPad.Parent = Sidebar

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -116, 1, -44)
ContentArea.Position = UDim2.new(0, 114, 0, 40)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- ============================================================
-- HELPERS
-- ============================================================

local function MakeNavBtn(text, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(22, 25, 35)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(180, 185, 200)
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.LayoutOrder = order
    btn.Parent = Sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local function MakePanel(name)
    local panel = Instance.new("ScrollingFrame")
    panel.Name = name
    panel.Size = UDim2.new(1, 0, 1, 0)
    panel.BackgroundTransparency = 1
    panel.BorderSizePixel = 0
    panel.ScrollBarThickness = 3
    panel.ScrollBarImageColor3 = Color3.fromRGB(66, 135, 245)
    panel.Visible = false
    panel.Parent = ContentArea
    local list = Instance.new("UIListLayout")
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, 5)
    list.Parent = panel
    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 4)
    pad.PaddingRight = UDim.new(0, 6)
    pad.Parent = panel
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        panel.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 10)
    end)
    return panel
end

local function MakeToggle(panel, labelText, order, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 34)
    row.BackgroundColor3 = Color3.fromRGB(22, 25, 35)
    row.BorderSizePixel = 0
    row.LayoutOrder = order
    row.Parent = panel
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(200, 205, 220)
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row
    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.new(0, 36, 0, 18)
    toggleBg.Position = UDim2.new(1, -46, 0.5, -9)
    toggleBg.BackgroundColor3 = Color3.fromRGB(50, 55, 70)
    toggleBg.BorderSizePixel = 0
    toggleBg.Parent = row
    Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1, 0)
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(0, 2, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(130, 135, 155)
    knob.BorderSizePixel = 0
    knob.Parent = toggleBg
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    local state = false
    local function updateToggle()
        if state then
            TweenService:Create(knob, TweenInfo.new(0.15), {Position = UDim2.new(0, 20, 0.5, -7), BackgroundColor3 = Color3.fromRGB(255,255,255)}):Play()
            TweenService:Create(toggleBg, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(66, 135, 245)}):Play()
        else
            TweenService:Create(knob, TweenInfo.new(0.15), {Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = Color3.fromRGB(130, 135, 155)}):Play()
            TweenService:Create(toggleBg, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(50, 55, 70)}):Play()
        end
        if callback then callback(state) end
    end
    row.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            state = not state
            updateToggle()
        end
    end)
    return row
end

local function MakeButton(panel, labelText, order, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = Color3.fromRGB(26, 30, 44)
    btn.Text = labelText
    btn.TextColor3 = Color3.fromRGB(200, 205, 220)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.LayoutOrder = order
    btn.Parent = panel
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(66, 135, 245)}):Play() end)
    btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(26, 30, 44)}):Play() end)
    if callback then btn.MouseButton1Click:Connect(callback) end
    return btn
end

local function MakeSectionLabel(panel, text, order)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(100, 110, 140)
    lbl.TextSize = 10
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Center
    lbl.LayoutOrder = order
    lbl.Parent = panel
    return lbl
end

-- ============================================================
-- PANELS & TABS
-- ============================================================
local Panels = {}
local NavBtns = {}
local Categories = {"IDYXE", "UNIVERSAL", "CHAOTIC", "SERVER", "TITLE", "SETTINGS"}

for i, cat in ipairs(Categories) do
    Panels[cat] = MakePanel(cat)
    NavBtns[cat] = MakeNavBtn(cat, i)
end

local function SelectTab(name)
    for k, p in pairs(Panels) do p.Visible = false end
    for k, b in pairs(NavBtns) do
        TweenService:Create(b, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(22, 25, 35), TextColor3 = Color3.fromRGB(180, 185, 200)}):Play()
    end
    Panels[name].Visible = true
    TweenService:Create(NavBtns[name], TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(66, 135, 245), TextColor3 = Color3.new(1,1,1)}):Play()
end
for k, btn in pairs(NavBtns) do
    local name = k
    btn.MouseButton1Click:Connect(function() SelectTab(name) end)
end
SelectTab("IDYXE")

-- ============================================================
-- FEATURE VARIABLES
-- ============================================================
local flySpeed = 50
local flyActive = false
local flyConnection
local noclipActive = false
local noclipConnection
local infiniteJumpActive = false
local infiniteJumpConnection
local invisibilityActive = false
local antiFlingActive = false
local godModeActive = false
local espActive = false
local espObjects = {}

-- ============================================================
-- TAB: IDYXE
-- ============================================================
local p = Panels["IDYXE"]
MakeSectionLabel(p, "── iDYXE ──", 0)

MakeToggle(p, "ANTI FLING", 1, function(state)
    antiFlingActive = state
    local hum = Character:FindFirstChild("Humanoid")
    if hum then hum.AutoRotate = not state end
end)

MakeToggle(p, "TOUCH FLING", 2, function(state) end)

MakeToggle(p, "INVISIBILITY", 3, function(state)
    invisibilityActive = state
    for _, part in pairs(Character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = state and 1 or 0
        end
    end
end)

MakeToggle(p, "GOD MODE", 4, function(state)
    godModeActive = state
    local hum = Character:FindFirstChild("Humanoid")
    if hum then
        hum.MaxHealth = state and math.huge or 100
        hum.Health = state and math.huge or 100
    end
end)

MakeToggle(p, "INFINITE JUMP", 5, function(state)
    infiniteJumpActive = state
    if state then
        infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
            if infiniteJumpActive then
                local hum = Character:FindFirstChild("Humanoid")
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    else
        if infiniteJumpConnection then infiniteJumpConnection:Disconnect() end
    end
end)

MakeToggle(p, "NO CLIP", 6, function(state)
    noclipActive = state
    if state then
        noclipConnection = RunService.Stepped:Connect(function()
            if noclipActive then
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() end
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end)

MakeSectionLabel(p, "── LOCOMOTION ──", 7)

MakeButton(p, "iDYXE AUTO WALK", 8, function()
    local hum = Character:FindFirstChild("Humanoid")
    if hum then hum.WalkToPoint = RootPart.Position + RootPart.CFrame.LookVector * 9999 end
end)

MakeButton(p, "iDYXE AUTO TELEPORT", 9, function()
    local s = workspace:FindFirstChildOfClass("SpawnLocation")
    if s then RootPart.CFrame = s.CFrame + Vector3.new(0, 5, 0) end
end)

MakeButton(p, "iDYXE FLY (TOGGLE)", 10, function()
    flyActive = not flyActive
    if flyActive then
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.zero; bv.MaxForce = Vector3.new(1e9,1e9,1e9); bv.Parent = RootPart
        local bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(1e9,1e9,1e9); bg.D = 100; bg.Parent = RootPart
        flyConnection = RunService.Heartbeat:Connect(function()
            if not flyActive then bv:Destroy(); bg:Destroy(); flyConnection:Disconnect(); return end
            local cf = Camera.CFrame; local dir = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
            bv.Velocity = dir * flySpeed; bg.CFrame = cf
        end)
    else
        if flyConnection then flyConnection:Disconnect() end
    end
end)

MakeButton(p, "iDYXE FLY V2 (FAST TOGGLE)", 11, function()
    flySpeed = flySpeed == 50 and 150 or 50
end)

MakeButton(p, "iDYXE GLITCH", 12, function()
    for i=1,10 do task.wait(0.05)
        RootPart.CFrame = RootPart.CFrame * CFrame.new(math.random(-5,5), math.random(-2,2), math.random(-5,5))
    end
end)

MakeButton(p, "iDYXE GLITCH V2", 13, function()
    for i=1,20 do task.wait(0.02)
        RootPart.CFrame = CFrame.new(RootPart.Position + Vector3.new(math.random(-10,10), 0, math.random(-10,10)))
    end
end)

MakeButton(p, "iDYXE ANIMATED", 14, function()
    local head = Character:FindFirstChild("Head"); if not head then return end
    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 180, 0, 40); bb.StudsOffset = Vector3.new(0, 5, 0); bb.AlwaysOnTop = true; bb.Parent = head
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,0,1,0); l.BackgroundTransparency = 1; l.Text = "iDyxe"
    l.TextScaled = true; l.Font = Enum.Font.GothamBold; l.Parent = bb
    local hue = 0; local conn
    conn = RunService.Heartbeat:Connect(function() hue = (hue+0.01)%1; l.TextColor3 = Color3.fromHSV(hue,1,1) end)
    task.delay(10, function() conn:Disconnect(); bb:Destroy() end)
end)

MakeButton(p, "iDYXE EMOTE", 15, function()
    local anim = Instance.new("Animation"); anim.AnimationId = "rbxassetid://507771019"
    local hum = Character:FindFirstChild("Humanoid")
    if hum then hum.Animator:LoadAnimation(anim):Play() end
end)

-- ============================================================
-- TAB: UNIVERSAL
-- ============================================================
local pu = Panels["UNIVERSAL"]
MakeSectionLabel(pu, "── UNIVERSAL ──", 0)
MakeButton(pu, "iDYXE INJECTION", 1, function() warn("iDyxe Injection!") end)
MakeButton(pu, "iDYXE KIMCOHI", 2, function()
    local spinning = true; local conn
    conn = RunService.Heartbeat:Connect(function()
        if spinning then RootPart.CFrame = RootPart.CFrame * CFrame.Angles(0, math.rad(15), 0)
        else conn:Disconnect() end
    end)
    task.delay(3, function() spinning = false end)
end)
MakeButton(pu, "iDYXE LAG SERVER", 3, function()
    for i=1,50 do local pp = Instance.new("Part"); pp.Parent = workspace; pp.Position = RootPart.Position; game:GetService("Debris"):AddItem(pp,1) end
end)
MakeButton(pu, "iDYXE SPAM", 4, function()
    for i=1,10 do task.wait(0.1); game:GetService("Chat"):Chat(Character.Head, "iDyxe 8.5 | Best Script!", Enum.ChatColor.Blue) end
end)
MakeButton(pu, "iDYXE CHARME", 5, function()
    game:GetService("Chat"):Chat(Character.Head, "✨ iDyxe ✨", Enum.ChatColor.Red)
end)
MakeButton(pu, "iDYXE TALL MAN", 6, function()
    local hum = Character:FindFirstChild("Humanoid")
    if hum then hum.HipHeight = hum.HipHeight == 0 and 10 or 0 end
end)
MakeButton(pu, "TROLL PLAYER", 7, function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local tr = plr.Character:FindFirstChild("HumanoidRootPart")
            if tr then
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = (tr.Position-RootPart.Position).Unit*200+Vector3.new(0,100,0)
                bv.MaxForce = Vector3.new(1e9,1e9,1e9); bv.Parent = tr
                game:GetService("Debris"):AddItem(bv, 0.2)
            end
        end
    end
end)
MakeButton(pu, "ESP PLAYER", 8, function()
    espActive = not espActive
    for _, obj in pairs(espObjects) do if obj then obj:Destroy() end end; espObjects = {}
    if espActive then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local root = plr.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local bboard = Instance.new("BillboardGui")
                    bboard.Size = UDim2.new(0,100,0,30); bboard.StudsOffset = Vector3.new(0,3,0)
                    bboard.AlwaysOnTop = true; bboard.Parent = root
                    local l2 = Instance.new("TextLabel")
                    l2.Size = UDim2.new(1,0,1,0); l2.BackgroundTransparency = 1; l2.Text = plr.Name
                    l2.TextColor3 = Color3.fromRGB(255,80,80); l2.TextScaled = true; l2.Font = Enum.Font.GothamBold; l2.Parent = bboard
                    table.insert(espObjects, bboard)
                end
            end
        end
    end
end)
MakeButton(pu, "FAKE DONATE", 9, function()
    game:GetService("Chat"):Chat(Character.Head, "I just donated 1000 Robux!", Enum.ChatColor.Green)
end)
MakeButton(pu, "TRANSLATE", 10, function()
    game:GetService("Chat"):Chat(Character.Head, "iDyxe Script - Best Roblox Script!", Enum.ChatColor.Blue)
end)
MakeSectionLabel(pu, "── iDYXE AURA ──", 11)
MakeButton(pu, "iDYXE AURA", 12, function()
    local sel = Instance.new("SelectionBox")
    sel.Color3 = Color3.fromRGB(66,135,245); sel.SurfaceColor3 = Color3.fromRGB(66,135,245)
    sel.SurfaceTransparency = 0.7; sel.Adornee = RootPart; sel.Parent = workspace
    game:GetService("Debris"):AddItem(sel, 5)
end)
MakeButton(pu, "iDYXE AURA FAST", 13, function()
    local sel = Instance.new("SelectionBox"); sel.Adornee = RootPart; sel.Parent = workspace
    local colors = {Color3.fromRGB(255,0,0),Color3.fromRGB(0,255,0),Color3.fromRGB(0,0,255),Color3.fromRGB(255,255,0),Color3.fromRGB(255,0,255)}
    local idx = 1; local conn2
    conn2 = RunService.Heartbeat:Connect(function()
        idx = (idx%#colors)+1; sel.Color3 = colors[idx]; sel.SurfaceColor3 = colors[idx]; sel.SurfaceTransparency = 0.7
    end)
    task.delay(5, function() conn2:Disconnect(); sel:Destroy() end)
end)

-- ============================================================
-- TAB: CHAOTIC
-- ============================================================
local pc = Panels["CHAOTIC"]
MakeSectionLabel(pc, "── CHAOTIC ──", 0)
MakeButton(pc, "iDYXE FLING", 1, function()
    local bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(math.random(-200,200),300,math.random(-200,200))
    bv.MaxForce = Vector3.new(1e9,1e9,1e9); bv.Parent = RootPart
    game:GetService("Debris"):AddItem(bv, 0.5)
end)
MakeButton(pc, "iDYXE BROKEN", 2, function()
    local hum = Character:FindFirstChild("Humanoid")
    if hum then hum:ChangeState(Enum.HumanoidStateType.Dead) end
    task.wait(1); LocalPlayer:LoadCharacter()
end)
MakeButton(pc, "iDYXE CHAOTIC", 3, function()
    for i=1,15 do task.wait(0.05)
        RootPart.CFrame = CFrame.new(RootPart.Position.X+math.random(-20,20), RootPart.Position.Y+math.random(0,5), RootPart.Position.Z+math.random(-20,20))
    end
end)
MakeButton(pc, "iDYXE PART CONTROLLER", 4, function()
    local prt = Instance.new("Part"); prt.Size = Vector3.new(4,4,4)
    prt.Position = RootPart.Position+Vector3.new(0,5,0); prt.BrickColor = BrickColor.new("Bright blue")
    prt.Material = Enum.Material.Neon; prt.Parent = workspace; game:GetService("Debris"):AddItem(prt,5)
end)
MakeButton(pc, "iDYXE BRING", 5, function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then root.CFrame = RootPart.CFrame * CFrame.new(3,0,0); break end
        end
    end
end)
MakeButton(pc, "iDYXE BRING V2", 6, function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then root.CFrame = RootPart.CFrame * CFrame.new(math.random(-5,5),0,math.random(-5,5)) end
        end
    end
end)

-- ============================================================
-- TAB: SERVER
-- ============================================================
local ps = Panels["SERVER"]
MakeSectionLabel(ps, "── SERVER ──", 0)
MakeButton(ps, "ANTI LAG & FPS BOOSTER", 1, function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") then obj:Destroy() end
    end
    game:GetService("Lighting").GlobalShadows = false; game:GetService("Lighting").FogEnd = 9e9
end)
MakeButton(ps, "ULTRA GRAPHICS", 2, function()
    game:GetService("Lighting").GlobalShadows = true; game:GetService("Lighting").Brightness = 3
end)
MakeButton(ps, "FREECAM", 3, function()
    local cam = workspace.CurrentCamera
    cam.CameraType = cam.CameraType == Enum.CameraType.Custom and Enum.CameraType.Scriptable or Enum.CameraType.Custom
end)
MakeButton(ps, "SPECTATE PLAYER", 4, function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local cam = workspace.CurrentCamera; cam.CameraType = Enum.CameraType.Scriptable
                cam.CFrame = CFrame.new(root.Position+Vector3.new(0,5,-10), root.Position); break
            end
        end
    end
end)
MakeButton(ps, "TELEPORT PLAYER", 5, function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then RootPart.CFrame = root.CFrame * CFrame.new(3,0,0); break end
        end
    end
end)
MakeButton(ps, "ALL SERVER TELEPORT", 6, function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then root.CFrame = RootPart.CFrame * CFrame.new(math.random(-8,8),0,math.random(-8,8)) end
        end
    end
end)
MakeButton(ps, "SKY CHANGER", 7, function()
    local sky = game:GetService("Lighting"):FindFirstChildOfClass("Sky")
    if sky then sky:Destroy() else
        local ns = Instance.new("Sky")
        ns.SkyboxBk="rbxassetid://159454286"; ns.SkyboxDn="rbxassetid://159454296"
        ns.SkyboxFt="rbxassetid://159454288"; ns.SkyboxLf="rbxassetid://159454292"
        ns.SkyboxRt="rbxassetid://159454290"; ns.SkyboxUp="rbxassetid://159454300"
        ns.Parent = game:GetService("Lighting")
    end
end)
MakeButton(ps, "SCAN AUDIO", 8, function()
    local sounds = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Sound") and obj.Playing then table.insert(sounds, obj.Name) end
    end
    game:GetService("Chat"):Chat(Character.Head, #sounds>0 and "Sounds: "..table.concat(sounds,", ") or "No sounds!", Enum.ChatColor.Blue)
end)

-- ============================================================
-- TAB: TITLE (OVERHEAD TITLE)
-- ============================================================
local pt = Panels["TITLE"]

-- Header info
local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(1, 0, 0, 38)
infoFrame.BackgroundColor3 = Color3.fromRGB(20, 24, 38)
infoFrame.BorderSizePixel = 0
infoFrame.LayoutOrder = 0
infoFrame.Parent = pt
Instance.new("UICorner", infoFrame).CornerRadius = UDim.new(0, 6)

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, 0, 1, 0)
infoText.BackgroundTransparency = 1
infoText.Text = "🌐 Title visible to ALL players in server"
infoText.TextColor3 = Color3.fromRGB(66, 135, 245)
infoText.TextSize = 11
infoText.Font = Enum.Font.GothamBold
infoText.TextXAlignment = Enum.TextXAlignment.Center
infoText.Parent = infoFrame

-- Active title preview
previewLbl = Instance.new("TextLabel")
previewLbl.Size = UDim2.new(1, 0, 0, 34)
previewLbl.BackgroundColor3 = Color3.fromRGB(14, 16, 22)
previewLbl.BackgroundTransparency = 0
previewLbl.Text = "No title active"
previewLbl.TextColor3 = Color3.fromRGB(100, 110, 140)
previewLbl.TextSize = 12
previewLbl.Font = Enum.Font.GothamBold
previewLbl.TextXAlignment = Enum.TextXAlignment.Center
previewLbl.LayoutOrder = 1
previewLbl.Parent = pt
Instance.new("UICorner", previewLbl).CornerRadius = UDim.new(0, 6)
local previewStroke = Instance.new("UIStroke")
previewStroke.Color = Color3.fromRGB(40, 45, 60)
previewStroke.Thickness = 1.5
previewStroke.Parent = previewLbl

MakeSectionLabel(pt, "── CHOOSE YOUR TITLE ──", 2)

-- All title buttons
local allTitleStrokes = {}
for i, preset in ipairs(TitlePresets) do
    local titleBtn = Instance.new("TextButton")
    titleBtn.Size = UDim2.new(1, 0, 0, 36)
    titleBtn.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
    titleBtn.Text = (preset.text == "" and "❌  Remove Title" or preset.name)
    titleBtn.TextColor3 = (i == 1) and Color3.fromRGB(150,155,170) or preset.color
    titleBtn.TextSize = 12
    titleBtn.Font = Enum.Font.GothamBold
    titleBtn.BorderSizePixel = 0
    titleBtn.LayoutOrder = i + 2
    titleBtn.Parent = pt
    Instance.new("UICorner", titleBtn).CornerRadius = UDim.new(0, 6)

    local ts = Instance.new("UIStroke")
    ts.Color = preset.color
    ts.Thickness = 0
    ts.Parent = titleBtn
    table.insert(allTitleStrokes, {btn = titleBtn, stroke = ts, preset = preset})

    titleBtn.MouseEnter:Connect(function()
        TweenService:Create(titleBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(30, 35, 56)}):Play()
        if ts.Thickness == 0 then TweenService:Create(ts, TweenInfo.new(0.12), {Thickness = 1}):Play() end
    end)
    titleBtn.MouseLeave:Connect(function()
        TweenService:Create(titleBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(22, 26, 40)}):Play()
        if ts.Thickness <= 1 then TweenService:Create(ts, TweenInfo.new(0.12), {Thickness = 0}):Play() end
    end)

    titleBtn.MouseButton1Click:Connect(function()
        currentTitleIndex = i
        ApplyTitle(preset)

        -- Update all strokes
        for _, entry in ipairs(allTitleStrokes) do
            TweenService:Create(entry.stroke, TweenInfo.new(0.15), {Thickness = 0}):Play()
        end
        TweenService:Create(ts, TweenInfo.new(0.15), {Thickness = 2}):Play()

        -- Update preview
        if preset.text == "" then
            previewLbl.Text = "No title active"
            previewLbl.TextColor3 = Color3.fromRGB(100, 110, 140)
            previewStroke.Color = Color3.fromRGB(40, 45, 60)
        else
            previewLbl.Text = "● " .. preset.text .. " (active)"
            previewLbl.TextColor3 = preset.color
            previewStroke.Color = preset.color
        end
    end)
end

-- ============================================================
-- TAB: SETTINGS
-- ============================================================
local pset = Panels["SETTINGS"]
MakeSectionLabel(pset, "── SETTINGS ──", 0)

MakeToggle(pset, "DARK THEME", 1, function(state)
    MainFrame.BackgroundColor3 = state and Color3.fromRGB(10,12,18) or Color3.fromRGB(18,20,28)
end)

MakeButton(pset, "RELOAD CHARACTER", 2, function() LocalPlayer:LoadCharacter() end)

MakeButton(pset, "RESET GUI POSITION", 3, function()
    MainFrame.Position = UDim2.new(0.5, -240, 0.5, -170)
end)

MakeButton(pset, "REMOVE OVERHEAD TITLE", 4, function()
    currentTitleIndex = 1
    RemoveTitle()
    if previewLbl then
        previewLbl.Text = "No title active"
        previewLbl.TextColor3 = Color3.fromRGB(100, 110, 140)
        previewStroke.Color = Color3.fromRGB(40, 45, 60)
    end
    for _, entry in ipairs(allTitleStrokes) do
        TweenService:Create(entry.stroke, TweenInfo.new(0.15), {Thickness = 0}):Play()
    end
end)

MakeSectionLabel(pset, "── ABOUT ──", 5)

local aboutLbl = Instance.new("TextLabel")
aboutLbl.Size = UDim2.new(1, 0, 0, 60)
aboutLbl.BackgroundTransparency = 1
aboutLbl.Text = "iDyxe 8.5\nMade for Roblox\ngithub.com/iDyxe"
aboutLbl.TextColor3 = Color3.fromRGB(100, 110, 140)
aboutLbl.TextSize = 11
aboutLbl.Font = Enum.Font.Gotham
aboutLbl.LayoutOrder = 6
aboutLbl.Parent = pset

-- ============================================================
-- FITUR TAMBAHAN: HAPUS TANGGA & TOPI HITAM
-- ============================================================

-- HAPUS TANGGA DI ALL MAP (tambahkan di tab SERVER)
MakeButton(ps, "🪜 HAPUS SEMUA TANGGA", 9, function()
    local count = 0
    for _, obj in pairs(workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if obj:IsA("BasePart") or obj:IsA("Model") or obj:IsA("UnionOperation") then
            if name:find("ladder") or name:find("tangga") or name:find("stair") or name:find("step") then
                obj:Destroy()
                count = count + 1
            end
        end
    end
    game:GetService("Chat"):Chat(Character.Head, "🪜 Hapus " .. count .. " tangga!", Enum.ChatColor.Green)
end)

MakeButton(ps, "🪜 HAPUS TANGGA (MESH)", 10, function()
    local count = 0
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("SpecialMesh") or obj:IsA("MeshPart") then
            local name = obj.Name:lower()
            if name:find("ladder") or name:find("tangga") or name:find("stair") then
                local parent = obj.Parent
                if parent then parent:Destroy() count = count + 1 end
            end
        end
    end
    game:GetService("Chat"):Chat(Character.Head, "🗑️ Hapus " .. count .. " mesh tangga!", Enum.ChatColor.Blue)
end)

-- TOPI BESAR (BLACKSCREEN ke orang lain)
MakeButton(pc, "🎩 GIANT HAT BLACKSCREEN", 7, function()
    local head = Character:FindFirstChild("Head")
    if not head then return end

    -- Buat part besar di atas kepala
    local hat = Instance.new("Part")
    hat.Name = "GiantHat"
    hat.Size = Vector3.new(60, 0.5, 60)  -- sangat lebar
    hat.BrickColor = BrickColor.new("Really black")
    hat.Material = Enum.Material.SmoothPlastic
    hat.CanCollide = false
    hat.Anchored = false
    hat.CastShadow = true
    hat.Parent = workspace

    -- Weld ke head supaya ikut bergerak
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = head
    weld.Part1 = hat
    weld.Parent = hat

    -- Posisikan tepat di atas kepala
    hat.CFrame = head.CFrame * CFrame.new(0, 5, 0)

    game:GetService("Chat"):Chat(Character.Head, "🎩 Giant Hat ON!", Enum.ChatColor.Red)
    game:GetService("Debris"):AddItem(hat, 30) -- hilang setelah 30 detik
end)

MakeButton(pc, "🎩 REMOVE GIANT HAT", 8, function()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj.Name == "GiantHat" then obj:Destroy() end
    end
    game:GetService("Chat"):Chat(Character.Head, "🎩 Hat Removed!", Enum.ChatColor.Green)
end)

-- ============================================================
print("✅ iDyxe 8.5 Loaded!")
print("→ Tab TITLE untuk overhead title")
print("→ Tombol [─] untuk minimize")
