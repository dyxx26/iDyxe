-- [[ iDyxe 8.5 - SERVER OVERLORD EDITION ]] --

local Remotes = {
    Admin = game:GetService("ReplicatedStorage"):FindFirstChild("AdminRemotes"),
    Main = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes"),
    Global = workspace:FindFirstChild("GlobalPianoConnector")
}

local function notify(txt)
    game.StarterGui:SetCore("SendNotification", {Title = "iDyxe HUB", Text = txt, Duration = 3})
end

-- 1. SERVER LAG NYATA (MEMBAJAK PIANO & POSITION)
-- Ini akan membuat server sesak karena Tuan mengirim ribuan data koordinat palsu.
local function RealServerLag(active)
    _G.iDyxeLag = active
    task.spawn(function()
        while _G.iDyxeLag do
            -- Tembak Jembatan Piano
            if Remotes.Global then
                Remotes.Global:FireServer(math.random(1,100), 100, true)
            end
            -- Tembak Jembatan Posisi (Memaksa Server menghitung koordinat Tuan)
            if Remotes.Main and Remotes.Main:FindFirstChild("SendPosition") then
                Remotes.Main.SendPosition:FireServer(Vector3.new(math.huge, math.huge, math.huge))
            end
            task.wait(0.01)
        end
    end)
    notify(active and "Server Lag: AKTIF (Nyata)" or "Server Lag: NONAKTIF")
end

-- 2. ADMIN COMMAND BYPASS (EKSPERIMENTAL)
-- Mencoba mengirim perintah admin langsung ke server via CommandUse
local function TryAdmin(cmd)
    if Remotes.Admin and Remotes.Admin:FindFirstChild("CommandUse") then
        Remotes.Admin.CommandUse:FireServer(cmd)
        notify("Mencoba Perintah: " .. cmd)
    else
        notify("Gagal: Jembatan Admin Terkunci!")
    end
end

-- 3. GIVING COINS (MENGGUNAKAN GIVECOINSEVENT)
-- Tuan tadi melihat ada "GiveCoinsEvent" di ReplicatedStorage kan? 
local function FarmCoins()
    local event = game:GetService("ReplicatedStorage"):FindFirstChild("GiveCoinsEvent")
    if event then
        event:FireServer(999999) -- Mencoba meminta koin ke server
        notify("Mencoba Menambah Koin... Cek saldo Tuan!")
    end
end
