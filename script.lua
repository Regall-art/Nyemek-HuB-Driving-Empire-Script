-- NYEMEK HUB - DRIVING EMPIRE SESSION UNLOCKER
-- All Features + Full UI Manipulation (Temporary Session)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- REPLACEMENT: Rayfield Branding removed and replaced with Nyemek HuB
local Window = Rayfield:CreateWindow({
   Name = "Nyemek HuB", 
   LoadingTitle = "Nyemek HuB",
   LoadingSubtitle = "Made By Love",
   ConfigurationSaving = { Enabled = true, FolderName = "NyemekHub_DE", FileName = "Config" },
   Discord = { Enabled = false },
   KeySystem = false,
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Variables (Keeping Old Features)
_G.AutoFarm = false
_G.VehicleSpeed = 1
_G.NoClip = false
_G.InfiniteNitro = false

-- ============================================
-- CORE: VEHICLE UI MANIPULATION (NYEMEK STYLE)
-- ============================================

local function UnlockEverythingSession()
    -- 1. Visual Money Spoof (Set to $999,999,999)
    local pGui = player:WaitForChild("PlayerGui")
    for _, v in pairs(pGui:GetDescendants()) do
        if v:IsA("TextLabel") and (v.Text:find(",") or v.Name:lower():find("money")) then
            v.Text = "$999,999,999"
        end
    end

    -- 2. Injecting Vehicle List into Garage UI
    -- Mencari folder database kendaraan game
    local vehicleFolder = ReplicatedStorage:FindFirstChild("Vehicles")
    local ownedFolder = player:FindFirstChild("OwnedVehicles") or player:FindFirstChild("Data")
    
    if vehicleFolder and ownedFolder then
        for _, car in pairs(vehicleFolder:GetChildren()) do
            -- Suntik data kepemilikan palsu agar tombol SPAWN aktif di UI
            if not ownedFolder:FindFirstChild(car.Name) then
                local fakeCar = Instance.new("BoolValue")
                fakeCar.Name = car.Name
                fakeCar.Value = true
                fakeCar.Parent = ownedFolder
            end
        end
    end

    -- 3. Force UI Refresh
    -- Memaksa menu Garage untuk membaca ulang data 'OwnedVehicles' yang baru disuntik
    local garageUI = pGui:FindFirstChild("Garage") or pGui:FindFirstChild("Menu")
    if garageUI then
        garageUI.Enabled = false
        task.wait(0.1)
        garageUI.Enabled = true
    end

    Rayfield:Notify({
        Title = "Nyemek HuB: Success",
        Content = "All Vehicles Injected to Garage! (Temporary Session)",
        Duration = 5
    })
end

-- ============================================
-- TABS & FEATURES (NYEMEK HUB)
-- ============================================

local MainTab = Window:CreateTab("🔓 Unlocker", 4483362458)

MainTab:CreateButton({
   Name = "🚀 ACTIVATE NYEMEK UNLOCK (All Cars & Money)",
   Callback = function()
      UnlockEverythingSession()
   end,
})

MainTab:CreateSection("Note: Data akan kembali normal saat kamu Rejoin.")

local FarmTab = Window:CreateTab("💰 Auto Farm", 4483362458)
FarmTab:CreateToggle({
   Name = "🏁 Start Race Farm",
   CurrentValue = false,
   Callback = function(v) _G.AutoFarm = v end,
})

local VehicleTab = Window:CreateTab("🚗 Vehicle", 4483362458)
VehicleTab:CreateSlider({
   Name = "Speed Multiplier",
   Range = {1, 20},
   Increment = 1,
   CurrentValue = 1,
   Callback = function(v) _G.VehicleSpeed = v end,
})
VehicleTab:CreateToggle({
   Name = "Infinite Nitro",
   CurrentValue = false,
   Callback = function(v) _G.InfiniteNitro = v end,
})

local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
PlayerTab:CreateSlider({
    Name = "Walkspeed", 
    Range = {16, 200}, 
    CurrentValue = 16, 
    Callback = function(v) player.Character.Humanoid.WalkSpeed = v end
})
PlayerTab:CreateToggle({
    Name = "No Clip", 
    CurrentValue = false, 
    Callback = function(v) _G.NoClip = v end
})

-- ============================================
-- RUNTIME SYSTEM
-- ============================================

-- Nitro & Speed Logic
RunService.Heartbeat:Connect(function()
    local seat = (player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.SeatPart)
    if seat and seat:IsA("VehicleSeat") then
        seat.MaxSpeed = 500 * _G.VehicleSpeed
        if _G.InfiniteNitro then
            local n = seat.Parent:FindFirstChild("Nitro")
            if n then n.Value = 100 end
        end
    end
end)

-- Noclip Logic
RunService.Stepped:Connect(function()
    if _G.NoClip and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- Anti AFK
local vu = game:GetService("VirtualUser")
player.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

Rayfield:Notify({Title = "Nyemek HuB Loaded", Content = "Script ready to use!"})
Rayfield:Notify({Title = "Join Discord Nyemek HuB discord.gg/WrJRz4zRy6"})
