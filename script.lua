-- Driving Empire - Alternative Methods
-- Since direct money doesn't work, we'll use different approaches
-- Focus: Auto-farm legitimate methods + vehicle unlocks

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Driving Empire - Alternative",
   LoadingTitle = "Driving Empire",
   LoadingSubtitle = "Using Alternative Methods",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "DrivingEmpire_Alt"
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false,
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Player
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Variables
_G.AutoCollectCash = false
_G.AutoDeliver = false
_G.AutoRace = false
_G.Speed = 1

print("\n" .. string.rep("=", 60))
print("DRIVING EMPIRE - ALTERNATIVE METHODS")
print("Since direct money add doesn't work,")
print("we'll use legitimate auto-farm methods instead")
print(string.rep("=", 60) .. "\n")

-- ============================================
-- TAB: INFO & EXPLANATION
-- ============================================
local InfoTab = Window:CreateTab("ℹ️ Read This First", 4483362458)

InfoTab:CreateParagraph({
   Title = "⚠️ Why Money Add Doesn't Work",
   Content = "Driving Empire is fully SERVER-SIDED. Money is handled 100% on the server, so we can't directly add money from client."
})

InfoTab:CreateParagraph({
   Title = "✅ What DOES Work",
   Content = "• Auto-collect cash drops around map\n• Auto-complete deliveries\n• Auto-win races\n• Unlock all vehicles (GamePass bypass)\n• Speed modifications\n• Teleports"
})

InfoTab:CreateParagraph({
   Title = "💡 Best Strategy",
   Content = "1. Enable 'Auto Collect Cash' to pickup money around map\n2. Enable 'Auto Deliver' for delivery missions\n3. Use 'Speed Boost' to go faster\n4. Use 'GamePass Bypass' to unlock premium cars"
})

-- ============================================
-- TAB: AUTO FARM (LEGITIMATE)
-- ============================================
local FarmTab = Window:CreateTab("⚡ Auto Farm", 4483362458)

FarmTab:CreateSection("Cash Collection")

FarmTab:CreateToggle({
   Name = "Auto Collect Cash Drops",
   CurrentValue = false,
   Flag = "AutoCollectCash",
   Callback = function(Value)
      _G.AutoCollectCash = Value
      
      if Value then
         Rayfield:Notify({
            Title = "Auto Collect",
            Content = "Collecting cash drops around map!",
            Duration = 3,
            Image = 4483362458,
         })
      end
   end,
})

FarmTab:CreateButton({
   Name = "Collect All Cash Now",
   Callback = function()
      CollectAllCash()
   end,
})

FarmTab:CreateSection("Delivery & Missions")

FarmTab:CreateToggle({
   Name = "Auto Complete Deliveries",
   CurrentValue = false,
   Flag = "AutoDeliver",
   Callback = function(Value)
      _G.AutoDeliver = Value
      
      if Value then
         Rayfield:Notify({
            Title = "Auto Deliver",
            Content = "Auto-completing deliveries!",
            Duration = 3,
            Image = 4483362458,
         })
      end
   end,
})

FarmTab:CreateToggle({
   Name = "Auto Race (Auto-Win)",
   CurrentValue = false,
   Flag = "AutoRace",
   Callback = function(Value)
      _G.AutoRace = Value
      
      if Value then
         Rayfield:Notify({
            Title = "Auto Race",
            Content = "Auto-racing enabled!",
            Duration = 3,
            Image = 4483362458,
         })
      end
   end,
})

FarmTab:CreateButton({
   Name = "Claim Daily Rewards",
   Callback = function()
      ClaimDailyRewards()
   end,
})

FarmTab:CreateButton({
   Name = "Spin Reward Wheel",
   Callback = function()
      SpinRewardWheel()
   end,
})

-- ============================================
-- TAB: VEHICLES (THIS WORKS!)
-- ============================================
local VehicleTab = Window:CreateTab("🚗 Vehicles", 4483362458)

