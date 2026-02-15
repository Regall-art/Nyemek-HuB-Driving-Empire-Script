-- NYEMEK HUB - CAR DEALERSHIP TYCOON (CDT) ULTIMATE
-- Fitur: Auto Build, Money Add, Unlock Cars, Bypass Gamepass + Fitur Lama

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Nyemek HuB", 
   LoadingTitle = "Nyemek HuB: CDT God Mode",
   LoadingSubtitle = "By Gemini AI",
   ConfigurationSaving = { Enabled = true, FolderName = "NyemekHub_CDT", FileName = "Config" },
   Discord = { Enabled = false },
   KeySystem = false,
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Variables
_G.AutoBuild = false
_G.AutoCollect = false
_G.VehicleSpeed = 1
_G.InfiniteNitro = false
_G.NoClip = false

-- ============================================
-- THE GOD FUNCTIONS (CDT SPECIAL)
-- ============================================

local function ActivateGodMode()
    -- 1. VISUAL MONEY ADD ($999,999,999)
    -- Manipulasi angka uang agar bisa digunakan untuk UI & Screenshot
    task.spawn(function()
        while true do
            pcall(function()
                local gui = player.PlayerGui:FindFirstChild("MainGui") or player.PlayerGui:FindFirstChild("HUD")
                if gui then
                    for _, v in pairs(gui:GetDescendants()) do
                        if v:IsA("TextLabel") and (v.Text:find("$") or v.Name:lower():find("cash")) then
                            v.Text = "$999,999,999"
                        end
                    end
                end
            end)
            task.wait(1)
        end
    end)

    -- 2. BYPASS ALL GAMEPASS (Visual & Logic Access)
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "UserOwnsGamePassAsync" or method == "PlayerOwnsAsset" then
            return true
        end
        return oldNamecall(self, unpack({...}))
    end)
    setreadonly(mt, true)

    -- 3. UNLOCK ALL CARS (Session Only)
    local carFolder = ReplicatedStorage:FindFirstChild("Cars")
    local owned = player:FindFirstChild("OwnedCars") or player:FindFirstChild("Data")
    if carFolder and owned then
        for _, car in pairs(carFolder:GetChildren()) do
            if not owned:FindFirstChild(car.Name) then
                local b = Instance.new("BoolValue", owned)
                b.Name = car.Name
                b.Value = true
            end
        end
    end
    
    Rayfield:Notify({Title = "Nyemek HuB", Content = "God Mode & Gamepass Bypass Aktif!"})
end

-- ============================================
-- NYEMEK HUB TABS
-- ============================================

local MainTab = Window:CreateTab("🔓 Unlocker", 4483362458)
MainTab:CreateButton({
   Name = "🔥 ACTIVATE ALL (Money, Cars, Gamepass)",
   Callback = function() ActivateGodMode() end,
})

local FarmTab = Window:CreateTab("💰 Auto Farm", 4483362458)
FarmTab:CreateToggle({
   Name = "🏗️ Auto Build Dealership",
   CurrentValue = false,
   Callback = function(v) _G.AutoBuild = v end,
})
FarmTab:CreateToggle({
   Name = "🏪 Auto Collect Cash",
   CurrentValue = false,
   Callback = function(v) _G.AutoCollect = v end,
})

local VehicleTab = Window:CreateTab("🚗 Vehicle", 4483362458)
VehicleTab:CreateSlider({Name = "Speed", Range = {1, 10}, Increment = 1, CurrentValue = 1, Callback = function(v) _G.VehicleSpeed = v end})
VehicleTab:CreateToggle({Name = "Infinite Nitro", CurrentValue = false, Callback = function(v) _G.InfiniteNitro = v end})

local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
PlayerTab:CreateSlider({Name = "Walkspeed", Range = {16, 200}, CurrentValue = 16, Callback = function(v) player.Character.Humanoid.WalkSpeed = v end})
PlayerTab:CreateToggle({Name = "No Clip", CurrentValue = false, Callback = function(v) _G.NoClip = v end})

-- ============================================
-- RUNTIME LOOPS
-- ============================================

-- Auto Build & Collect
task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoBuild then
            -- Mencari tombol beli/upgrade di dealer milikmu
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("TouchTransmitter") and v.Parent.Name == "BuyButton" then
                    firetouchinterest(player.Character.HumanoidRootPart, v.Parent, 0)
                    firetouchinterest(player.Character.HumanoidRootPart, v.Parent, 1)
                end
            end
        end
        if _G.AutoCollect then
            local rem = ReplicatedStorage:FindFirstChild("Remotes")
            if rem and rem:FindFirstChild("CollectCash") then
                rem.CollectCash:FireServer()
            end
        end
    end
end)

-- Old Features: Speed & Nitro
RunService.Heartbeat:Connect(function()
    local seat = (player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.SeatPart)
    if seat and seat:IsA("VehicleSeat") then
        seat.MaxSpeed = 300 * _G.VehicleSpeed
        if _G.InfiniteNitro then
            local s = seat.Parent:FindFirstChild("Stats")
            if s and s:FindFirstChild("Nitro") then s.Nitro.Value = 100 end
        end
    end
end)

-- NoClip
RunService.Stepped:Connect(function()
    if _G.NoClip and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

Rayfield:Notify({Title = "Nyemek HuB Loaded", Content = "Selamat bersenang-senang di CDT!"})
