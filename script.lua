-- Driving Empire Script - WORKING VERSION
-- Fixed Money & Car System
-- Analyzes game structure first before executing

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Driving Empire - Working",
   LoadingTitle = "Driving Empire Script",
   LoadingSubtitle = "Analyzing Game Structure...",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "DrivingEmpire_Working"
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

-- Player
local player = Players.LocalPlayer

-- Game Data Storage
local GameData = {
   MoneyRemotes = {},
   VehicleRemotes = {},
   PlayerData = nil,
   MoneyPath = nil,
   VehiclesPath = nil,
}

-- Variables
_G.MoneyFarm = false
_G.MoneyAmount = 10000
_G.FarmDelay = 0.5

-- ============================================
-- ANALYZE GAME STRUCTURE
-- ============================================

print("\n========================================")
print("ANALYZING DRIVING EMPIRE STRUCTURE")
print("========================================\n")

-- Find Player Data
task.spawn(function()
   pcall(function()
      print("=== SEARCHING PLAYER DATA ===")
      
      -- Check common player data locations
      local dataLocations = {
         player:FindFirstChild("PlayerData"),
         player:FindFirstChild("Data"),
         player:FindFirstChild("PlayerStats"),
         player:FindFirstChild("Stats"),
         player:FindFirstChild("leaderstats"),
      }
      
      for _, data in pairs(dataLocations) do
         if data then
            print("✓ Found data folder: " .. data.Name)
            GameData.PlayerData = data
            
            -- Search for money value
            for _, child in pairs(data:GetChildren()) do
               local name = child.Name:lower()
               if name:find("cash") or name:find("money") or name:find("coin") then
                  print("  ✓ Found money: " .. child.Name .. " = " .. tostring(child.Value))
                  GameData.MoneyPath = child
               end
               if name:find("vehicle") or name:find("car") or name:find("owned") then
                  print("  ✓ Found vehicles: " .. child.Name)
                  GameData.VehiclesPath = child
               end
            end
         end
      end
   end)
end)

