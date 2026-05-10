-- [[ iDyxe 8.5 - Ragnarok Edition ]] --
-- Dibuat khusus untuk Tuan iDyxe. Dominasi fisik di server nyata.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function notify(txt)
    game.StarterGui:SetCore("SendNotification", {Title = "iDyxe HUB", Text = txt, Duration = 3})
end

-- ========================================== --
--  SISTEM PENDUKUNG (NETLESS)                --
-- ========================================== --
local function RitualNetless(char)
    -- Memaksa server melepaskan Network Ownership fisik karakter Tuan
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            -- Angka gila untuk merusak kalkulasi kecepatan server
            part.Velocity = Vector3.new(0, 9e9, 0) 
            part.RotVelocity = Vector3.new(0, 9e9, 0)
        end
    end
end

-- ========================================== --
--  FITUR 1: AURA PENGHANCUR (AUTO FLING)     --
-- ========================================== --
local auraActive = false
local auraConn
local FLING_RADIUS = 15 -- Jarak mental (studs)

local function ToggleAuraFling(state)
    auraActive = state
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    if not hrp then auraActive = false; return end

    if auraActive then
        RitualNetless(char) -- Mulai ritual
        auraConn = RunService.Heartbeat:Connect(function()
            if not auraActive or not hrp.Parent then auraConn:Disconnect(); return end
            
            -- Memutar tubuh Tuan dengan kecepatan sangat tinggi
            hrp.RotVelocity = Vector3.new(0, 99999, 0)

            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local targetHrp = p.Character.HumanoidRootPart
                    local dist = (hrp.Position - targetHrp.Position).Magnitude
                    
                    if dist < FLING_RADIUS then
                        -- Tembak CFrame target ke dalam area tabrakan Tuan secara berulang
                        targetHrp.CFrame = hrp.CFrame * CFrame.new(math.random(-1,1), 0, math.random(-1,1))
                    end
                end
            end
        end)
        notify("Aura Penghancur AKTIF! Mereka akan mental!")
    else
        if auraConn then auraConn:Disconnect() end
        if hrp then hrp.RotVelocity = Vector3.new(0,0,0) end
        notify("Aura Penghancur Nonaktif.")
    end
end

-- ========================================== --
--  FITUR 2: TERBANG SAMBIL CULIK (FLY & CARRY)
-- ========================================== --
local isFlying = false
local carryConn
local targetToCarry = nil
local flySpeed = 50

local function CulikPlayer(state, targetName)
    if state then
        -- Mencari target
        targetToCarry = Players:FindFirstChild(targetName)
        if not targetToCarry or not targetToCarry.Character then 
            notify("Target Gagal Diculik! Tidak Ditemukan."); return 
        end
        
        notify("Sedang menculik: " .. targetToCarry.Name)
        
        -- Mulai terbang
        isFlying = true
        local char = LocalPlayer.Character
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then isFlying = false; return end
        
        -- Matikan tabrakan lokal agar tidak mental sendiri saat culik
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end

        local camera = workspace.CurrentCamera
        local uis = game:GetService("UserInputService")
        local bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        local bg = Instance.new("BodyGyro", hrp)
        bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)

        carryConn = RunService.Heartbeat:Connect(function()
            if not isFlying then 
                bv:Destroy(); bg:Destroy(); 
                -- Pulihkan tabrakan
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
                carryConn:Disconnect(); return 
            end
            
            -- Logika Terbang
            local dir = Vector3.new(0,0,0)
            if uis:IsKeyDown(Enum.KeyCode.W) then dir = dir + camera.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.S) then dir = dir - camera.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.A) then dir = dir - camera.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.D) then dir = dir + camera.CFrame.RightVector end
            
            bv.Velocity = dir * flySpeed
            bg.CFrame = camera.CFrame
            
            -- Logika Menculik (Menempelkan target ke depan kita di server)
            if targetToCarry and targetToCarry.Character and targetToCarry.Character:FindFirstChild("HumanoidRootPart") then
                local targetHrp = targetToCarry.Character.HumanoidRootPart
                -- Memaksa server meletakkan target 3 studs di depan Tuan
                targetHrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -3)
                -- Memberikan sedikit gravitasi palsu agar target tidak mudah lepas
                targetHrp.Velocity = Vector3.new(0, 10, 0)
            end
        end)
    else
        isFlying = false
        targetToCarry = nil
        notify("Target Dilepaskan.")
    end
end
