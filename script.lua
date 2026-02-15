-- Car Driving Indonesia - Instant Money Farm
-- Rayfield UI Version
-- Based on Atomicals UI Style

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "CDI Money Farm",
   LoadingTitle = "Car Driving Indonesia",
   LoadingSubtitle = "Instant Money System",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "CDI_Money"
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false,
})

-- Variables
local player = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")

-- Money Farm Settings
_G.MoneyFarm = false
_G.MoneyAmount = 10000
_G.FarmSpeed = 0.1

-- Main Tab
local MainTab = Window:CreateTab("💰 Money Farm", 4483362458)
local Section = MainTab:CreateSection("Instant Money System")

-- Toggle Get Money (Instant)
local MoneyToggle = MainTab:CreateToggle({
   Name = "Get Money (Instant)",
   CurrentValue = false,
   Flag = "GetMoneyInstant",
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
local AmountSlider = MainTab:CreateSlider({
   Name = "Money Per Loop",
   Range = {1000, 100000},
   Increment = 1000,
   Suffix = " C$",
   CurrentValue = 10000,
   Flag = "MoneyAmount",
   Callback = function(Value)
      _G.MoneyAmount = Value
   end,
})

-- Farm Speed Slider
local SpeedSlider = MainTab:CreateSlider({
   Name = "Farm Speed (Lower = Faster)",
   Range = {0.01, 1},
   Increment = 0.01,
   Suffix = "s",
   CurrentValue = 0.1,
   Flag = "FarmSpeed",
   Callback = function(Value)
      _G.FarmSpeed = Value
   end,
})

-- Quick Money Buttons
MainTab:CreateSection("Quick Money")

MainTab:CreateButton({
   Name = "Get 100K Instantly",
   Callback = function()
      pcall(function()
         FireMoneyRemotes(100000)
      end)
      Rayfield:Notify({
         Title = "Quick Money",
         Content = "Sent 100K money request!",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

MainTab:CreateButton({
   Name = "Get 500K Instantly",
   Callback = function()
      pcall(function()
         FireMoneyRemotes(500000)
      end)
      Rayfield:Notify({
         Title = "Quick Money",
         Content = "Sent 500K money request!",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

MainTab:CreateButton({
   Name = "Get 1M Instantly",
   Callback = function()
      pcall(function()
         FireMoneyRemotes(1000000)
      end)
      Rayfield:Notify({
         Title = "Quick Money",
         Content = "Sent 1M money request!",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

-- Debug Tab
local DebugTab = Window:CreateTab("🔍 Debug", 4483362458)

DebugTab:CreateButton({
   Name = "Find Money Remotes",
   Callback = function()
      print("\n=== CDI MONEY REMOTES ===")
      local found = 0
      
      for _, remote in pairs(RS:GetDescendants()) do
         if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            local name = remote.Name:lower()
            if name:find("money") or name:find("cash") or name:find("coin") or name:find("currency") or name:find("reward") then
               found = found + 1
               print(found .. ". " .. remote:GetFullName())
            end
         end
      end
      
      print("=== TOTAL: " .. found .. " REMOTES ===\n")
      
      Rayfield:Notify({
         Title = "Debug",
         Content = "Found " .. found .. " money remotes. Check F9!",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

DebugTab:CreateButton({
   Name = "Check Current Money",
   Callback = function()
      local money = "Unknown"
      
      if player:FindFirstChild("leaderstats") then
         for _, stat in pairs(player.leaderstats:GetChildren()) do
            if stat.Name:lower():find("money") or stat.Name:lower():find("cash") then
               money = stat.Value
               break
            end
         end
      end
      
      Rayfield:Notify({
         Title = "Current Money",
         Content = "You have: " .. tostring(money) .. " C$",
         Duration = 5,
         Image = 4483362458,
      })
      
      print("Current Money: " .. tostring(money))
   end,
})

-- Money Farm Functions
function FireMoneyRemotes(amount)
   local remotesFired = 0
   
   -- Method 1: Try common CDI remote patterns
   local commonNames = {
      "RemoteEvent",
      "MoneyEvent", 
      "CashEvent",
      "AddMoney",
      "GiveMoney",
      "Remotes",
      "Events"
   }
   
   for _, name in pairs(commonNames) do
      if RS:FindFirstChild(name) then
         local remote = RS[name]
         
         if remote:IsA("RemoteEvent") then
            pcall(function()
               remote:FireServer("AddMoney", amount)
               remote:FireServer("Money", amount)
               remote:FireServer(amount)
               remotesFired = remotesFired + 1
            end)
         elseif remote:IsA("Folder") then
            -- Check inside folders
            for _, child in pairs(remote:GetChildren()) do
               if child:IsA("RemoteEvent") then
                  pcall(function()
                     child:FireServer("AddMoney", amount)
                     child:FireServer("Money", amount)
                     child:FireServer(amount)
                     remotesFired = remotesFired + 1
                  end)
               end
            end
         end
      end
   end
   
   -- Method 2: Fire all money-related remotes
   for _, remote in pairs(RS:GetDescendants()) do
      if remote:IsA("RemoteEvent") then
         local name = remote.Name:lower()
         if name:find("money") or name:find("cash") or name:find("coin") or name:find("currency") or name:find("reward") then
            pcall(function()
               remote:FireServer(amount)
               remote:FireServer("Add", amount)
               remote:FireServer("Give", amount)
               remote:FireServer({Amount = amount})
               remote:FireServer({Money = amount})
               remotesFired = remotesFired + 1
            end)
         end
      end
   end
   
   -- Method 3: Update leaderstats directly
   pcall(function()
      if player:FindFirstChild("leaderstats") then
         for _, stat in pairs(player.leaderstats:GetChildren()) do
            if stat.Name:lower():find("money") or stat.Name:lower():find("cash") then
               stat.Value = stat.Value + amount
            end
         end
      end
   end)
   
   return remotesFired
end

-- Main Money Farm Loop
spawn(function()
   while wait(_G.FarmSpeed) do
      if _G.MoneyFarm then
         pcall(function()
            FireMoneyRemotes(_G.MoneyAmount)
         end)
      end
   end
end)

-- Keep leaderstats updated loop
spawn(function()
   while wait(0.5) do
      if _G.MoneyFarm then
         pcall(function()
            if player:FindFirstChild("leaderstats") then
               for _, stat in pairs(player.leaderstats:GetChildren()) do
                  local name = stat.Name:lower()
                  if name:find("money") or name:find("cash") or name:find("coin") then
                     -- Keep incrementing
                     stat.Value = stat.Value + (_G.MoneyAmount / 2)
                  end
               end
            end
         end)
      end
   end
end)

-- Data Save Loop (Auto-save every 5 seconds)
spawn(function()
   while wait(5) do
      if _G.MoneyFarm then
         pcall(function()
            -- Fire save remotes
            for _, remote in pairs(RS:GetDescendants()) do
               if remote:IsA("RemoteEvent") then
                  local name = remote.Name:lower()
                  if name:find("save") or name:find("data") or name:find("update") then
                     remote:FireServer()
                     remote:FireServer("Save")
                     remote:FireServer({Action = "Save"})
                  end
               end
            end
         end)
      end
   end
end)

Rayfield:Notify({
   Title = "CDI Money Farm",
   Content = "Script loaded! Toggle 'Get Money (Instant)' to start!",
   Duration = 5,
   Image = 4483362458,
})

print("CDI Instant Money Farm Loaded!")
print("Toggle 'Get Money (Instant)' to start farming!")