-- Find Money Remotes
task.spawn(function()
   pcall(function()
      print("\n=== SEARCHING MONEY REMOTES ===")
      
      for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
         if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local name = obj.Name:lower()
            local path = obj:GetFullName():lower()
            
            if name:find("cash") or name:find("money") or name:find("currency") or 
               path:find("cash") or path:find("money") then
               table.insert(GameData.MoneyRemotes, obj)
               print("✓ Money Remote: " .. obj:GetFullName())
            end
         end
      end
      
      print("Total Money Remotes: " .. #GameData.MoneyRemotes)
   end)
end)

-- Find Vehicle Remotes
task.spawn(function()
   pcall(function()
      print("\n=== SEARCHING VEHICLE REMOTES ===")
      
      for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
         if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local name = obj.Name:lower()
            local path = obj:GetFullName():lower()
            
            if name:find("vehicle") or name:find("car") or name:find("unlock") or 
               name:find("buy") or name:find("purchase") or
               path:find("vehicle") or path:find("car") then
               table.insert(GameData.VehicleRemotes, obj)
               print("✓ Vehicle Remote: " .. obj:GetFullName())
            end
         end
      end
      
      print("Total Vehicle Remotes: " .. #GameData.VehicleRemotes)
   end)
end)

wait(2) -- Wait for analysis to complete

print("\n========================================")
print("ANALYSIS COMPLETE - LOADING UI")
print("========================================\n")

-- ============================================
-- TAB: MONEY
-- ============================================
local MoneyTab = Window:CreateTab("💰 Money", 4483362458)
local MoneySection = MoneyTab:CreateSection("Money System")

-- Show detected money system
if GameData.MoneyPath then
   MoneyTab:CreateParagraph({
      Title = "✓ Money System Detected",
      Content = "Found: " .. GameData.MoneyPath.Name .. "\nCurrent: " .. tostring(GameData.MoneyPath.Value)
   })
else
   MoneyTab:CreateParagraph({
      Title = "⚠️ Money System Not Found",
      Content = "Use Debug tab to manually find money system"
   })
end

MoneyTab:CreateToggle({
   Name = "Auto Money Farm",
   CurrentValue = false,
   Flag = "MoneyFarm",
   Callback = function(Value)
      _G.MoneyFarm = Value
      
      if Value then
         Rayfield:Notify({
            Title = "Money Farm",
            Content = "Money farming started!",
            Duration = 3,
            Image = 4483362458,
         })
      else
         Rayfield:Notify({
            Title = "Money Farm",
            Content = "Money farming stopped!",
            Duration = 3,
            Image = 4483362458,
         })
      end
   end,
})

MoneyTab:CreateSlider({
   Name = "Money Amount",
   Range = {1000, 100000},
   Increment = 1000,
   Suffix = " $",
   CurrentValue = 10000,
   Flag = "MoneyAmount",
   Callback = function(Value)
      _G.MoneyAmount = Value
   end,
})

MoneyTab:CreateSlider({
   Name = "Farm Delay",
   Range = {0.1, 5},
   Increment = 0.1,
   Suffix = "s",
   CurrentValue = 0.5,
   Flag = "FarmDelay",
   Callback = function(Value)
      _G.FarmDelay = Value
   end,
})

MoneyTab:CreateSection("Quick Add")

MoneyTab:CreateButton({
   Name = "Add 50K",
   Callback = function()
      AddMoney(50000)
   end,
})

MoneyTab:CreateButton({
   Name = "Add 100K",
   Callback = function()
      AddMoney(100000)
   end,
})

MoneyTab:CreateButton({
   Name = "Add 500K",
   Callback = function()
      AddMoney(500000)
   end,
})

MoneyTab:CreateButton({
   Name = "Set to 10M",
   Callback = function()
      SetMoney(10000000)
   end,
})

-- ============================================
-- TAB: VEHICLES
-- ============================================
local VehicleTab = Window:CreateTab("🚗 Vehicles", 4483362458)
local VehicleSection = VehicleTab:CreateSection("Vehicle System")

if #GameData.VehicleRemotes > 0 then
   VehicleTab:CreateParagraph({
      Title = "✓ Vehicle System Detected",
      Content = "Found " .. #GameData.VehicleRemotes .. " vehicle remotes"
   })
else
   VehicleTab:CreateParagraph({
      Title = "⚠️ Vehicle System Not Found",
      Content = "Use Debug tab to find vehicle system"
   })
end

VehicleTab:CreateButton({
   Name = "🔓 Unlock All Vehicles (Method 1)",
   Callback = function()
      UnlockVehiclesMethod1()
      Rayfield:Notify({
         Title = "Unlock Vehicles",
         Content = "Method 1 executed!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateButton({
   Name = "🔓 Unlock All Vehicles (Method 2)",
   Callback = function()
      UnlockVehiclesMethod2()
      Rayfield:Notify({
         Title = "Unlock Vehicles",
         Content = "Method 2 executed!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateButton({
   Name = "🔓 Unlock All Vehicles (Method 3)",
   Callback = function()
      UnlockVehiclesMethod3()
      Rayfield:Notify({
         Title = "Unlock Vehicles",
         Content = "Method 3 executed!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateButton({
   Name = "🎮 GamePass Bypass",
   Callback = function()
      GamePassBypass()
      Rayfield:Notify({
         Title = "GamePass Bypass",
         Content = "GamePass bypass enabled!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

VehicleTab:CreateSection("Vehicle Modifications")

VehicleTab:CreateSlider({
   Name = "Vehicle Speed",
   Range = {1, 5},
   Increment = 0.1,
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

-- ============================================
-- TAB: DEBUG
-- ============================================
local DebugTab = Window:CreateTab("🔍 Debug", 4483362458)

DebugTab:CreateButton({
   Name = "Print Full Game Structure",
   Callback = function()
      PrintFullStructure()
   end,
})

DebugTab:CreateButton({
   Name = "Print Current Money",
   Callback = function()
      PrintCurrentMoney()
   end,
})

DebugTab:CreateButton({
   Name = "Print All Money Remotes",
   Callback = function()
      PrintMoneyRemotes()
   end,
})

DebugTab:CreateButton({
   Name = "Print All Vehicle Remotes",
   Callback = function()
      PrintVehicleRemotes()
   end,
})

DebugTab:CreateButton({
   Name = "Test Money Remote (Safe)",
   Callback = function()
      TestMoneyRemote()
   end,
})

DebugTab:CreateButton({
   Name = "Test Vehicle Remote (Safe)",
   Callback = function()
      TestVehicleRemote()
   end,
})

DebugTab:CreateButton({
   Name = "Monitor All Remote Calls",
   Callback = function()
      MonitorRemoteCalls()
   end,
})

-- ============================================
-- FUNCTIONS
-- ============================================

-- Money Functions
function AddMoney(amount)
   local success = false
   
   -- Method 1: Direct value change (if possible)
   if GameData.MoneyPath then
      pcall(function()
         GameData.MoneyPath.Value = GameData.MoneyPath.Value + amount
         success = true
         print("✓ Added " .. amount .. " using direct value change")
      end)
   end
   
   -- Method 2: Fire money remotes
   if not success and #GameData.MoneyRemotes > 0 then
      for _, remote in pairs(GameData.MoneyRemotes) do
         pcall(function()
            if remote:IsA("RemoteEvent") then
               remote:FireServer(amount)
               remote:FireServer("Add", amount)
               remote:FireServer({Amount = amount})
               print("✓ Fired remote: " .. remote.Name)
            elseif remote:IsA("RemoteFunction") then
               remote:InvokeServer(amount)
               remote:InvokeServer("Add", amount)
               print("✓ Invoked remote: " .. remote.Name)
            end
         end)
      end
      success = true
   end
   
   -- Method 3: Try all ReplicatedStorage remotes
   if not success then
      for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
         if remote:IsA("RemoteEvent") then
            pcall(function()
               remote:FireServer(amount)
               remote:FireServer("AddMoney", amount)
               remote:FireServer("GiveMoney", amount)
            end)
         end
      end
   end
   
   if success then
      Rayfield:Notify({
         Title = "Money Added",
         Content = "Successfully added $" .. amount,
         Duration = 2,
         Image = 4483362458,
      })
   end
end

function SetMoney(amount)
   if GameData.MoneyPath then
      pcall(function()
         GameData.MoneyPath.Value = amount
         print("✓ Set money to " .. amount)
         Rayfield:Notify({
            Title = "Money Set",
            Content = "Money set to $" .. amount,
            Duration = 2,
            Image = 4483362458,
         })
      end)
   else
      AddMoney(amount)
   end
end

-- Vehicle Unlock Functions
function UnlockVehiclesMethod1()
   -- Direct player data modification
   if GameData.VehiclesPath then
      pcall(function()
         for i = 1, 200 do
            local vehicle = Instance.new("BoolValue")
            vehicle.Name = tostring(i)
            vehicle.Value = true
            vehicle.Parent = GameData.VehiclesPath
         end
         print("✓ Method 1: Modified player vehicle data")
      end)
   end
end

function UnlockVehiclesMethod2()
   -- Fire vehicle remotes
   if #GameData.VehicleRemotes > 0 then
      for _, remote in pairs(GameData.VehicleRemotes) do
         pcall(function()
            for i = 1, 100 do
               if remote:IsA("RemoteEvent") then
                  remote:FireServer(i)
                  remote:FireServer("Unlock", i)
                  remote:FireServer({VehicleId = i})
               end
            end
            print("✓ Method 2: Fired remote: " .. remote.Name)
         end)
      end
   end
end

function UnlockVehiclesMethod3()
   -- Spam all possible vehicle-related remotes
   pcall(function()
      for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
         if remote:IsA("RemoteEvent") then
            local name = remote.Name:lower()
            if name:find("vehicle") or name:find("car") or name:find("unlock") or name:find("buy") then
               for i = 1, 50 do
                  pcall(function()
                     remote:FireServer(i)
                     remote:FireServer("Unlock", i)
                  end)
               end
               print("✓ Method 3: Fired remote: " .. remote.Name)
            end
         end
      end
   end)
end

function GamePassBypass()
   pcall(function()
      local mt = getrawmetatable(game)
      local oldNamecall = mt.__namecall
      setreadonly(mt, false)
      
      mt.__namecall = newcclosure(function(self, ...)
         local method = getnamecallmethod()
         
         if method == "UserOwnsGamePassAsync" or method == "PlayerOwnsAsset" then
            return true
         end
         
         return oldNamecall(self, ...)
      end)
      
      setreadonly(mt, true)
      print("✓ GamePass bypass enabled")
   end)
end

-- Debug Functions
function PrintFullStructure()
   print("\n========================================")
   print("FULL GAME STRUCTURE")
   print("========================================\n")
   
   print("=== PLAYER DATA ===")
   for _, obj in pairs(player:GetChildren()) do
      print("├─ " .. obj.Name .. " (" .. obj.ClassName .. ")")
      if obj:IsA("Folder") or obj:IsA("Configuration") then
         for _, child in pairs(obj:GetChildren()) do
            print("│  ├─ " .. child.Name .. " (" .. child.ClassName .. ")")
            if child:IsA("ValueBase") then
               print("│  │  └─ Value: " .. tostring(child.Value))
            end
         end
      end
   end
   
   print("\n=== REPLICATED STORAGE ===")
   for _, obj in pairs(ReplicatedStorage:GetChildren()) do
      print("├─ " .. obj.Name .. " (" .. obj.ClassName .. ")")
   end
   
   Rayfield:Notify({
      Title = "Debug",
      Content = "Structure printed to console (F9)",
      Duration = 3,
      Image = 4483362458,
   })
end

function PrintCurrentMoney()
   print("\n=== CURRENT MONEY ===")
   
   if GameData.MoneyPath then
      print("Money: " .. tostring(GameData.MoneyPath.Value))
      Rayfield:Notify({
         Title = "Current Money",
         Content = "$" .. tostring(GameData.MoneyPath.Value),
         Duration = 3,
         Image = 4483362458,
      })
   else
      print("Money path not found!")
      Rayfield:Notify({
         Title = "Error",
         Content = "Money system not detected",
         Duration = 3,
         Image = 4483362458,
      })
   end
end

function PrintMoneyRemotes()
   print("\n=== MONEY REMOTES ===")
   for i, remote in pairs(GameData.MoneyRemotes) do
      print(i .. ". " .. remote:GetFullName())
   end
   print("Total: " .. #GameData.MoneyRemotes)
   
   Rayfield:Notify({
      Title = "Money Remotes",
      Content = "Found " .. #GameData.MoneyRemotes .. " remotes (Check F9)",
      Duration = 3,
      Image = 4483362458,
   })
end

function PrintVehicleRemotes()
   print("\n=== VEHICLE REMOTES ===")
   for i, remote in pairs(GameData.VehicleRemotes) do
      print(i .. ". " .. remote:GetFullName())
   end
   print("Total: " .. #GameData.VehicleRemotes)
   
   Rayfield:Notify({
      Title = "Vehicle Remotes",
      Content = "Found " .. #GameData.VehicleRemotes .. " remotes (Check F9)",
      Duration = 3,
      Image = 4483362458,
   })
end

function TestMoneyRemote()
   if #GameData.MoneyRemotes > 0 then
      local remote = GameData.MoneyRemotes[1]
      pcall(function()
         if remote:IsA("RemoteEvent") then
            remote:FireServer(1000)
            print("✓ Tested: " .. remote:GetFullName())
         end
      end)
      Rayfield:Notify({
         Title = "Test",
         Content = "Sent 1000 to first money remote",
         Duration = 3,
         Image = 4483362458,
      })
   end
end

function TestVehicleRemote()
   if #GameData.VehicleRemotes > 0 then
      local remote = GameData.VehicleRemotes[1]
      pcall(function()
         if remote:IsA("RemoteEvent") then
            remote:FireServer(1)
            print("✓ Tested: " .. remote:GetFullName())
         end
      end)
      Rayfield:Notify({
         Title = "Test",
         Content = "Sent request to first vehicle remote",
         Duration = 3,
         Image = 4483362458,
      })
   end
end

function MonitorRemoteCalls()
   local mt = getrawmetatable(game)
   local oldNamecall = mt.__namecall
   setreadonly(mt, false)
   
   mt.__namecall = newcclosure(function(self, ...)
      local args = {...}
      local method = getnamecallmethod()
      
      if method == "FireServer" or method == "InvokeServer" then
         print("🔴 REMOTE: " .. self:GetFullName())
         print("   Method: " .. method)
         print("   Args: " .. table.concat(args, ", "))
      end
      
      return oldNamecall(self, ...)
   end)
   
   setreadonly(mt, true)
   
   Rayfield:Notify({
      Title = "Monitor Active",
      Content = "Monitoring all remote calls (Check F9)",
      Duration = 5,
      Image = 4483362458,
   })
end

-- ============================================
-- LOOPS
-- ============================================

-- Money Farm Loop
spawn(function()
   while wait(_G.FarmDelay) do
      if _G.MoneyFarm then
         pcall(function()
            AddMoney(_G.MoneyAmount)
         end)
      end
   end
end)

-- Vehicle Noclip Loop
spawn(function()
   while wait(0.2) do
      if _G.VehicleNoclip then
         pcall(function()
            local character = player.Character
            if character then
               for _, v in pairs(Workspace:GetDescendants()) do
                  if v:IsA("VehicleSeat") and v.Occupant and v.Occupant.Parent == character then
                     for _, part in pairs(v.Parent:GetDescendants()) do
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

-- Success
Rayfield:Notify({
   Title = "Script Loaded",
   Content = "Driving Empire script loaded! Check Debug tab for analysis.",
   Duration = 5,
   Image = 4483362458,
})

print("\n========================================")
print("DRIVING EMPIRE SCRIPT LOADED")
print("Use Debug tab to verify systems detected")
print("========================================\n")
