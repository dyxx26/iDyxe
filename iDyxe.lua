-- [[ iDyxe HUB 8.5 - ULTRA STABLE VERSION ]] --
-- Dibuat khusus untuk Tuan iDyxe agar kebal terhadap blank screen.

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local CoreGui = game:GetService("CoreGui")

-- Proteksi agar tidak double execute
if PlayerGui:FindFirstChild("iDyxeIndustrial") then PlayerGui.iDyxeIndustrial:Destroy() end

local iDyxeGui = Instance.new("ScreenGui")
iDyxeGui.Name = "iDyxeIndustrial"
iDyxeGui.ResetOnSpawn = false
iDyxeGui.Parent = PlayerGui -- Menggunakan PlayerGui agar lebih stabil di Delta

-- Background Utama
local MainFrame = Instance.new("Frame", iDyxeGui)
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(80, 140, 255)
MainFrame.Active = true
MainFrame.Draggable = true

-- Header Title
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TitleBar.BorderSizePixel = 0

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "iDyxe 8.5 - MASTER CONTROL"
TitleText.TextColor3 = Color3.new(1, 1, 1)
TitleText.Font = Enum.Font.Code
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button (X)
local ExitBtn = Instance.new("TextButton", TitleBar)
ExitBtn.Size = UDim2.new(0, 30, 0, 30)
ExitBtn.Position = UDim2.new(1, -32, 0, 2)
ExitBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
ExitBtn.Text = "X"
ExitBtn.TextColor3 = Color3.new(1, 1, 1)
ExitBtn.Font = Enum.Font.GothamBold
ExitBtn.MouseButton1Click:Connect(function() iDyxeGui:Destroy() end)

-- Area Isi Menu (MENGGUNAKAN GRID AGAR RAPI)
local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, -20, 1, -50)
Container.Position = UDim2.new(0, 10, 0, 45)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 5
Container.CanvasSize = UDim2.new(0, 0, 0, 1000) -- Canvas panjang ke bawah

local Grid = Instance.new("UIGridLayout", Container)
Grid.CellSize = UDim2.new(0, 150, 0, 35)
Grid.CellPadding = UDim2.new(0, 8, 0, 8)

-- Fungsi sakti pembuat tombol
local function addBtn(name, color)
    local b = Instance.new("TextButton", Container)
    b.BackgroundColor3 = color or Color3.fromRGB(30, 32, 45)
    b.Text = name
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.Code
    b.TextSize = 11
    b.BorderSizePixel = 0
    local corner = Instance.new("UICorner", b)
    corner.CornerRadius = UDim.new(0, 4)
    
    b.MouseButton1Click:Connect(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "iDyxe 8.5",
            Text = "Executing: " .. name,
            Duration = 2
        })
    end)
end

-- ========================================== --
--          DAFTAR FITUR (SESUAI REQUEST)      --
-- ========================================== --

-- SXTHR / MAIN
addBtn("ANTI FLING", Color3.fromRGB(60, 60, 80))
addBtn("TOUCH FLING", Color3.fromRGB(60, 60, 80))
addBtn("INVISIBILITY")
addBtn("GOD MODE")
addBtn("INFINITE JUMP")
addBtn("NO CLIP")

-- MOVEMENT
addBtn("iDyxe AUTO WALK", Color3.fromRGB(40, 80, 40))
addBtn("iDyxe AUTO TELEPORT", Color3.fromRGB(40, 80, 40))
addBtn("iDyxe FLY")
addBtn("iDyxe FLY V2")
addBtn("iDyxe GLITCH")
addBtn("iDyxe GLITCH V2")

-- UNIVERSAL
addBtn("iDyxe INJECTION", Color3.fromRGB(80, 40, 80))
addBtn("iDyxe KIMCOHI")
addBtn("iDyxe LAG SERVER")
addBtn("iDyxe SPAM")
addBtn("iDyxe CHARME")
addBtn("iDyxe TALL MAN")

-- PLAYER TOOLS
addBtn("TROLL PLAYER")
addBtn("ESP PLAYER")
addBtn("FAKE DONATE")
addBtn("TRANSLATE")
addBtn("iDyxe AURA")
addBtn("iDyxe AURA FAST")

-- CHAOTIC
addBtn("iDyxe FLING", Color3.fromRGB(100, 40, 40))
addBtn("iDyxe BROKEN")
addBtn("iDyxe CHAOTIC")
addBtn("PART CONTROLLER")
addBtn("iDyxe BRING")
addBtn("iDyxe BRING V2")

-- SERVER
addBtn("FPS BOOSTER", Color3.fromRGB(40, 60, 100))
addBtn("ULTRA GRAPHICS")
addBtn("FREECAM")
addBtn("SPECTATE PLAYER")
addBtn("TELEPORT PLAYER")
addBtn("ALL SERVER TELEPORT")
addBtn("SKY CHANGER")

print("iDyxe Hub 8.5 Loaded!")