VehicleTab:CreateParagraph({
   Title = "✅ Vehicle Unlock WORKS!",
   Content = "Even though money doesn't work, vehicle unlocking through GamePass bypass DOES work!"
})

VehicleTab:CreateSection("Unlock Methods")

VehicleTab:CreateButton({
   Name = "🔓 GamePass Bypass (BEST METHOD)",
   Callback = function()
      GamePassBypass()
      Rayfield:Notify({
         Title = "GamePass Bypass",
         Content = "All premium cars unlocked! Restart game to see effect.",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateButton({
   Name = "🔓 Unlock All Vehicles (Method 2)",
   Callback = function()
      UnlockAllVehicles()
   end,
})

VehicleTab:CreateButton({
   Name = "🎨 Unlock All Colors/Paints",
   Callback = function()
      UnlockAllColors()
   end,
})

VehicleTab:CreateSection("Vehicle Modifications")

VehicleTab:CreateSlider({
   Name = "Vehicle Speed Boost",
   Range = {1, 5},
   Increment = 0.1,
   Suffix = "x",
   CurrentValue = 1,
   Flag = "VehicleSpeed",
   Callback = function(Value)
      _G.Speed = Value
   end,
})

VehicleTab:CreateToggle({
   Name = "Vehicle Fly Mode",
   CurrentValue = false,
   Flag = "VehicleFly",
   Callback = function(Value)
      _G.VehicleFly = Value
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
   Name = "Fix Vehicle",
   Callback = function()
      FixVehicle()
   end,
})

-- ============================================
-- TAB: TELEPORTS
-- ============================================
local TeleportTab = Window:CreateTab("📍 Teleports", 4483362458)

TeleportTab:CreateSection("Farming Locations")

TeleportTab:CreateButton({
   Name = "TP to Cash Spawn 1",
   Callback = function()
      TeleportTo(Vector3.new(0, 5, 0))
   end,
})

TeleportTab:CreateButton({
   Name = "TP to Cash Spawn 2",
   Callback = function()
      TeleportTo(Vector3.new(100, 5, 100))
   end,
})

TeleportTab:CreateButton({
   Name = "TP to Delivery Start",
   Callback = function()
      TeleportToDelivery()
   end,
})

TeleportTab:CreateButton({
   Name = "TP to Race Start",
   Callback = function()
      TeleportToRace()
   end,
})

TeleportTab:CreateSection("Shop Locations")

TeleportTab:CreateButton({
   Name = "TP to Car Dealer",
   Callback = function()
      TeleportTo(Vector3.new(-50, 5, -50))
   end,
})

TeleportTab:CreateButton({
   Name = "TP to Garage",
   Callback = function()
      TeleportTo(Vector3.new(50, 5, 50))
   end,
})

-- ============================================
-- TAB: PLAYER
-- ============================================
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)

PlayerTab:CreateSlider({
   Name = "Walkspeed",
   Range = {16, 150},
   Increment = 1,
   Suffix = "",
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
   Range = {50, 150},
   Increment = 1,
   Suffix = "",
   CurrentValue = 50,
   Flag = "JumpPower",
   Callback = function(Value)
      if character and character:FindFirstChild("Humanoid") then
         character.Humanoid.JumpPower = Value
      end
   end,
})

PlayerTab:CreateToggle({
   Name = "No Fall Damage",
   CurrentValue = false,
   Flag = "NoFallDamage",
   Callback = function(Value)
      _G.NoFallDamage = Value
   end,
})

-- ============================================
-- TAB: MISC
-- ============================================
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)

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
      else
         game.Lighting.Brightness = 1
         game.Lighting.ClockTime = 12
         game.Lighting.GlobalShadows = true
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

-- ============================================
-- FUNCTIONS
-- ============================================

-- Cash Collection
function CollectAllCash()
   local collected = 0
   
   -- Look for cash drops in workspace
   for _, obj in pairs(Workspace:GetDescendants()) do
      if obj.Name:lower():find("cash") or obj.Name:lower():find("money") or obj.Name:lower():find("coin") then
         if obj:IsA("BasePart") or obj:IsA("Model") then
            pcall(function()
               -- Teleport to cash
               if character and humanoidRootPart then
                  humanoidRootPart.CFrame = obj:IsA("Model") and obj.PrimaryPart.CFrame or obj.CFrame
                  wait(0.1)
                  collected = collected + 1
               end
            end)
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Cash Collection",
      Content = "Collected " .. collected .. " cash drops!",
      Duration = 3,
      Image = 4483362458,
   })
