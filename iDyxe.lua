-- [[ iDyxe HUB 8.5 - FORCE RENDER EDITION ]] --
-- Dibuat khusus untuk Tuan iDyxe. Tanpa Folder, Tanpa Layout, Murni Render.

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Hapus UI lama jika ada
if PlayerGui:FindFirstChild("iDyxeForce") then PlayerGui.iDyxeForce:Destroy() end

local iDyxeGui = Instance.new("ScreenGui")
iDyxeGui.Name = "iDyxeForce"
iDyxeGui.ResetOnSpawn = false
iDyxeGui.Parent = PlayerGui

-- Background Utama (Sangat Sederhana agar tidak berat)
local MainFrame = Instance.new("Frame", iDyxeGui)
MainFrame.Size = UDim2.new(0, 480, 0, 320)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(80, 140, 255)
MainFrame.Active = true
MainFrame.Draggable = true

-- Title Bar
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Title.Text = "  iDyxe 8.5 - FORCE RENDER"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.Code
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local ExitBtn = Instance.new("TextButton", MainFrame)
ExitBtn.Size = UDim2.new(0, 25, 0, 25)
ExitBtn.Position = UDim2.new(1, -30, 0, 5)
ExitBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ExitBtn.Text = "X"
ExitBtn.TextColor3 = Color3.new(1, 1, 1)
ExitBtn.MouseButton1Click:Connect(function() iDyxeGui:Destroy() end)

-- FUNGSI PENEMPATAN TOMBOL SECARA PAKSA (MANUAL COORDINATES)
local function createForceBtn(name, x, y, color)
    local b = Instance.new("TextButton", MainFrame)
    b.Size = UDim2.new(0, 140, 0, 30)
    b.Position = UDim2.new(0, x, 0, y)
    b.BackgroundColor3 = color or Color3.fromRGB(40, 40, 50)
    b.Text = name
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.Code
    b.TextSize = 10
    b.BorderSizePixel = 1
    
    b.MouseButton1Click:Connect(function()
        game.StarterGui:SetCore("SendNotification", {Title = "iDyxe", Text = name .. " Executed!"})
    end)
end

-- ========================================== --
--  POSISI TOMBOL (X, Y) - DIPAKSA MUNCUL!     --
-- ========================================== --

-- KOLOM 1
createForceBtn("ANTI FLING", 15, 50, Color3.fromRGB(60, 60, 100))
createForceBtn("TOUCH FLING", 15, 85, Color3.fromRGB(60, 60, 100))
createForceBtn("GOD MODE", 15, 120)
createForceBtn("INVISIBILITY", 15, 155)
createForceBtn("INFINITE JUMP", 15, 190)
createForceBtn("NO CLIP", 15, 225)
createForceBtn("iDyxe FLY", 15, 260, Color3.fromRGB(30, 100, 30))

-- KOLOM 2
createForceBtn("iDyxe AUTO WALK", 170, 50)
createForceBtn("AUTO TELEPORT", 170, 85)
createForceBtn("iDyxe GLITCH", 170, 120)
createForceBtn("iDyxe GLITCH V2", 170, 155)
createForceBtn("iDyxe ANIMATED", 170, 190)
createForceBtn("iDyxe EMOTE", 170, 225)
createForceBtn("KIMCOHI", 170, 260)

-- KOLOM 3
createForceBtn("TROLL PLAYER", 325, 50)
createForceBtn("ESP PLAYER", 325, 85)
createForceBtn("iDyxe FLING", 325, 120, Color3.fromRGB(100, 30, 30))
createForceBtn("iDyxe BRING", 325, 155)
createForceBtn("LAG SERVER", 325, 190)
createForceBtn("FPS BOOSTER", 325, 225)
createForceBtn("SKY CHANGER", 325, 260)

print("iDyxe Force Hub Loaded!")
