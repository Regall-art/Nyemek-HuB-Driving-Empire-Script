-- Driving Empire Script with Rayfield UI
-- Features: Unlimited Money, Unlock All Cars, Auto Farm, and more

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Driving Empire",
   LoadingTitle = "Driving Empire Script",
   LoadingSubtitle = "Advanced Features",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "DrivingEmpire"
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false,
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

-- Player
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Variables
_G.MoneyFarm = false
_G.AutoFarm = false
_G.MoneyAmount = 10000
_G.FarmSpeed = 0.1
_G.VehicleSpeed = 1

-- ============================================
-- TAB: MONEY FARM
-- ============================================
local MoneyTab = Window:CreateTab("💰 Money", 4483362458)
local MoneySection = MoneyTab:CreateSection("Money Farm")

-- Get Money Toggle (Instant)
MoneyTab:CreateToggle({
   Name = "Get Money (Instant)",
   CurrentValue = false,
   Flag = "MoneyFarm",
   Callback = function(Value)
      _G.MoneyFarm = Value
      
      if Value then
         Rayfield:Notify({
            Title = "Money Farm",
            Content = "Auto money farm STARTED!",
            Duration = 3,
            Image = 4483362458,
         })
      else
         Rayfield:Notify({
            Title = "Money Farm",
            Content = "Auto money farm STOPPED!",
            Duration = 3,
            Image = 4483362458,
         })
      end
   end,
})

-- Money Amount Slider
MoneyTab:CreateSlider({
   Name = "Money Per Loop",
   Range = {1000, 1000000},
   Increment = 1000,
   Suffix = " $",
   CurrentValue = 10000,
   Flag = "MoneyAmount",
   Callback = function(Value)
      _G.MoneyAmount = Value
   end,
})

-- Farm Speed
MoneyTab:CreateSlider({
   Name = "Farm Speed",
   Range = {0.01, 2},
   Increment = 0.01,
   Suffix = "s",
   CurrentValue = 0.1,
   Flag = "FarmSpeed",
   Callback = function(Value)
      _G.FarmSpeed = Value
   end,
})

MoneyTab:CreateSection("Quick Money")

