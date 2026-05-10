-- [[ iDyxe HUB 8.5 - RAGNAROK EDITION ]] --
-- Dibuat khusus untuk Tuan iDyxe. Dominasi fisik total dan nyata.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local function notify(txt)
    game.StarterGui:SetCore("SendNotification", {Title = "iDyxe HUB", Text = txt, Duration = 3})
end

-- ========================================== --
--          LOGIK PENDUKUNG (NETLESS)         --
-- ========================================== --
local function RitualNetless()
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                -- Memberikan Velocity ekstrim agar server melepas kontrol fisika ke Tuan
                part.Velocity = Vector3.new(0, 9e9, 0)
                part.RotVelocity = Vector3.new(0, 9e9, 0)
            end
        end
    end
end

-- ========================================== --
--    GUI BASE (FAILSAFE & ULTRA STABLE)      --
-- ========================================== --
local iDyxeGui = Instance.new("ScreenGui")
iDyxeGui.Name = "iDyxeRagnarok"
iDyxeGui.ResetOnSpawn = false

local success, result = pcall(function() return gethui() end)
if success and result then iDyxeGui.Parent = result else iDyxeGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Main Background
local MainFrame = Instance.new("Frame", iDyxeGui)
MainFrame.Size = UDim2.new(0, 200, 0, 250)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Header Title
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Title.Text = "iDyxe 8.5 RAGNAROK 👑"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 8)

-- ========================================== --
--          LOGIK FITUR CHAOS (NYATA)         --
-- ========================================== --
local auraActive = false
local carryActive = false
local flyActive = false
local flySpeed = 50
local auraConn
local carryConn
local flyConn
local targetToCarry = nil

-- FUNGSI MEMBUAT TITLE NYATA (MENYURAT KE BOOTH)
-- Kita pakai ChangeText di BoothEvents karena ini Global, Tuan.
local function SetGlobalTitle(text)
    local changeTextEvent = game:GetService("ReplicatedStorage"):FindFirstChild("BoothEvents"):FindFirstChild("ChangeText")
    if changeTextEvent then
        changeTextEvent:FireServer(text)
        notify("Global Title dikirim ke Booth!")
    else
        notify("Gagal: BoothEvents tidak ditemukan.")
    end
end

-- FUNGSI FLING & CULIK (PENGGANTI IDYXE AURA)
local function RealServerFling(active)
    auraActive = active
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    if not hrp then auraActive = false; return end

    if auraActive then
        RitualNetless() -- Mulai ritual
        notify("Aura Fling AKTIF (Nyata)!")
        
        auraConn = RunService.Heartbeat:Connect(function()
            if not auraActive or not hrp.Parent then auraConn:Disconnect(); return end
            
            -- Memutar tubuh Tuan dengan kecepatan sangat tinggi
            hrp.RotVelocity = Vector3.new(0, 99999, 0)
            
            -- Memberikan velocity lokal agar server kebingungan memproses tabrakan
            hrp.Velocity = hrp.CFrame.LookVector * 1000

            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local targetHrp = p.Character.HumanoidRootPart
                    local dist = (hrp.Position - targetHrp.Position).Magnitude
                    
                    if dist < 15 then
                        -- Tembak CFrame target ke dalam area tabrakan Tuan secara berulang
                        targetHrp.CFrame = hrp.CFrame * CFrame.new(math.random(-1,1), 0, math.random(-1,1))
                    end
                end
            end
        end)
    else
        if auraConn then auraConn:Disconnect() end
        if hrp then hrp.RotVelocity = Vector3.new(0,0,0); hrp.Velocity = Vector3.new(0,0,0) end
        notify("Aura Fling Nonaktif.")
    end
end

-- FUNGSI CULIK & TERBANG (MEMBAWA PLAYER)
local function CulikPlayer(targetName)
    targetToCarry = Players:FindFirstChild(targetName)
    if not targetToCarry or not targetToCarry.Character then notify("Target tidak ditemukan!"); return end
    
    carryActive = not carryActive
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    if carryActive and hrp then
        notify("Menculik: " .. targetToCarry.Name)
        flyActive = true -- Otomatis terbang
        local camera = workspace.CurrentCamera
        local bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        local bg = Instance.new("BodyGyro", hrp)
        bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)

        carryConn = RunService.Heartbeat:Connect(function()
            if not carryActive or not hrp.Parent then 
                bv:Destroy(); bg:Destroy();
                flyActive = false;
                if carryConn then carryConn:Disconnect() end;
                return 
            end
            
            -- Logika Terbang
            local dir = Vector3.new(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + camera.CFrame.RightVector end
            
            bv.Velocity = dir * flySpeed
            bg.CFrame = camera.CFrame
            
            -- Menempelkan target di depan Tuan di server
            if targetToCarry and targetToCarry.Character and targetToCarry.Character:FindFirstChild("HumanoidRootPart") then
                local th = targetToCarry.Character.HumanoidRootPart
                th.CFrame = hrp.CFrame * CFrame.new(0,0,-5)
                th.Velocity = Vector3.new(0, 50, 0)
            end
        end)
    else
        carryActive = false
        targetToCarry = nil
        notify("Target Dilepaskan.")
    end
end

-- ========================================== --
--          MEMBANGUN TOMBOL (STATIC GRID)     --
-- ========================================== --
local Container = Instance.new("Frame", MainFrame)
Container.Size = UDim2.new(1, -20, 1, -45)
Container.Position = UDim2.new(0, 10, 0, 40)
Container.BackgroundTransparency = 1

local Grid = Instance.new("UIGridLayout", Container)
Grid.CellSize = UDim2.new(0, 180, 0, 35)
Grid.CellPadding = UDim2.new(0, 5, 0, 5)

local function addBtn(txt, color, callback)
    local b = Instance.new("TextButton", Container)
    b.BackgroundColor3 = color or Color3.fromRGB(30, 32, 45)
    b.Text = txt
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.Code
    b.TextSize = 11
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    if callback then b.MouseButton1Click:Connect(callback) end
    return b
end

-- 1. TOMBOL FLING ALL (Real Server Chaos)
addBtn("🔥 iDyxe FLING (OFF)", Color3.fromRGB(150, 40, 40), function()
    RealServerFling(not auraActive)
    for _, b in pairs(Container:GetChildren()) do
        if b:IsA("TextButton") and b.Text:find("iDyxe FLING") then
            b.Text = auraActive and "🔥 iDyxe FLING (ON)" or "🔥 iDyxe FLING (OFF)"
            b.BackgroundColor3 = auraActive and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(150, 40, 40)
        end
    end
end)

-- 2. INPUT NAMA UNTUK CULIK
local input = Instance.new("TextBox", Container)
input.Size = UDim2.new(0, 180, 0, 30)
input.PlaceholderText = "Nama Target..."
input.Text = ""
input.Font = Enum.Font.Code
input.TextSize = 11

-- 3. TOMBOL CULIK & FLY (Bring & Carry)
addBtn("🕊️ CULIK & TERBANG", Color3.fromRGB(40, 80, 40), function()
    if input.Text ~= "" then CulikPlayer(input.Text) end
end)

-- 4. TOMBOL SET GLOBAL TITLE (Bypass FE Title)
addBtn("🌐 SET GLOBAL TITLE", Color3.fromRGB(40, 60, 100), function()
    if input.Text ~= "" then SetGlobalTitle(input.Text) end
end)

notify("iDyxe Ragnarok v8.5 - Server Dominance Ready! 👑")
