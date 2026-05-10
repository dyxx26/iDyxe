-- [[ iDyxe 8.5 - FORCE ADMIN REPLICATION ]] --
-- Mencoba membajak jembatan yang ada untuk replikasi Title

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local function notify(txt)
    game.StarterGui:SetCore("SendNotification", {Title = "iDyxe HUB", Text = txt, Duration = 3})
end

-- 1. BAJAK CHAT SYSTEM (TAG ADMIN NYATA)
-- Ini menggunakan jembatan SayMessageRequest agar setiap kamu chat, 
-- ada tag [ADMIN] yang terlihat nyata oleh orang lain.
local function FakeAdminChat(msg)
    local chatEvent = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
    if chatEvent then
        -- Menambahkan banyak spasi untuk membajak tampilan chat agar tag terlihat di depan
        local fakeTag = "[ADMIN] " .. LocalPlayer.Name .. ": " .. msg
        chatEvent:FireServer(fakeTag, "All")
    end
end

-- 2. BAJAK NEXUS REPLICATION (Mencoba merubah data profil di server)
-- Tadi ada jembatan "NexusVRCharacterModel", kita coba tembak data ke sana.
local function ForceNexusTitle()
    local nexus = ReplicatedStorage:FindFirstChild("NexusVRCharacterModel")
    if nexus and nexus:FindFirstChild("UpdateCharacter") then
        -- Mencoba menyisipkan data metadata ADMIN ke dalam jembatan replikasi karakter
        nexus.UpdateCharacter:FireServer({
            ["NameTag"] = "[ADMIN] iDyxe",
            ["Rank"] = "Owner"
        })
        notify("Mencoba memaksa Title via Nexus Bridge...")
    end
end

-- 3. BAJAK REPUTATION REMOTES (Tag Reputasi)
-- Tadi ada "SubmitVote" di ReputationRemotes, kita coba pakai buat ganti status.
local function RepTitle()
    local rep = ReplicatedStorage:FindFirstChild("ReputationRemotes")
    if rep and rep:FindFirstChild("SubmitVote") then
        rep.SubmitVote:FireServer(LocalPlayer, "[ADMIN]")
        notify("Status Admin dikirim ke Reputation System!")
    end
end

-- Eksekusi Otomatis saat Script dijalankan
task.spawn(function()
    ForceNexusTitle()
    RepTitle()
    notify("Semua jembatan Title telah ditembak! Cek di layar orang lain.")
end)