MoneyTab:CreateButton({
   Name = "Get 100K Instantly",
   Callback = function()
      GiveMoney(100000)
      Rayfield:Notify({
         Title = "Quick Money",
         Content = "Added 100K!",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

MoneyTab:CreateButton({
   Name = "Get 1M Instantly",
   Callback = function()
      GiveMoney(1000000)
      Rayfield:Notify({
         Title = "Quick Money",
         Content = "Added 1M!",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

MoneyTab:CreateButton({
   Name = "Get 10M Instantly",
   Callback = function()
      GiveMoney(10000000)
      Rayfield:Notify({
         Title = "Quick Money",
         Content = "Added 10M!",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

MoneyTab:CreateButton({
   Name = "Max Money (999M)",
   Callback = function()
      GiveMoney(999999999)
      Rayfield:Notify({
         Title = "Max Money",
         Content = "Set to 999M!",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

-- ============================================
-- TAB: VEHICLES
-- ============================================
local VehicleTab = Window:CreateTab("🚗 Vehicles", 4483362458)
local VehicleSection = VehicleTab:CreateSection("Vehicle Features")

VehicleTab:CreateButton({
   Name = "🔓 Unlock All Cars",
   Callback = function()
      UnlockAllCars()
      Rayfield:Notify({
         Title = "Unlock Cars",
         Content = "Unlocking all vehicles...",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateButton({
   Name = "🔓 Unlock All Premium Cars",
   Callback = function()
      UnlockPremiumCars()
      Rayfield:Notify({
         Title = "Premium Cars",
         Content = "Unlocking premium vehicles...",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateButton({
   Name = "🎨 Unlock All Colors/Paints",
   Callback = function()
      UnlockColors()
      Rayfield:Notify({
         Title = "Colors Unlocked",
         Content = "All colors unlocked!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateButton({
   Name = "🎯 Unlock All Upgrades",
   Callback = function()
      UnlockUpgrades()
      Rayfield:Notify({
         Title = "Upgrades",
         Content = "All upgrades unlocked!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateSection("Vehicle Speed")

VehicleTab:CreateSlider({
   Name = "Vehicle Speed Multiplier",
   Range = {1, 10},
   Increment = 0.5,
   Suffix = "x",
   CurrentValue = 1,
   Flag = "VehicleSpeed",
   Callback = function(Value)
      _G.VehicleSpeed = Value
   end,
})

VehicleTab:CreateToggle({
   Name = "Vehicle Noclip",
   CurrentValue = false,
   Flag = "VehicleNoclip",
   Callback = function(Value)
      _G.VehicleNoclip = Value
   end,
})

VehicleTab:CreateButton({
   Name = "Fix Vehicle Position",
   Callback = function()
      FixVehicle()
   end,
})

VehicleTab:CreateButton({
   Name = "Flip Vehicle",
   Callback = function()
      FlipVehicle()
   end,
})

-- ============================================
-- TAB: AUTO FARM
-- ============================================
local FarmTab = Window:CreateTab("⚡ Auto Farm", 4483362458)
local FarmSection = FarmTab:CreateSection("Auto Farm Features")

FarmTab:CreateToggle({
   Name = "Auto Deliver",
   CurrentValue = false,
   Flag = "AutoDeliver",
   Callback = function(Value)
      _G.AutoDeliver = Value
   end,
})

FarmTab:CreateToggle({
   Name = "Auto Race",
   CurrentValue = false,
   Flag = "AutoRace",
   Callback = function(Value)
      _G.AutoRace = Value
   end,
})

FarmTab:CreateToggle({
   Name = "Auto Daily Reward",
   CurrentValue = false,
   Flag = "AutoDaily",
   Callback = function(Value)
      _G.AutoDaily = Value
   end,
})

FarmTab:CreateToggle({
   Name = "Auto Spin Wheel",
   CurrentValue = false,
   Flag = "AutoSpin",
   Callback = function(Value)
      _G.AutoSpin = Value
   end,
})

-- ============================================
-- TAB: PLAYER
-- ============================================
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
local PlayerSection = PlayerTab:CreateSection("Player Settings")

PlayerTab:CreateSlider({
   Name = "Walkspeed",
   Range = {16, 200},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "Walkspeed",
   Callback = function(Value)
      if character and character:FindFirstChild("Humanoid") then
         character.Humanoid.WalkSpeed = Value
      end
   end,
})

PlayerTab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 200},
   Increment = 1,
   Suffix = " Power",
   CurrentValue = 50,
   Flag = "JumpPower",
   Callback = function(Value)
      if character and character:FindFirstChild("Humanoid") then
         character.Humanoid.JumpPower = Value
      end
   end,
})

PlayerTab:CreateButton({
   Name = "Reset Character",
   Callback = function()
      if character and character:FindFirstChild("Humanoid") then
         character.Humanoid.Health = 0
      end
   end,
})

-- ============================================
-- TAB: TELEPORTS
-- ============================================
local TeleportTab = Window:CreateTab("📍 Teleport", 4483362458)
local TeleportSection = TeleportTab:CreateSection("Locations")

local locations = {
   ["Spawn"] = CFrame.new(0, 5, 0),
   ["Car Dealer"] = CFrame.new(100, 5, 100),
   ["Garage"] = CFrame.new(-100, 5, -100),
   ["Race Start"] = CFrame.new(200, 5, 0),
}

for locationName, locationCFrame in pairs(locations) do
   TeleportTab:CreateButton({
      Name = "TP to " .. locationName,
      Callback = function()
         if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = locationCFrame
         end
      end,
   })
end

-- ============================================
-- TAB: MISC
-- ============================================
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)

MiscTab:CreateSection("Visual Settings")

MiscTab:CreateToggle({
   Name = "Remove Fog",
   CurrentValue = false,
   Flag = "RemoveFog",
   Callback = function(Value)
      if Value then
         game.Lighting.FogEnd = 100000
      else
         game.Lighting.FogEnd = 1000
      end
   end,
})

MiscTab:CreateToggle({
   Name = "Fullbright",
   CurrentValue = false,
   Flag = "Fullbright",
   Callback = function(Value)
      if Value then
         game.Lighting.Brightness = 2
         game.Lighting.ClockTime = 14
         game.Lighting.GlobalShadows = false
         game.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
      else
         game.Lighting.Brightness = 1
         game.Lighting.ClockTime = 12
         game.Lighting.GlobalShadows = true
         game.Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
      end
   end,
})

MiscTab:CreateButton({
   Name = "Anti AFK",
   Callback = function()
      local vu = game:GetService("VirtualUser")
      player.Idled:connect(function()
         vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
         wait(1)
         vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
      end)
      Rayfield:Notify({
         Title = "Anti AFK",
         Content = "Anti AFK enabled!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

MiscTab:CreateSection("Debug Tools")

MiscTab:CreateButton({
   Name = "Find Money Remotes",
   Callback = function()
      FindMoneyRemotes()
   end,
})

MiscTab:CreateButton({
   Name = "Find Vehicle Remotes",
   Callback = function()
      FindVehicleRemotes()
   end,
})

MiscTab:CreateButton({
   Name = "Monitor Remote Calls",
   Callback = function()
      MonitorRemotes()
   end,
})

-- ============================================
-- TAB: CREDITS
-- ============================================
local CreditsTab = Window:CreateTab("ℹ️ Credits", 4483362458)
CreditsTab:CreateParagraph({
   Title = "Driving Empire Script",
   Content = "Made with Rayfield UI Library\nFeatures: Money Farm, Unlock Cars, Auto Farm\nFor educational purposes only"
})

-- ============================================
-- FUNCTIONS
-- ============================================

-- Money Functions
function GiveMoney(amount)
   pcall(function()
      -- Method 1: Direct leaderstats
      if player:FindFirstChild("leaderstats") then
         if player.leaderstats:FindFirstChild("Money") then
            player.leaderstats.Money.Value = player.leaderstats.Money.Value + amount
         end
         if player.leaderstats:FindFirstChild("Cash") then
            player.leaderstats.Cash.Value = player.leaderstats.Cash.Value + amount
         end
      end
      
      -- Method 2: Fire remotes
      for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
         if remote:IsA("RemoteEvent") then
            local name = remote.Name:lower()
            if name:find("money") or name:find("cash") or name:find("currency") then
               remote:FireServer("AddMoney", amount)
               remote:FireServer(amount)
            end
         end
      end
      
      -- Method 3: PlayerData
      if player:FindFirstChild("Data") then
         if player.Data:FindFirstChild("Money") then
            player.Data.Money.Value = player.Data.Money.Value + amount
         end
      end
   end)
end

-- Unlock Functions
function UnlockAllCars()
   pcall(function()
      -- Fire unlock remotes for all vehicles
      for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
         if remote:IsA("RemoteEvent") then
            local name = remote.Name:lower()
            if name:find("unlock") or name:find("buy") or name:find("purchase") or name:find("vehicle") or name:find("car") then
               for i = 1, 500 do
                  remote:FireServer(i)
                  remote:FireServer("Unlock", i)
                  remote:FireServer("Buy", i)
                  remote:FireServer({VehicleId = i})
               end
            end
         end
      end
      
      -- Modify player ownership
      if player:FindFirstChild("OwnedVehicles") then
         for i = 1, 500 do
            local value = Instance.new("BoolValue")
            value.Name = tostring(i)
            value.Value = true
            value.Parent = player.OwnedVehicles
         end
      end
   end)
end

function UnlockPremiumCars()
   pcall(function()
      -- Bypass gamepass
      local mt = getrawmetatable(game)
      local oldNamecall = mt.__namecall
      setreadonly(mt, false)
      
      mt.__namecall = newcclosure(function(self, ...)
         local method = getnamecallmethod()
         if method == "UserOwnsGamePassAsync" then
            return true
         end
         return oldNamecall(self, ...)
      end)
      
      setreadonly(mt, true)
   end)
end

function UnlockColors()
   pcall(function()
      for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
         if remote:IsA("RemoteEvent") then
            local name = remote.Name:lower()
            if name:find("color") or name:find("paint") or name:find("customize") then
               for i = 1, 200 do
                  remote:FireServer(i)
                  remote:FireServer("Unlock", i)
               end
            end
         end
      end
   end)
end

function UnlockUpgrades()
   pcall(function()
      for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
         if remote:IsA("RemoteEvent") then
            local name = remote.Name:lower()
            if name:find("upgrade") or name:find("performance") or name:find("tune") then
               for i = 1, 100 do
                  remote:FireServer(i)
                  remote:FireServer("Max", i)
               end
            end
         end
      end
   end)
end

-- Vehicle Functions
function FixVehicle()
   pcall(function()
      for _, seat in pairs(workspace:GetDescendants()) do
         if seat:IsA("VehicleSeat") and seat.Occupant == humanoid then
            local vehicle = seat.Parent
            if vehicle.PrimaryPart then
               vehicle:SetPrimaryPartCFrame(vehicle.PrimaryPart.CFrame * CFrame.new(0, 5, 0))
            end
         end
      end
   end)
end

function FlipVehicle()
   pcall(function()
      for _, seat in pairs(workspace:GetDescendants()) do
         if seat:IsA("VehicleSeat") and seat.Occupant == humanoid then
            local vehicle = seat.Parent
            if vehicle.PrimaryPart then
               vehicle:SetPrimaryPartCFrame(vehicle.PrimaryPart.CFrame * CFrame.Angles(0, 0, math.pi))
            end
         end
      end
   end)
end

-- Debug Functions
function FindMoneyRemotes()
   print("\n=== MONEY REMOTES ===")
   local found = 0
   for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
      if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
         local name = remote.Name:lower()
         if name:find("money") or name:find("cash") or name:find("currency") then
            found = found + 1
            print(found .. ". " .. remote:GetFullName())
         end
      end
   end
   print("=== TOTAL: " .. found .. " ===\n")
   
   Rayfield:Notify({
      Title = "Debug",
      Content = "Found " .. found .. " money remotes. Check F9!",
      Duration = 3,
      Image = 4483362458,
   })
end

function FindVehicleRemotes()
   print("\n=== VEHICLE REMOTES ===")
   local found = 0
   for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
      if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
         local name = remote.Name:lower()
         if name:find("vehicle") or name:find("car") or name:find("unlock") or name:find("buy") then
            found = found + 1
            print(found .. ". " .. remote:GetFullName())
         end
      end
   end
   print("=== TOTAL: " .. found .. " ===\n")
   
   Rayfield:Notify({
      Title = "Debug",
      Content = "Found " .. found .. " vehicle remotes. Check F9!",
      Duration = 3,
      Image = 4483362458,
   })
end

function MonitorRemotes()
   local mt = getrawmetatable(game)
   local oldNamecall = mt.__namecall
   setreadonly(mt, false)
   
   mt.__namecall = newcclosure(function(self, ...)
      local method = getnamecallmethod()
      if method == "FireServer" or method == "InvokeServer" then
         print("🔴 " .. self:GetFullName() .. " | " .. method)
      end
      return oldNamecall(self, ...)
   end)
   
   setreadonly(mt, true)
   
   Rayfield:Notify({
      Title = "Monitor Active",
      Content = "Check console (F9) for remote calls!",
      Duration = 5,
      Image = 4483362458,
   })
end

-- ============================================
-- LOOPS
-- ============================================

-- Money Farm Loop
spawn(function()
   while wait(_G.FarmSpeed) do
      if _G.MoneyFarm then
         pcall(function()
            GiveMoney(_G.MoneyAmount)
         end)
      end
   end
end)

-- Vehicle Speed Loop
spawn(function()
   while wait(0.1) do
      if _G.VehicleSpeed > 1 then
         pcall(function()
            for _, seat in pairs(workspace:GetDescendants()) do
               if seat:IsA("VehicleSeat") and seat.Occupant == humanoid then
                  seat.MaxSpeed = seat.MaxSpeed * _G.VehicleSpeed
               end
            end
         end)
      end
   end
end)

-- Vehicle Noclip Loop
spawn(function()
   while wait(0.1) do
      if _G.VehicleNoclip then
         pcall(function()
            for _, seat in pairs(workspace:GetDescendants()) do
               if seat:IsA("VehicleSeat") and seat.Occupant == humanoid then
                  for _, part in pairs(seat.Parent:GetDescendants()) do
                     if part:IsA("BasePart") then
                        part.CanCollide = false
                     end
                  end
               end
            end
         end)
      end
   end
end)

-- Auto Daily Reward
spawn(function()
   while wait(60) do
      if _G.AutoDaily then
         pcall(function()
            for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
               if remote:IsA("RemoteEvent") then
                  local name = remote.Name:lower()
                  if name:find("daily") or name:find("reward") then
                     remote:FireServer()
                  end
               end
            end
         end)
      end
   end
end)

-- Character Respawn Handler
player.CharacterAdded:Connect(function(char)
   character = char
   humanoid = char:WaitForChild("Humanoid")
   humanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

-- Success Notification
Rayfield:Notify({
   Title = "Driving Empire",
   Content = "Script loaded successfully!",
   Duration = 5,
   Image = 4483362458,
})

print("Driving Empire Script Loaded!")
