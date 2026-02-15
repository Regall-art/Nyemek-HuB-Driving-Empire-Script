-- NYEMEK HUB - CAR DEALERSHIP TYCOON EDITION
-- Fitur Lama Tetap Ada + Fitur Baru CDT

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Nyemek HuB", 
   LoadingTitle = "Nyemek HuB: CDT Edition",
   LoadingSubtitle = "Adapting to New Game...",
   ConfigurationSaving = { Enabled = true, FolderName = "NyemekHub_CDT", FileName = "Config" },
   Discord = { Enabled = false },
   KeySystem = false,
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- Global Vars
_G.VisualMoney = "$999,999,999"
_G.AutoCollect = false
_G.VehicleSpeed = 1
_G.NoClip = false
_G.InfiniteNitro = false

-- ============================================
-- CDT SPECIAL FUNCTIONS
-- ============================================

local function ManipulateCDT()
    -- 1. Visual Money Loop
    task.spawn(function()
        while true do
            pcall(function()
                local gui = player.PlayerGui:FindFirstChild("MainGui") or player.PlayerGui:FindFirstChild("HUD")
                if gui then
                    -- Mencari label uang di CDT
                    for _, v in pairs(gui:GetDescendants()) do
                        if v:IsA("TextLabel") and (v.Text:find("$") or v.Name:lower():find("cash")) then
                            v.Text = _G.VisualMoney
                        end
                    end
                end
            end)
            task.wait(1)
        end
    end)

    -- 2. Unlock All Cars (Visual/Session)
    -- CDT menyimpan daftar mobil di ReplicatedStorage.Cars
    local carFolder = ReplicatedStorage:FindFirstChild("Cars")
    if carFolder then
        -- Menipu sistem agar tombol 'Drive' muncul
        for _, car in pairs(carFolder:GetChildren()) do
            local val = player:FindFirstChild("OwnedCars") or player:FindFirstChild("Data")
            if val and not val:FindFirstChild(car.Name) then
                local b = Instance.new("BoolValue", val)
                b.Name = car.Name
                b.Value = true
            end
        end
    end
end

-- ============================================
-- NYEMEK HUB TABS
-- ============================================

local MainTab = Window:CreateTab("🔓 Unlocker", 4483362458)
MainTab:CreateButton({
   Name = "🚀 ACTIVATE CDT BYPASS (Cars & Money)",
   Callback = function() 
      ManipulateCDT()
      Rayfield:Notify({Title = "Nyemek HuB", Content = "CDT Manipulated! Cek Dealership-mu."})
   end,
})

local FarmTab = Window:CreateTab("💰 Auto Farm", 4483362458)
FarmTab:CreateToggle({
   Name = "🏪 Auto Collect Dealer Cash",
   CurrentValue = false,
   Callback = function(v) _G.AutoCollect = v end,
})

local VehicleTab = Window:CreateTab("🚗 Vehicle", 4483362458)
VehicleTab:CreateSlider({Name = "Speed Multiplier", Range = {1, 10}, Increment = 1, CurrentValue = 1, Callback = function(v) _G.VehicleSpeed = v end})
VehicleTab:CreateToggle({Name = "Infinite Nitro", CurrentValue = false, Callback = function(v) _G.InfiniteNitro = v end})

local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
PlayerTab:CreateSlider({Name = "Walkspeed", Range = {16, 200}, CurrentValue = 16, Callback = function(v) player.Character.Humanoid.WalkSpeed = v end})
PlayerTab:CreateToggle({Name = "No Clip", CurrentValue = false, Callback = function(v) _G.NoClip = v end})

-- ============================================
-- RUNTIME LOOPS
-- ============================================

-- Auto Collect Logic
task.spawn(function()
    while task.wait(1) do
        if _G.AutoCollect then
            -- Remote CDT untuk mengambil uang dari mesin kasir dealer
            local remote = ReplicatedStorage:FindFirstChild("Remotes")
            if remote and remote:FindFirstChild("CollectCash") then
                remote.CollectCash:FireServer()
            end
        end
    end
end)

-- Vehicle Speed & Nitro
game:GetService("RunService").Heartbeat:Connect(function()
    local seat = (player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.SeatPart)
    if seat and seat:IsA("VehicleSeat") then
        if _G.VehicleSpeed > 1 then
            seat.MaxSpeed = 300 * _G.VehicleSpeed
        end
        if _G.InfiniteNitro then
            -- CDT Nitro logic
            local stats = seat.Parent:FindFirstChild("Stats")
            if stats and stats:FindFirstChild("Nitro") then
                stats.Nitro.Value = 100
            end
        end
    end
end)

-- NoClip
game:GetService("RunService").Stepped:Connect(function()
    if _G.NoClip and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

Rayfield:Notify({Title = "Nyemek HuB", Content = "Ready for CDT!"})