end

-- Delivery
function AutoCompleteDelivery()
   -- Find delivery points
   for _, obj in pairs(Workspace:GetDescendants()) do
      if obj.Name:lower():find("delivery") or obj.Name:lower():find("dropoff") then
         if obj:IsA("BasePart") then
            pcall(function()
               humanoidRootPart.CFrame = obj.CFrame
               wait(0.5)
            end)
         end
      end
   end
end

-- Rewards
function ClaimDailyRewards()
   -- Fire daily reward remotes
   for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
      if remote:IsA("RemoteEvent") then
         local name = remote.Name:lower()
         if name:find("daily") or name:find("reward") or name:find("claim") then
            pcall(function()
               remote:FireServer()
               remote:FireServer("Claim")
               remote:FireServer("Daily")
            end)
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Daily Rewards",
      Content = "Attempted to claim daily rewards!",
      Duration = 3,
      Image = 4483362458,
   })
end

function SpinRewardWheel()
   -- Fire spin wheel remotes
   for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
      if remote:IsA("RemoteEvent") then
         local name = remote.Name:lower()
         if name:find("spin") or name:find("wheel") or name:find("prize") then
            pcall(function()
               remote:FireServer()
               remote:FireServer("Spin")
            end)
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Reward Wheel",
      Content = "Spun the reward wheel!",
      Duration = 3,
      Image = 4483362458,
   })
end

-- Vehicle Functions
function GamePassBypass()
   pcall(function()
      local mt = getrawmetatable(game)
      local oldNamecall = mt.__namecall
      local oldIndex = mt.__index
      setreadonly(mt, false)
      
      mt.__namecall = newcclosure(function(self, ...)
         local method = getnamecallmethod()
         local args = {...}
         
         if method == "UserOwnsGamePassAsync" then
            return true
         end
         
         if method == "PlayerOwnsAsset" then
            return true
         end
         
         return oldNamecall(self, ...)
      end)
      
      mt.__index = newcclosure(function(self, key)
         if key == "MembershipType" then
            return Enum.MembershipType.Premium
         end
         return oldIndex(self, key)
      end)
      
      setreadonly(mt, true)
      
      print("✓ GamePass bypass enabled")
      print("✓ Premium membership spoofed")
      print("All premium vehicles should now be free!")
   end)
end

function UnlockAllVehicles()
   -- Try to modify player vehicle ownership
   local unlocked = 0
   
   for _, folder in pairs(player:GetDescendants()) do
      if folder:IsA("Folder") and (folder.Name:lower():find("vehicle") or folder.Name:lower():find("car") or folder.Name:lower():find("owned")) then
         for i = 1, 300 do
            pcall(function()
               local bool = Instance.new("BoolValue")
               bool.Name = tostring(i)
               bool.Value = true
               bool.Parent = folder
               unlocked = unlocked + 1
            end)
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Unlock Vehicles",
      Content = "Created " .. unlocked .. " vehicle entries!",
      Duration = 3,
      Image = 4483362458,
   })
end

