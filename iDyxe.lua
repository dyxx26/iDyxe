-- [[ iDyxe 8.5 HUB - THE ABSOLUTE ULTIMATE ]] --
-- Cetak biru kehancuran total, direkayasa ulang untuk Tuan iDyxe.

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Toggles = {}

-- ========================================== --
--              GUI CREATION                  --
-- ========================================== --
local iDyxeGui = Instance.new("ScreenGui")
iDyxeGui.Name = "iDyxeHub8_5_Ultimate"
iDyxeGui.ResetOnSpawn = false

local success, result = pcall(function() return gethui() end)
if success and result then iDyxeGui.Parent = result else iDyxeGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Main Background
local MainFrame = Instance.new("Frame", iDyxeGui)
MainFrame.Size = UDim2.new(0, 480, 0, 320)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Sidebar
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 130, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local SidebarCover = Instance.new("Frame", Sidebar)
SidebarCover.Size = UDim2.new(0, 10, 1, 0)
SidebarCover.Position = UDim2.new(1, -10, 0, 0)
SidebarCover.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
SidebarCover.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "iDyxe 8.5"
Title.TextColor3 = Color3.fromRGB(100, 150, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 16

-- Tab Container
local TabContainer = Instance.new("Frame", MainFrame)
TabContainer.Size = UDim2.new(1, -140, 1, -50)
TabContainer.Position = UDim2.new(0, 140, 0, 50)
TabContainer.BackgroundTransparency = 1

local TabTitle = Instance.new("TextLabel", MainFrame)
TabTitle.Size = UDim2.new(1, -140, 0, 45)
TabTitle.Position = UDim2.new(0, 140, 0, 0)
TabTitle.BackgroundTransparency = 1
TabTitle.Text = "I D Y X E"
TabTitle.TextColor3 = Color3.fromRGB(120, 120, 130)
TabTitle.Font = Enum.Font.GothamBold
TabTitle.TextSize = 12
TabTitle.TextTracking = 2
TabTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local ExitBtn = Instance.new("TextButton", MainFrame)
ExitBtn.Size = UDim2.new(0, 25, 0, 25)
ExitBtn.Position = UDim2.new(1, -35, 0, 10)
ExitBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
ExitBtn.Text = "X"
ExitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", ExitBtn).CornerRadius = UDim.new(0, 4)
ExitBtn.MouseButton1Click:Connect(function() iDyxeGui:Destroy() end)

-- ========================================== --
--             UI LOGIC & BUILDER             --
-- ========================================== --
local Tabs = {}
local TabButtons = {}

local function createTab(name)
    local tab = Instance.new("ScrollingFrame", TabContainer)
    tab.Size = UDim2.new(1, 0, 1, 0)
    tab.BackgroundTransparency = 1
    tab.ScrollBarThickness = 2
    tab.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
    tab.Visible = false
    
    local layout = Instance.new("UIListLayout", tab)
    layout.Padding = UDim.new(0, 8)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    
    -- Auto-resize canvas
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tab.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end)
    
    Tabs[name] = tab
    return tab
end

local function switchTab(name)
    for tabName, tab in pairs(Tabs) do tab.Visible = (tabName == name) end
    for btnName, btn in pairs(TabButtons) do
        if btnName == name then
            btn.BackgroundColor3 = Color3.fromRGB(80, 140, 255)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            btn.BackgroundColor3 = Color3.fromRGB(25, 27, 35)
            btn.TextColor3 = Color3.fromRGB(150, 150, 160)
        end
    end
    TabTitle.Text = string.upper(name)
end

local function createSidebarButton(name, text, yPos)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0.85, 0, 0, 32)
    btn.Position = UDim2.new(0.075, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(25, 27, 35)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(150, 150, 160)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function() switchTab(name) end)
    TabButtons[name] = btn
end

local function notify(text)
    game.StarterGui:SetCore("SendNotification", {Title = "iDyxe 8.5", Text = text, Duration = 2})
end

local function createToggle(tab, text, flagName)
    local frame = Instance.new("Frame", tab)
    frame.Size = UDim2.new(0.95, 0, 0, 36)
    frame.BackgroundColor3 = Color3.fromRGB(25, 27, 35)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(210, 210, 220)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBtn = Instance.new("TextButton", frame)
    toggleBtn.Size = UDim2.new(0, 34, 0, 18)
    toggleBtn.Position = UDim2.new(1, -45, 0.5, -9)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    toggleBtn.Text = ""
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)
    
    local circle = Instance.new("Frame", toggleBtn)
    circle.Size = UDim2.new(0, 14, 0, 14)
    circle.Position = UDim2.new(0, 2, 0.5, -7)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)
    
    Toggles[flagName] = false
    toggleBtn.MouseButton1Click:Connect(function()
        Toggles[flagName] = not Toggles[flagName]
        if Toggles[flagName] then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            circle.BackgroundColor3 = Color3.fromRGB(80, 140, 255)
            circle:TweenPosition(UDim2.new(1, -16, 0.5, -7), "Out", "Quad", 0.15, true)
            notify(text .. " [ON]")
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            circle:TweenPosition(UDim2.new(0, 2, 0.5, -7), "Out", "Quad", 0.15, true)
            notify(text .. " [OFF]")
        end
    end)
