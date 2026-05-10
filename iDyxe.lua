-- [[ iDyxe 8.5 - REAL SERVER FLING & CHAOS ]] --
-- Nama: iDyxe | Tujuan: Dominasi Total

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ========================================== --
--  FUNGSI FLING NYATA (DILIHAT ORANG LAIN)   --
-- ========================================== --
local function RealFling(targetPlr)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local targetChar = targetPlr.Character
    local targetHrp = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

    if hrp and targetHrp then
        -- Simpan posisi asli agar bisa kembali
        local oldPos = hrp.CFrame
        
        -- Matikan Tabrakan Lokal (agar Tuan tidak terpental sendiri)
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end

        -- Ritual Netless: Memaksa Server memberikan kontrol fisik penuh ke Tuan
        local vel = hrp.Velocity
        hrp.Velocity = Vector3.new(0, 9999, 0) -- Angka gila untuk merusak kalkulasi server
        
        -- Serangan: Teleport ke target dan putar gila-gilaan
        local connection
        connection = RunService.Heartbeat:Connect(function()
            if targetHrp and targetHrp.Parent then
                hrp.CFrame = targetHrp.CFrame * CFrame.new(math.random(-1,1), 0, math.random(-1,1))
                hrp.RotVelocity = Vector3.new(0, 1000000, 0) -- Gasing pemusnah
            else
                connection:Disconnect()
            end
        end)

        task.wait(0.5) -- Durasi serangan
        connection:Disconnect()
        
        -- Kembali ke posisi semula
        hrp.Velocity = vel
        hrp.CFrame = oldPos
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end

-- ========================================== --
--          CARA NGERJAIN SEMUA ORANG         --
-- ========================================== --
-- Panggil ini lewat tombol di Hub Tuan:
-- for _, p in pairs(game.Players:GetPlayers()) do
--     if p ~= LocalPlayer then RealFling(p) end
-- end
