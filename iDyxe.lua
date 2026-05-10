-- [[ iDyxe 8.5 HUB - GHOST EDITION ]] --
-- Versi paling ringan, paling kasar, paling anti-blank.

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- ========================================== --
--    GUI BASE (TANPA SCROLLING AGAR TIDAK BLANK)
-- ========================================== --
local iDyxeGui = Instance.new("ScreenGui")
iDyxeGui.Name = "iDyxeGhost"
iDyxeGui.ResetOnSpawn = false

local success, result = pcall(function() return gethui() end)
if success and result then iDyxeGui.Parent = result else iDyxeGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame", iDyxeGui)
MainFrame.Size = UDim2.new(0, 480, 0, 320)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Sidebar (Fixed)
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 130, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "iDyxe 8.5"
Title.TextColor3 = Color3.fromRGB(100, 150, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

-- Tab Container (Hardcoded Layer)
local TabContainer = Instance.new("Frame", MainFrame)
TabContainer.Size = UDim2.new(1, -140, 1, -50)
TabContainer.Position = UDim2.new(0, 140, 0, 50)
TabContainer.BackgroundTransparency = 1
TabContainer.ZIndex = 5

local TabTitle = Instance.new("TextLabel", MainFrame)
TabTitle.Size = UDim2.new(0, 150, 0, 45)
TabTitle.Position = UDim2.new(0, 140, 0, 0)
TabTitle.BackgroundTransparency = 1
TabTitle.Text = "MAIN MENU"
TabTitle.TextColor3 = Color3.fromRGB(120, 120, 130)
TabTitle.Font = Enum.Font.GothamBold
TabTitle.TextSize = 14
TabTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button (Wajib Ada)
local ExitBtn = Instance.new("TextButton", MainFrame)
ExitBtn.Size = UDim2.new(0, 25, 0, 25)
ExitBtn.Position = UDim2.new(1, -35, 0, 10)
ExitBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
ExitBtn.Text = "X"
ExitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitBtn.Font = Enum.Font.GothamBold
ExitBtn.ZIndex = 10
Instance.new("UICorner", ExitBtn).CornerRadius = UDim.new(0, 4)
ExitBtn.MouseButton1Click:Connect(function() iDyxeGui:Destroy() end)

-- ========================================== --
--          TAB SYSTEM (MANUAL RENDER)         --
-- ========================================== --
local Tabs = {}
local TabButtons = {}

local function createTab(name)
    local tab = Instance.new("Frame", TabContainer)
    tab.Size = UDim2.size(1, 0, 1, 0)
    tab.BackgroundTransparency = 1
    tab.Visible = false
    tab.ZIndex = 6
    
    local layout = Instance.new("UIListLayout", tab)
    layout.Padding = UDim.new(0, 5)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    Tabs[name] = tab
    return tab
end

local function switchTab(name)
    for tName, tFrame in pairs(Tabs) do tFrame.Visible = (tName == name) end
    TabTitle.Text = string.upper(name)
end

local function createSidebarBtn(name, y)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0.85, 0, 0, 30)
    btn.Position = UDim2.new(0.075, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(25, 27, 35)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(150, 150, 160)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.ZIndex = 7
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function() switchTab(name) end)
end

local function createBtn(tab, text)
    local b = Instance.new("TextButton", tab)
    b.Size = UDim2.new(0.95, 0, 0, 32)
    b.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.ZIndex = 8
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
end

-- ========================================== --
--          EKSEKUSI PENYUSUNAN TAB           --
-- ========================================== --

-- Tab Utama
local t_iDyxe = createTab("iDyxe")
createSidebarBtn("iDyxe", 50)
createBtn(t_iDyxe, "ANTI FLING")
createBtn(t_iDyxe, "TOUCH FLING")
createBtn(t_iDyxe, "GOD MODE")
createBtn(t_iDyxe, "FLY V1")
createBtn(t_iDyxe, "FLY V2")
createBtn(t_iDyxe, "NO CLIP")

-- Tab Universal
local t_Universal = createTab("Universal")
createSidebarBtn("Universal", 85)
createBtn(t_Universal, "iDyxe INJECTION")
createBtn(t_Universal, "LAG SERVER")
createBtn(t_Universal, "SPAM CHAT")
createBtn(t_Universal, "ESP PLAYER")

-- Tab Chaotic
local t_Chaotic = createTab("Chaotic")
createSidebarBtn("Chaotic", 120)
createBtn(t_Chaotic, "FLING ALL")
createBtn(t_Chaotic, "BRING OTHERS")

-- Tab Server
local t_Server = createTab("Server")
createSidebarBtn("Server", 155)
createBtn(t_Server, "FPS BOOSTER")
createBtn(t_Server, "ULTRA GRAPHICS")
createBtn(t_Server, "SKY CHANGER")

switchTab("iDyxe")
print("iDyxe Hub Loaded Successfully!")
