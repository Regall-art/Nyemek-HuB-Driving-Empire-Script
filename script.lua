-- NYEMEK HUB - MODULE BYPASS (THE FINAL ATTEMPT)
-- Mengincar internal ModuleScript Driving Empire

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Nyemek HuB", 
   LoadingTitle = "Nyemek HuB: Module Hijacking",
   LoadingSubtitle = "Final Attempt at UI Manipulation",
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
-- CORE: MODULE SCRIPT BYPASS
-- ============================================

local function NyemekModuleBypass()
    -- 1. Visual Money (Looping Agresif)
    task.spawn(function()
        while true do
            pcall(function()
                local pGui = player:FindFirstChild("PlayerGui")
                if pGui then
                    for _, v in pairs(pGui:GetDescendants()) do
                        if v:IsA("TextLabel") and (v.Text:find(",") or v.Name:lower():find("money")) then
                            v.Text = "$999,999,999"
                        end
                    end
                end
            end)
            task.wait(0.5)
        end
    end)

    -- 2. Module Script Hijacking
    -- Mencoba mencari modul yang mengatur data kendaraan
    for _, v in pairs(getnilinstances()) do -- Mencari di instance yang disembunyikan
        if v:IsA("ModuleScript") and (v.Name:find("Vehicle") or v.Name:find("Data")) then
            local success, module = pcall(function() return require(v) end)
            if success and type(module) == "table" then
                -- Jika ketemu tabel kendaraan, kita paksa set jadi True (Owned)
                for i, _ in pairs(module) do
                    if type(module[i]) == "table" and module[i].Price then
                        module[i].Price = 0
                        module[i].IsOwned = true
                    end
                end
            end
        end
    end

    -- 3. UI Manual Refresh
    -- Memaksa folder data player menerima nilai baru
    local ownedFolder = player:FindFirstChild("OwnedVehicles") or player:FindFirstChild("Data")
    if ownedFolder then
        local categories = {"Vehicles", "Helicopters", "Planes", "Boats", "Bikes"}
        for _, cat in pairs(categories) do
            local folder = ReplicatedStorage:FindFirstChild(cat)
            if folder then
                for _, car in pairs(folder:GetChildren()) do
                    if not ownedFolder:FindFirstChild(car.Name) then
                        local b = Instance.new("BoolValue", ownedFolder)
                        b.Name = car.Name
                        b.Value = true
                    end
                end
            end
        end
    end

    Rayfield:Notify({
        Title = "Nyemek HuB",
        Content = "Module Bypass Sent! Coba buka/tutup Garage berkali-kali.",
        Duration = 5
    })
end

-- ============================================
-- NYEMEK HUB INTERFACE
-- ============================================

local MainTab = Window:CreateTab("🔓 Unlocker", 4483362458)
MainTab:CreateButton({
   Name = "💀 ULTIMATE MODULE BYPASS (Car/Heli/Boat/Motor)",
   Callback = function() NyemekModuleBypass() end,
})

local FarmTab = Window:CreateTab("💰 Auto Farm", 4483362458)
FarmTab:CreateToggle({Name = "🏁 Start Farm", CurrentValue = false, Callback = function(v) _G.AutoFarm = v end})

local VehicleTab = Window:CreateTab("🚗 Vehicle", 4483362458)
VehicleTab:CreateSlider({Name = "Speed", Range = {1, 25}, Increment = 1, CurrentValue = 1, Callback = function(v) _G.VehicleSpeed = v end})
VehicleTab:CreateToggle({Name = "Nitro", CurrentValue = false, Callback = function(v) _G.InfiniteNitro = v end})

local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
PlayerTab:CreateSlider({Name = "Walkspeed", Range = {16, 200}, CurrentValue = 16, Callback = function(v) player.Character.Humanoid.WalkSpeed = v end})
PlayerTab:CreateToggle({Name = "No Clip", CurrentValue = false, Callback = function(v) _G.NoClip = v end})

-- ============================================
-- SYSTEM RUNTIME
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

Rayfield:Notify({Title = "Nyemek HuB", Content = "Script Loaded - Ready for Last Resort"})
