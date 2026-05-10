-- [[ iDyxe 8.5 - FINAL ABSOLUTE ]] --
-- Dibuat khusus untuk Tuan iDyxe. Ringan, Nyata, dan Mematikan.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Hapus UI lama
if PlayerGui:FindFirstChild("iDyxeFinal") then PlayerGui.iDyxeFinal:Destroy() end

local iDyxeGui = Instance.new("ScreenGui", PlayerGui)
iDyxeGui.Name = "iDyxeFinal"

local Main = Instance.new("Frame", iDyxeGui)
Main.Size = UDim2.new(0, 200, 0, 200)
Main.Position = UDim2.new(0.5, -100, 0.5, -100)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "iDyxe 8.5 FINAL 👑"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundColor3 = Color3.fromRGB(80, 140, 255)
Instance.new("UICorner", Title)

-- ========================================== --
--          CORE LOGIC (REAL PHYSICS)         --
-- ========================================== --
local auraActive = false
local carryActive = false
local targetName = ""

-- Fungsi menciptakan daya hancur nyata
local function PowerUp()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.Velocity = Vector3.new(0, 5000, 0)
        char.HumanoidRootPart.RotVelocity = Vector3.new(0, 5000, 0)
    end
end

-- 1. TOMBOL AURA FLING (DEKATI = MENTAL)
local btnAura = Instance.new("TextButton", Main)
btnAura.Size = UDim2.new(0.9, 0, 0, 40)
btnAura.Position = UDim2.new(0.05, 0, 0, 40)
btnAura.Text = "🔥 AURA FLING (OFF)"
btnAura.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
btnAura.TextColor3 = Color3.new(1,1,1)

btnAura.MouseButton1Click:Connect(function()
    auraActive = not auraActive
    btnAura.Text = auraActive and "🔥 AURA FLING (ON)" or "🔥 AURA FLING (OFF)"
    btnAura.BackgroundColor3 = auraActive and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(40, 40, 50)
    
    task.spawn(function()
        while auraActive do
            RunService.Heartbeat:Wait()
            PowerUp() -- Paksa server terima rotasi gila kita
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local targetHrp = p.Character.HumanoidRootPart
                    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - targetHrp.Position).Magnitude
                    if dist < 15 then
                        targetHrp.Velocity = Vector3.new(0, 1000, 0) -- Melempar secara nyata
                    end
                end
            end
        end
    end)
end)

-- 2. INPUT NAMA TARGET UNTUK CULIK
local input = Instance.new("TextBox", Main)
input.Size = UDim2.new(0.9, 0, 0, 30)
input.Position = UDim2.new(0.05, 0, 0, 90)
input.PlaceholderText = "Nama Target Di Sini..."
input.Text = ""

-- 3. TOMBOL CULIK & TERBANG
local btnCarry = Instance.new("TextButton", Main)
btnCarry.Size = UDim2.new(0.9, 0, 0, 40)
btnCarry.Position = UDim2.new(0.05, 0, 0, 130)
btnCarry.Text = "🕊️ CULIK & TERBANG"
btnCarry.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
btnCarry.TextColor3 = Color3.new(1,1,1)

btnCarry.MouseButton1Click:Connect(function()
    carryActive = not carryActive
    local target = Players:FindFirstChild(input.Text)
    
    if carryActive and target and target.Character then
        btnCarry.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        task.spawn(function()
            local bv = Instance.new("BodyVelocity", LocalPlayer.Character.HumanoidRootPart)
            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            
            while carryActive do
                RunService.Heartbeat:Wait()
                local hrp = LocalPlayer.Character.HumanoidRootPart
                local targetHrp = target.Character:FindFirstChild("HumanoidRootPart")
                
                -- Terbang mengikuti kamera
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 50
                
                -- Menempelkan target di depan (Nyata di server)
                if targetHrp then
                    targetHrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -5)
                    targetHrp.Velocity = Vector3.new(0, 50, 0)
                end
            end
            bv:Destroy()
        end)
    else
        carryActive = false
        btnCarry.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    end
end)
