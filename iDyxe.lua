-- iDyxe 8.5 GUI Script
-- Converted from Siexther 8.5 -> iDyxe by request
-- Place this script in your executor

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")
local Camera = workspace.CurrentCamera

-- ============================================================
-- MAIN GUI
-- ============================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "iDyxeGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 480, 0, 340)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Blue border stroke
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(66, 135, 245)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 36)
TitleBar.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "iDYXE 8.5"
TitleLabel.TextColor3 = Color3.fromRGB(66, 135, 245)
TitleLabel.TextSize = 15
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.Parent = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0, 4)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Divider
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, 0, 0, 1)
Divider.Position = UDim2.new(0, 0, 0, 36)
Divider.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame

-- Left Sidebar (Category Nav)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 110, 1, -37)
Sidebar.Position = UDim2.new(0, 0, 0, 37)
Sidebar.BackgroundColor3 = Color3.fromRGB(14, 16, 22)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 8)
SidebarCorner.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Padding = UDim.new(0, 4)
SidebarList.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 8)
SidebarPadding.PaddingLeft = UDim.new(0, 6)
SidebarPadding.PaddingRight = UDim.new(0, 6)
SidebarPadding.Parent = Sidebar

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -116, 1, -44)
ContentArea.Position = UDim2.new(0, 114, 0, 40)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- ============================================================
-- HELPER FUNCTIONS
-- ============================================================

local function MakeNavBtn(text, order)
    local btn = Instance.new("TextButton")
    btn.Name = text
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(22, 25, 35)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(180, 185, 200)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.LayoutOrder = order
    btn.Parent = Sidebar

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn

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

    local rc = Instance.new("UICorner")
    rc.CornerRadius = UDim.new(0, 6)
    rc.Parent = row

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

    local tbg_c = Instance.new("UICorner")
    tbg_c.CornerRadius = UDim.new(1, 0)
    tbg_c.Parent = toggleBg

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(0, 2, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(130, 135, 155)
    knob.BorderSizePixel = 0
    knob.Parent = toggleBg

    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(1, 0)
    kc.Parent = knob

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

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 6)
    bc.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(66, 135, 245)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(26, 30, 44)}):Play()
    end)

    if callback then
        btn.MouseButton1Click:Connect(callback)
    end

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
-- PANELS
-- ============================================================

local Panels = {}
local NavBtns = {}
local Categories = {"IDYXE", "UNIVERSAL", "CHAOTIC", "SERVER", "SETTINGS"}

for i, cat in ipairs(Categories) do
    local panel = MakePanel(cat)
    Panels[cat] = panel
    local btn = MakeNavBtn(cat, i)
    NavBtns[cat] = btn
end

-- Show first panel
Panels["IDYXE"].Visible = true

-- Nav switching logic
local function SelectTab(name)
    for k, p in pairs(Panels) do
        p.Visible = false
    end
    for k, b in pairs(NavBtns) do
        TweenService:Create(b, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(22, 25, 35),
            TextColor3 = Color3.fromRGB(180, 185, 200)
        }):Play()
    end
    Panels[name].Visible = true
    TweenService:Create(NavBtns[name], TweenInfo.new(0.1), {
        BackgroundColor3 = Color3.fromRGB(66, 135, 245),
        TextColor3 = Color3.new(1,1,1)
    }):Play()
end

for k, btn in pairs(NavBtns) do
    local name = k
    btn.MouseButton1Click:Connect(function()
        SelectTab(name)
    end)
end

SelectTab("IDYXE")

-- ============================================================
-- VARIABLES FOR FEATURES
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
-- TAB: IDYXE (SXTHR equivalent)
-- ============================================================
local p = Panels["IDYXE"]
MakeSectionLabel(p, "iDYXE", 0)

-- ANTI FLING
MakeToggle(p, "ANTI FLING", 1, function(state)
    antiFlingActive = state
    if state then
        local hum = Character:FindFirstChild("Humanoid")
        if hum then hum.AutoRotate = false end
    else
        local hum = Character:FindFirstChild("Humanoid")
        if hum then hum.AutoRotate = true end
    end
end)

