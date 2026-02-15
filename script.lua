-- NYEMEK HUB - ULTIMATE UI FORCER (V5)
-- Metode: Memaksa Tombol UI & Bypass Status Kepemilikan

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Nyemek HuB", 
   LoadingTitle = "Nyemek HuB: UI Aggressive Mode",
   LoadingSubtitle = "Forcing UI Buttons...",
   ConfigurationSaving = { Enabled = true, FolderName = "NyemekHub_DE", FileName = "Config" },
   Discord = { Enabled = false },
   KeySystem = false,
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- Global Vars (Fitur Lama Tetap Ada)
_G.AutoFarm = false
_G.VehicleSpeed = 1
_G.NoClip = false
_G.InfiniteNitro = false

-- ============================================
-- CORE: AGGRESSIVE UI FORCER
-- ============================================

local function ForceUnlockUI()
    local pGui = player:WaitForChild("PlayerGui")
    
    -- 1. Visual Money (Set $999M)
    for _, v in pairs(pGui:GetDescendants()) do
        if v:IsA("TextLabel") and (v.Text:find(",") or v.Name:lower():find("money")) then
            v.Text = "$999,999,999"
        end
    end

    -- 2. Scrape All Vehicle Assets from ReplicatedStorage
    local allAssets = {}
    local folders = {"Vehicles", "Helicopters", "Planes", "Boats", "Bikes"}
    for _, fName in pairs(folders) do
        local f = ReplicatedStorage:FindFirstChild(fName)
        if f then
            for _, asset in pairs(f:GetChildren()) do
                allAssets[asset.Name] = true
            end
        end
    end

    -- 3. Force UI Elements (The "Aggressive" Part)
    -- Mencari semua frame kendaraan di dalam UI Garage kamu
    for _, v in pairs(pGui:GetDescendants()) do
        -- Mencari frame yang punya nama kendaraan atau harga
        if v:IsA("Frame") and (allAssets[v.Name] or v:FindFirstChild("Price") or v:FindFirstChild("Lock")) then
            -- Cari tombol di dalam frame tersebut
            local buyButton = v:FindFirstChild("Buy") or v:FindFirstChild("Purchase") or v:FindFirstChild("Action")
            local lockIcon = v:FindFirstChild("Lock") or v:FindFirstChild("Locked")
            
            -- Hapus ikon kunci
            if lockIcon then lockIcon:Destroy() end
            
            -- Ubah teks tombol menjadi SPAWN
            if buyButton then
                if buyButton:IsA("TextButton") then
                    buyButton.Text = "SPAWN (Nyemek)"
                    buyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Hijau
                elseif buyButton:FindFirstChildOfClass("TextLabel") then
                    buyButton:FindFirstChildOfClass("TextLabel").Text = "SPAWN"
                end
            end
        end
    end

    Rayfield:Notify({
        Title = "Nyemek HuB",
        Content = "UI Buttons Forced! Buka Garage dan lihat perubahannya.",
        Duration = 5
    })
end

-- ============================================
-- NYEMEK HUB INTERFACE
-- ============================================

local MainTab = Window:CreateTab("🔓 Unlocker", 4483362458)
MainTab:CreateButton({
   Name = "🔥 FORCE UI UNLOCK (Car, Heli, Boat, Motor)",
   Callback = function() ForceUnlockUI() end,
})

local FarmTab = Window:CreateTab("💰 Auto Farm", 4483362458)
FarmTab:CreateToggle({Name = "🏁 Auto Farm", CurrentValue = false, Callback = function(v) _G.AutoFarm = v end})

local VehicleTab = Window:CreateTab("🚗 Mods", 4483362458)
VehicleTab:CreateSlider({Name = "Speed", Range = {1, 20}, Increment = 1, CurrentValue = 1, Callback = function(v) _G.VehicleSpeed = v end})
VehicleTab:CreateToggle({Name = "Nitro", CurrentValue = false, Callback = function(v) _G.InfiniteNitro = v end})

local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
PlayerTab:CreateSlider({Name = "Walkspeed", Range = {16, 200}, CurrentValue = 16, Callback = function(v) player.Character.Humanoid.WalkSpeed = v end})
PlayerTab:CreateToggle({Name = "No Clip", CurrentValue = false, Callback = function(v) _G.NoClip = v end})

-- ============================================
-- RUNTIME LOOPS
-- ============================================

game:GetService("RunService").Heartbeat:Connect(function()
    local char = player.Character
    local seat = (char and char:FindFirstChild("Humanoid") and char.Humanoid.SeatPart)
    if seat and seat:IsA("VehicleSeat") then
        seat.MaxSpeed = 500 * _G.VehicleSpeed
        if _G.InfiniteNitro then
            local n = seat.Parent:FindFirstChild("Nitro") or seat.Parent:FindFirstChild("Boost")
            if n then n.Value = 100 end
        end
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    if _G.NoClip and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

Rayfield:Notify({Title = "Nyemek HuB Loaded", Content = "Siap untuk Force Unlock!"})