end

local function createButton(tab, text)
    local btn = Instance.new("TextButton", tab)
    btn.Size = UDim2.new(0.95, 0, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(25, 27, 35)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(210, 210, 220)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        notify("Mengeksekusi: " .. text)
        -- Tempat logika asli jika Tuan ingin mengembangkannya nanti
    end)
end

local function createDivider(tab, text)
    local frame = Instance.new("Frame", tab)
    frame.Size = UDim2.new(0.95, 0, 0, 20)
    frame.BackgroundTransparency = 1
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "- " .. text .. " -"
    label.TextColor3 = Color3.fromRGB(80, 80, 90)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 10
end

-- ========================================== --
--          MEMBANGUN SELURUH TAB             --
-- ========================================== --

-- 1. TAB: iDyxe (Pengganti SXTHR)
createSidebarButton("iDyxe", "iDyxe", 55)
local t_iDyxe = createTab("iDyxe")
createToggle(t_iDyxe, "ANTI FLING", "AntiFling")
createToggle(t_iDyxe, "TOUCH FLING", "TouchFling")
createToggle(t_iDyxe, "INVISIBILITY", "Invis")
createToggle(t_iDyxe, "GOD MODE", "GodMode")
createToggle(t_iDyxe, "INFINITE JUMP", "InfJump")
createToggle(t_iDyxe, "NO CLIP", "NoClip")
createDivider(t_iDyxe, "SCRIPTS")
createButton(t_iDyxe, "iDyxe AUTO WALK")
createButton(t_iDyxe, "iDyxe AUTO TELEPORT")
createButton(t_iDyxe, "iDyxe FLY")
createButton(t_iDyxe, "iDyxe FLY V2")
createButton(t_iDyxe, "iDyxe GLITCH")
createButton(t_iDyxe, "iDyxe GLITCH V2")
createButton(t_iDyxe, "iDyxe ANIMATED")
createButton(t_iDyxe, "iDyxe EMOTE")

-- 2. TAB: UNIVERSAL
createSidebarButton("Universal", "UNIVERSAL", 95)
local t_Univ = createTab("Universal")
createButton(t_Univ, "iDyxe INJECTION")
createButton(t_Univ, "iDyxe KIMCOHI")
createButton(t_Univ, "iDyxe LAG SERVER")
createButton(t_Univ, "iDyxe SPAM")
createButton(t_Univ, "iDyxe CHARME")
createButton(t_Univ, "iDyxe TALL MAN")
createDivider(t_Univ, "PLAYER TOOLS")
createButton(t_Univ, "TROLL PLAYER")
createButton(t_Univ, "ESP PLAYER")
createButton(t_Univ, "FAKE DONATE")
createButton(t_Univ, "TRANSLATE")
createDivider(t_Univ, "AURA SYSTEM")
createButton(t_Univ, "iDyxe AURA")
createButton(t_Univ, "iDyxe AURA FAST")

-- 3. TAB: CHAOTIC
createSidebarButton("Chaotic", "CHAOTIC", 135)
local t_Chaos = createTab("Chaotic")
createButton(t_Chaos, "iDyxe FLING")
createButton(t_Chaos, "iDyxe BROKEN")
createButton(t_Chaos, "iDyxe CHAOTIC")
createButton(t_Chaos, "iDyxe PART CONTROLLER")
createButton(t_Chaos, "iDyxe BRING")
createButton(t_Chaos, "iDyxe BRING V2")

-- 4. TAB: SERVER
createSidebarButton("Server", "SERVER", 175)
local t_Server = createTab("Server")
createButton(t_Server, "ANTI LAG & FPS BOOSTER")
createButton(t_Server, "ULTRA GRAPHICS")
createButton(t_Server, "FREECAM")
createButton(t_Server, "SPECTATE PLAYER")
createButton(t_Server, "TELEPORT PLAYER")
createButton(t_Server, "ALL SERVER TELEPORT")
createButton(t_Server, "SKY CHANGER")

-- 5. TAB: SETTINGS
createSidebarButton("Settings", "SETTINGS", 215)
local t_Set = createTab("Settings")
createButton(t_Set, "REJOIN SERVER")
createButton(t_Set, "SERVER HOP")
createButton(t_Set, "DESTROY iDyxe HUB")
-- Logika untuk menghancurkan hub dari setting
t_Set:GetChildren()[#t_Set:GetChildren()].MouseButton1Click:Connect(function() iDyxeGui:Destroy() end)

-- Mulai dengan tab iDyxe terbuka
switchTab("iDyxe")

notify("iDyxe 8.5 telah mengambil alih sistem. 👑")