-- TOUCH FLING
MakeToggle(p, "TOUCH FLING", 2, function(state)
    -- Placeholder: touch fling logic
end)

-- INVISIBILITY
MakeToggle(p, "INVISIBILITY", 3, function(state)
    invisibilityActive = state
    for _, part in pairs(Character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = state and 1 or 0
        end
    end
end)

-- GOD MODE
MakeToggle(p, "GOD MODE", 4, function(state)
    godModeActive = state
    local hum = Character:FindFirstChild("Humanoid")
    if hum then
        if state then
            hum.MaxHealth = math.huge
            hum.Health = math.huge
        else
            hum.MaxHealth = 100
            hum.Health = 100
        end
    end
end)

-- INFINITE JUMP
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

-- NO CLIP
MakeToggle(p, "NO CLIP", 6, function(state)
    noclipActive = state
    if state then
        noclipConnection = RunService.Stepped:Connect(function()
            if noclipActive then
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() end
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)

MakeSectionLabel(p, "── LOCOMOTION ──", 7)

-- AUTO WALK
MakeButton(p, "iDYXE AUTO WALK", 8, function()
    local hum = Character:FindFirstChild("Humanoid")
    if hum then hum.WalkToPoint = RootPart.Position + RootPart.CFrame.LookVector * 9999 end
end)

-- AUTO TELEPORT
MakeButton(p, "iDYXE AUTO TELEPORT", 9, function()
    -- cycles through random spawn locations
    local spawns = workspace:FindFirstChild("SpawnLocation")
    if spawns then
        RootPart.CFrame = spawns.CFrame + Vector3.new(0, 5, 0)
    end
end)

-- FLY
MakeButton(p, "iDYXE FLY (TOGGLE)", 10, function()
    flyActive = not flyActive
    if flyActive then
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.zero
        bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        bv.Parent = RootPart

        local bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
        bg.D = 100
        bg.Parent = RootPart

        flyConnection = RunService.Heartbeat:Connect(function()
            if not flyActive then
                bv:Destroy()
                bg:Destroy()
                flyConnection:Disconnect()
                return
            end
            local cf = Camera.CFrame
            local dir = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
            bv.Velocity = dir * flySpeed
            bg.CFrame = cf
        end)
    else
        if flyConnection then flyConnection:Disconnect() end
    end
end)

-- FLY V2 (Speed fly)
MakeButton(p, "iDYXE FLY V2 (FAST)", 11, function()
    flySpeed = flySpeed == 50 and 150 or 50
end)

-- GLITCH
MakeButton(p, "iDYXE GLITCH", 12, function()
    for i = 1, 10 do
        task.wait(0.05)
        RootPart.CFrame = RootPart.CFrame * CFrame.new(math.random(-5,5), math.random(-2,2), math.random(-5,5))
    end
end)

-- GLITCH V2
MakeButton(p, "iDYXE GLITCH V2", 13, function()
    for i = 1, 20 do
        task.wait(0.02)
        RootPart.CFrame = CFrame.new(RootPart.Position + Vector3.new(math.random(-10,10), 0, math.random(-10,10)))
    end
end)

-- ANIMATED (Rainbow name)
MakeButton(p, "iDYXE ANIMATED", 14, function()
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = RootPart

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "iDyxe"
    lbl.TextScaled = true
    lbl.Font = Enum.Font.GothamBold
    lbl.Parent = billboard

    local hue = 0
    local conn
    conn = RunService.Heartbeat:Connect(function()
        hue = (hue + 0.01) % 1
        lbl.TextColor3 = Color3.fromHSV(hue, 1, 1)
    end)

    task.delay(10, function()
        conn:Disconnect()
        billboard:Destroy()
    end)
end)

-- EMOTE
MakeButton(p, "iDYXE EMOTE", 15, function()
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://507771019"
    local hum = Character:FindFirstChild("Humanoid")
    if hum then
        local animTrack = hum.Animator:LoadAnimation(animation)
        animTrack:Play()
    end
end)

-- ============================================================
-- TAB: UNIVERSAL
-- ============================================================
local pu = Panels["UNIVERSAL"]
MakeSectionLabel(pu, "UNIVERSAL", 0)

MakeButton(pu, "iDYXE INJECTION", 1, function()
    -- Placeholder: injection script
    warn("iDyxe Injection activated")
end)

MakeButton(pu, "iDYXE KIMCOHI", 2, function()
    -- Fast spin
    local conn
    local spinning = true
    conn = RunService.Heartbeat:Connect(function()
        if spinning then
            RootPart.CFrame = RootPart.CFrame * CFrame.Angles(0, math.rad(15), 0)
        else
            conn:Disconnect()
        end
    end)
    task.delay(3, function() spinning = false end)
end)

MakeButton(pu, "iDYXE LAG SERVER", 3, function()
    -- Create many parts briefly
    for i = 1, 50 do
        local p2 = Instance.new("Part")
        p2.Parent = workspace
        p2.Position = RootPart.Position
        game:GetService("Debris"):AddItem(p2, 1)
    end
end)

MakeButton(pu, "iDYXE SPAM", 4, function()
    for i = 1, 10 do
        task.wait(0.1)
        game:GetService("Chat"):Chat(Character.Head, "iDyxe 8.5 | Best Script!", Enum.ChatColor.Blue)
    end
end)

MakeButton(pu, "iDYXE CHARME", 5, function()
    -- Chat charm message
    game:GetService("Chat"):Chat(Character.Head, "✨ iDyxe ✨", Enum.ChatColor.Red)
end)

MakeButton(pu, "iDYXE TALL MAN", 6, function()
    local hum = Character:FindFirstChild("Humanoid")
    if hum then
        hum.HipHeight = hum.HipHeight == 0 and 10 or 0
    end
end)

MakeButton(pu, "TROLL PLAYER", 7, function()
    -- Fling nearest player
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local targetRoot = plr.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = (targetRoot.Position - RootPart.Position).Unit * 200 + Vector3.new(0, 100, 0)
                bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                bv.Parent = targetRoot
                game:GetService("Debris"):AddItem(bv, 0.2)
            end
        end
    end
end)

MakeButton(pu, "ESP PLAYER", 8, function()
    espActive = not espActive
    -- Remove old ESPs
    for _, obj in pairs(espObjects) do
        if obj then obj:Destroy() end
    end
    espObjects = {}

    if espActive then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local root = plr.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Size = UDim2.new(0, 100, 0, 30)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true
                    billboard.Parent = root

                    local lbl = Instance.new("TextLabel")
                    lbl.Size = UDim2.new(1,0,1,0)
                    lbl.BackgroundTransparency = 1
                    lbl.Text = plr.Name
                    lbl.TextColor3 = Color3.fromRGB(255, 80, 80)
                    lbl.TextScaled = true
                    lbl.Font = Enum.Font.GothamBold
                    lbl.Parent = billboard

                    table.insert(espObjects, billboard)
                end
            end
        end
    end
end)

MakeButton(pu, "FAKE DONATE", 9, function()
    game:GetService("Chat"):Chat(Character.Head, "I just donated 1000 Robux to " .. LocalPlayer.Name .. "!", Enum.ChatColor.Green)
end)

MakeButton(pu, "TRANSLATE", 10, function()
    game:GetService("Chat"):Chat(Character.Head, "iDyxe Script - Best Roblox Script 2025!", Enum.ChatColor.Blue)
end)

MakeSectionLabel(pu, "── iDYXE AURA ──", 11)

MakeButton(pu, "iDYXE AURA", 12, function()
    -- Normal aura
    local sel = Instance.new("SelectionBox")
    sel.Color3 = Color3.fromRGB(66, 135, 245)
    sel.SurfaceColor3 = Color3.fromRGB(66, 135, 245)
    sel.SurfaceTransparency = 0.7
    sel.Adornee = RootPart
    sel.Parent = workspace
    game:GetService("Debris"):AddItem(sel, 5)
end)

MakeButton(pu, "iDYXE AURA FAST", 13, function()
    -- Fast flashing aura
    local sel = Instance.new("SelectionBox")
    sel.Adornee = RootPart
    sel.Parent = workspace

    local conn2
    local colors = {
        Color3.fromRGB(255,0,0),
        Color3.fromRGB(0,255,0),
        Color3.fromRGB(0,0,255),
        Color3.fromRGB(255,255,0),
        Color3.fromRGB(255,0,255),
    }
    local idx = 1
    conn2 = RunService.Heartbeat:Connect(function()
        idx = (idx % #colors) + 1
        sel.Color3 = colors[idx]
        sel.SurfaceColor3 = colors[idx]
        sel.SurfaceTransparency = 0.7
    end)
    task.delay(5, function()
        conn2:Disconnect()
        sel:Destroy()
    end)
end)

-- ============================================================
-- TAB: CHAOTIC
-- ============================================================
local pc = Panels["CHAOTIC"]
MakeSectionLabel(pc, "CHAOTIC", 0)

MakeButton(pc, "iDYXE FLING", 1, function()
    -- Fling self outward
    local bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(math.random(-200,200), 300, math.random(-200,200))
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.Parent = RootPart
    game:GetService("Debris"):AddItem(bv, 0.5)
end)

MakeButton(pc, "iDYXE BROKEN", 2, function()
    -- Break animation
    local hum = Character:FindFirstChild("Humanoid")
    if hum then hum:ChangeState(Enum.HumanoidStateType.Dead) end
    task.wait(1)
    LocalPlayer:LoadCharacter()
end)

MakeButton(pc, "iDYXE CHAOTIC", 3, function()
    for i = 1, 15 do
        task.wait(0.05)
        RootPart.CFrame = CFrame.new(
            RootPart.Position.X + math.random(-20,20),
            RootPart.Position.Y + math.random(0,5),
            RootPart.Position.Z + math.random(-20,20)
        )
    end
end)

MakeButton(pc, "iDYXE PART CONTROLLER", 4, function()
    local part = Instance.new("Part")
    part.Size = Vector3.new(4,4,4)
    part.Position = RootPart.Position + Vector3.new(0,5,0)
    part.BrickColor = BrickColor.new("Bright blue")
    part.Material = Enum.Material.Neon
    part.Parent = workspace
    game:GetService("Debris"):AddItem(part, 5)
end)

MakeButton(pc, "iDYXE BRING", 5, function()
    -- Bring nearest player to you
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = RootPart.CFrame * CFrame.new(3, 0, 0)
                break
            end
        end
    end
end)

MakeButton(pc, "iDYXE BRING V2", 6, function()
    -- Bring ALL players
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = RootPart.CFrame * CFrame.new(math.random(-5,5), 0, math.random(-5,5))
            end
        end
    end
end)

-- ============================================================
-- TAB: SERVER
-- ============================================================
local ps = Panels["SERVER"]
MakeSectionLabel(ps, "SERVER", 0)

MakeButton(ps, "ANTI LAG & FPS BOOSTER", 1, function()
    -- Remove decals and textures
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("SpecialMesh") then
            obj:Destroy()
        end
    end
    game:GetService("Lighting").GlobalShadows = false
    game:GetService("Lighting").FogEnd = 9e9
end)

MakeButton(ps, "ULTRA GRAPHICS", 2, function()
    game:GetService("Lighting").GlobalShadows = true
    game:GetService("Lighting").Brightness = 3
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            for _, part in pairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Material = Enum.Material.SmoothPlastic
                end
            end
        end
    end
end)

MakeButton(ps, "FREECAM", 3, function()
    -- Toggle freecam
    local cam = workspace.CurrentCamera
    cam.CameraType = cam.CameraType == Enum.CameraType.Custom and Enum.CameraType.Scriptable or Enum.CameraType.Custom
end)

MakeButton(ps, "SPECTATE PLAYER", 4, function()
    -- Spectate first other player
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local cam = workspace.CurrentCamera
                cam.CameraType = Enum.CameraType.Scriptable
                cam.CFrame = CFrame.new(root.Position + Vector3.new(0,5,-10), root.Position)
                break
            end
        end
    end
end)

MakeButton(ps, "TELEPORT PLAYER", 5, function()
    -- Teleport to first other player
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then
                RootPart.CFrame = root.CFrame * CFrame.new(3, 0, 0)
                break
            end
        end
    end
end)

MakeButton(ps, "ALL SERVER TELEPORT", 6, function()
    -- Teleport all players to you
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = RootPart.CFrame * CFrame.new(math.random(-8,8), 0, math.random(-8,8))
            end
        end
    end
end)

MakeButton(ps, "SKY CHANGER", 7, function()
    local sky = game:GetService("Lighting"):FindFirstChildOfClass("Sky")
    if sky then
        sky:Destroy()
    else
        local newSky = Instance.new("Sky")
        newSky.SkyboxBk = "rbxassetid://159454286"
        newSky.SkyboxDn = "rbxassetid://159454296"
        newSky.SkyboxFt = "rbxassetid://159454288"
        newSky.SkyboxLf = "rbxassetid://159454292"
        newSky.SkyboxRt = "rbxassetid://159454290"
        newSky.SkyboxUp = "rbxassetid://159454300"
        newSky.Parent = game:GetService("Lighting")
    end
end)

MakeButton(ps, "SCAN AUDIO", 8, function()
    local sounds = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Sound") and obj.Playing then
            table.insert(sounds, obj.Name .. " [" .. obj.SoundId .. "]")
        end
    end
    if #sounds > 0 then
        game:GetService("Chat"):Chat(Character.Head, "Sounds: " .. table.concat(sounds, ", "), Enum.ChatColor.Blue)
    else
        game:GetService("Chat"):Chat(Character.Head, "No sounds playing!", Enum.ChatColor.Red)
    end
end)

-- ============================================================
-- TAB: SETTINGS
-- ============================================================
local pset = Panels["SETTINGS"]
MakeSectionLabel(pset, "SETTINGS", 0)

MakeToggle(pset, "DARK THEME", 1, function(state)
    MainFrame.BackgroundColor3 = state and Color3.fromRGB(10, 12, 18) or Color3.fromRGB(18, 20, 28)
end)

MakeButton(pset, "RELOAD CHARACTER", 2, function()
    LocalPlayer:LoadCharacter()
end)

MakeButton(pset, "RESET GUI POSITION", 3, function()
    MainFrame.Position = UDim2.new(0.5, -240, 0.5, -170)
end)

MakeButton(pset, "HIDE / SHOW GUI", 4, function()
    ContentArea.Visible = not ContentArea.Visible
    Sidebar.Visible = not Sidebar.Visible
    MainFrame.Size = ContentArea.Visible and UDim2.new(0, 480, 0, 340) or UDim2.new(0, 480, 0, 40)
end)

MakeSectionLabel(pset, "── ABOUT ──", 5)

local aboutLbl = Instance.new("TextLabel")
aboutLbl.Size = UDim2.new(1, 0, 0, 60)
aboutLbl.BackgroundTransparency = 1
aboutLbl.Text = "iDyxe 8.5\nMade for Roblox\nAll features unlocked"
aboutLbl.TextColor3 = Color3.fromRGB(100, 110, 140)
aboutLbl.TextSize = 11
aboutLbl.Font = Enum.Font.Gotham
aboutLbl.LayoutOrder = 6
aboutLbl.Parent = pset

-- ============================================================
-- CHARACTER RESPAWN HANDLING
-- ============================================================
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    RootPart = newChar:WaitForChild("HumanoidRootPart")
    Humanoid = newChar:WaitForChild("Humanoid")

    -- Reapply active toggles
    if godModeActive then
        Humanoid.MaxHealth = math.huge
        Humanoid.Health = math.huge
    end
end)

-- ============================================================
print("✅ iDyxe 8.5 Loaded Successfully!")
print("Script by iDyxe | GitHub")