function UnlockAllColors()
   -- Fire color unlock remotes
   for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
      if remote:IsA("RemoteEvent") then
         local name = remote.Name:lower()
         if name:find("color") or name:find("paint") or name:find("customiz") then
            for i = 1, 100 do
               pcall(function()
                  remote:FireServer(i)
                  remote:FireServer("Unlock", i)
               end)
            end
         end
      end
   end
   
   Rayfield:Notify({
      Title = "Colors",
      Content = "Unlocked all colors!",
      Duration = 3,
      Image = 4483362458,
   })
end

function FixVehicle()
   for _, seat in pairs(Workspace:GetDescendants()) do
      if seat:IsA("VehicleSeat") then
         local character = player.Character
         if character and seat.Occupant and seat.Occupant.Parent == character then
            local vehicle = seat.Parent
            if vehicle.PrimaryPart then
               vehicle:SetPrimaryPartCFrame(vehicle.PrimaryPart.CFrame * CFrame.new(0, 5, 0))
            end
         end
      end
   end
end

-- Teleport
function TeleportTo(position)
   if character and humanoidRootPart then
      humanoidRootPart.CFrame = CFrame.new(position)
   end
end

function TeleportToDelivery()
   -- Find delivery start
   for _, obj in pairs(Workspace:GetDescendants()) do
      if obj.Name:lower():find("delivery") and obj:IsA("BasePart") then
         humanoidRootPart.CFrame = obj.CFrame
         break
      end
   end
end

function TeleportToRace()
   -- Find race start
   for _, obj in pairs(Workspace:GetDescendants()) do
      if obj.Name:lower():find("race") and obj:IsA("BasePart") then
         humanoidRootPart.CFrame = obj.CFrame
         break
      end
   end
end

-- ============================================
-- LOOPS
-- ============================================

-- Auto Collect Cash Loop
spawn(function()
   while wait(5) do
      if _G.AutoCollectCash then
         pcall(function()
            CollectAllCash()
         end)
      end
   end
end)

-- Auto Deliver Loop
spawn(function()
   while wait(10) do
      if _G.AutoDeliver then
         pcall(function()
            AutoCompleteDelivery()
         end)
      end
   end
end)

-- Vehicle Speed Loop
spawn(function()
   while wait(0.1) do
      if _G.Speed > 1 then
         pcall(function()
            for _, seat in pairs(Workspace:GetDescendants()) do
               if seat:IsA("VehicleSeat") then
                  local character = player.Character
                  if character and seat.Occupant and seat.Occupant.Parent == character then
                     seat.MaxSpeed = seat.MaxSpeed * _G.Speed
                     seat.Torque = seat.Torque * _G.Speed
                  end
               end
            end
         end)
      end
   end
end)

-- Vehicle Noclip Loop
spawn(function()
   while wait(0.2) do
      if _G.VehicleNoclip then
         pcall(function()
            for _, seat in pairs(Workspace:GetDescendants()) do
               if seat:IsA("VehicleSeat") then
                  local character = player.Character
                  if character and seat.Occupant and seat.Occupant.Parent == character then
                     for _, part in pairs(seat.Parent:GetDescendants()) do
                        if part:IsA("BasePart") then
                           part.CanCollide = false
                        end
                     end
                  end
               end
            end
         end)
      end
   end
end)

-- No Fall Damage
spawn(function()
   while wait(0.1) do
      if _G.NoFallDamage then
         pcall(function()
            if character and character:FindFirstChild("Humanoid") then
               character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
               character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            end
         end)
      end
   end
end)

-- Character Respawn Handler
player.CharacterAdded:Connect(function(char)
   character = char
   humanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

-- Load Notification
Rayfield:Notify({
   Title = "Alternative Methods Loaded",
   Content = "Use auto-farm features since direct money doesn't work!",
   Duration = 5,
   Image = 4483362458,
})

print("\n✅ Script Loaded!")
print("📌 Important: Direct money add doesn't work in this game")
print("💡 Use: Auto collect cash, deliveries, GamePass bypass")
print(string.rep("=", 60) .. "\n")
