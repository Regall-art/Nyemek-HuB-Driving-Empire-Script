-- NYEMEK HUB - THE FINAL PUSH (CDT)
-- Fokus: Remote Hooking & Folder Hijacking

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Nyemek HuB", 
   LoadingTitle = "Nyemek HuB: Final Attempt",
   LoadingSubtitle = "Trying Remote Hijack...",
   ConfigurationSaving = { Enabled = true, FolderName = "Nyemek_CDT_Final", FileName = "Config" },
   Discord = { Enabled = false },
   KeySystem = false,
})

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ============================================
-- THE LAST RESORT FUNCTIONS
-- ============================================

local function FinalBypass()
    -- 1. Visual Money Lock ($999,999,999)
    -- Mencoba menyamakan angka dengan screenshot yang kamu mau
    task.spawn(function()
        while true do
            pcall(function()
                local gui = player.PlayerGui:FindFirstChild("MainGui") or player.PlayerGui:FindFirstChild("HUD")
                if gui then
                    for _, v in pairs(gui:GetDescendants()) do
                        if v:IsA("TextLabel") and (v.Text:find("%$") or v.Name:lower():find("cash")) then
                            v.Text = "$999,999,999"
                        end
                    end
                end
            end)
            task.wait(0.5)
        end
    end)

    -- 2. Forced Ownership Injection
    -- Mencoba masuk ke folder data terdalam player
    local owned = player:FindFirstChild("OwnedCars") or player:FindFirstChild("Data") or player:FindFirstChild("leaderstats")
    if owned then
        for _, car in pairs(ReplicatedStorage.Cars:GetChildren()) do
            if not owned:FindFirstChild(car.Name) then
                local val = Instance.new("BoolValue", owned)
                val.Name = car.Name
                val.Value = true
            end
        end
    end

    -- 3. Remote Event Hook (Simple Money Add Attempt)
    -- Mencoba memicu penambahan uang asli melalui event balapan/collect
    local remotes = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage:FindFirstChild("Events")
    if remotes then
        task.spawn(function()
            while true do
                -- Mencoba memicu collect cash secara terus menerus
                if remotes:FindFirstChild("CollectCash") then
                    remotes.CollectCash:FireServer()
                end
                task.wait(2)
            end
        end)
    end
end

-- ============================================
-- UI TABS
-- ============================================

local MainTab = Window:CreateTab("🔓 Unlocker", 4483362458)
MainTab:CreateButton({
   Name = "🚀 FINAL ACTIVATE (Check Owned Cars)",
   Callback = function() 
      FinalBypass()
      Rayfield:Notify({Title = "Nyemek HuB", Content = "Bypass sent. Restart your Garage Menu!"})
   end,
})

local FarmTab = Window:CreateTab("💰 Farm", 4483362458)
FarmTab:CreateToggle({
   Name = "🏗️ Auto Build",
   CurrentValue = false,
   Callback = function(v) _G.AutoBuild = v end,
})

-- Fitur lama tetap ada
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
PlayerTab:CreateSlider({Name = "Walkspeed", Range = {16, 200}, CurrentValue = 16, Callback = function(v) player.Character.Humanoid.WalkSpeed = v end})

-- ============================================
-- AUTO BUILD LOGIC
-- ============================================
task.spawn(function()
    while task.wait(0.3) do
        if _G.AutoBuild and player.Character then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "BuyButton" or v.Name == "UpgradeButton" then
                    if v:FindFirstChild("TouchTransmitter") then
                        firetouchinterest(player.Character.HumanoidRootPart, v, 0)
                        firetouchinterest(player.Character.HumanoidRootPart, v, 1)
                    end
                end
            end
        end
    end
end)

Rayfield:Notify({Title = "Nyemek HuB", Content = "Final CDT Script Loaded!"})
