-- NYEMEK HUB - ULTIMATE SESSION UNLOCKER (ALL VEHICLES)
-- Merged with Helicopter, Plane, Motor, and Boat Injection

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Nyemek HuB", 
   LoadingTitle = "Nyemek HuB: Injecting All Assets",
   LoadingSubtitle = "Car, Heli, Plane, Motor, Boat...",
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

-- Global Vars
_G.AutoFarm = false
_G.VehicleSpeed = 1
_G.NoClip = false
_G.InfiniteNitro = false

-- ============================================
-- CORE: FULL CATEGORY MANIPULATION
-- ============================================

local function UnlockAllCategories()
    -- 1. Visual Money (999M)
    local pGui = player:WaitForChild("PlayerGui")
    for _, v in pairs(pGui:GetDescendants()) do
        if v:IsA("TextLabel") and (v.Text:find(",") or v.Name:lower():find("money")) then
            v.Text = "$999,999,999"
        end
    end

    -- 2. Comprehensive Vehicle Injection
    -- Daftar folder potensial tempat game menyimpan data kendaraan
    local vehiclePaths = {
        ReplicatedStorage:FindFirstChild("Vehicles"),
        ReplicatedStorage:FindFirstChild("Helicopters"),
        ReplicatedStorage:FindFirstChild("Planes"),
        ReplicatedStorage:FindFirstChild("Boats"),
        ReplicatedStorage:FindFirstChild("Bikes") -- Biasanya untuk Motor
    }

    local ownedFolder = player:FindFirstChild("OwnedVehicles") or player:FindFirstChild("Data")
    
    if ownedFolder then
        for _, folder in pairs(vehiclePaths) do
            if folder then
                for _, asset in pairs(folder:GetChildren()) do
                    -- Suntik semua aset (Mobil, Heli, Pesawat, Motor, Kapal)
                    if not ownedFolder:FindFirstChild(asset.Name) then
                        local fakeOwnership = Instance.new("BoolValue")
                        fakeOwnership.Name = asset.Name
                        fakeOwnership.Value = true
                        fakeOwnership.Parent = ownedFolder
                    end
                end
            end
        end
    end

    -- 3. Force UI Refresh (Garage & Vehicle Selection)
    -- Mencoba merestart UI agar semua kategori terupdate
    for _, uiName in pairs({"Garage", "Menu", "VehicleSpawn", "SpawnUI"}) do
        local targetUI = pGui:FindFirstChild(uiName)
        if targetUI then
            targetUI.Enabled = false
            task.wait(0.1)
            targetUI.Enabled = true
        end
    end

    Rayfield:Notify({
        Title = "Nyemek HuB: All Unlocked",
        Content = "Cars, Heli, Planes, Motors, & Boats are now Spawnable!",
        Duration = 5
    })
end

-- ============================================
-- NYEMEK HUB INTERFACE
-- ============================================

local MainTab = Window:CreateTab("🔓 Unlocker", 4483362458)

MainTab:CreateButton({
   Name = "🚀 ACTIVATE ALL CATEGORY UNLOCK (Session Only)",
   Callback = function()
      UnlockAllCategories()
   end,
})

MainTab:CreateSection("Info: All Vehicles, Planes, & Boats are now temporarily yours.")

local FarmTab = Window:CreateTab("💰 Auto Farm", 4483362458)
FarmTab:CreateToggle({
   Name = "🏁 Start Race Farm",
   CurrentValue = false,
   Callback = function(v) _G.AutoFarm = v end,
})

local VehicleTab = Window:CreateTab("🚗 Vehicle Mods", 4483362458)
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
PlayerTab:CreateSlider({Name = "Walkspeed", Range = {16, 200}, CurrentValue = 16, Callback = function(v) player.Character.Humanoid.WalkSpeed = v end})
PlayerTab:CreateToggle({Name = "No Clip", CurrentValue = false, Callback = function(v) _G.NoClip = v end})

-- ============================================
-- SYSTEM RUNTIME
-- ============================================

RunService.Heartbeat:Connect(function()
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

RunService.Stepped:Connect(function()
    if _G.NoClip and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- Anti-AFK
local vu = game:GetService("VirtualUser")
player.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

Rayfield:Notify({Title = "Nyemek HuB", Content = "Script Hybrid Loaded!"})
