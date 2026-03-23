-- [[ MÈO BÉO HUB V1 - FINAL SOURCE ]]
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- 1. THƯ VIỆN UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Mèo Béo Hub 🐱 - meobeohub2014", "PurpleTheme")

-- 2. BIẾN ĐIỀU KHIỂN
_G.AutoFarm = false
_G.BringMob = false
_G.AutoChest = false
_G.AutoStats = false

-- 3. HÀM BAY (TWEEN)
function TweenTo(Target)
    local Character = game.Players.LocalPlayer.Character
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        local Distance = (Target.p - Character.HumanoidRootPart.Position).Magnitude
        local Speed = 280 
        local Tween = game:GetService("TweenService"):Create(Character.HumanoidRootPart, TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear), {CFrame = Target})
        Tween:Play()
        return Tween
    end
end

-- 4. GIAO DIỆN
local Main = Window:NewTab("Auto Farm")
local FarmSection = Main:NewSection("Cày Cấp & Gom Quái")

FarmSection:NewToggle("Auto Farm Level", "Tự đánh quái", function(state)
    _G.AutoFarm = state
end)

FarmSection:NewToggle("Bring Mobs (Gom Quái)", "Hút quái", function(state)
    _G.BringMob = state
end)

local Misc = Window:NewTab("Tiện Ích")
local MiscSection = Misc:NewSection("Stats & Chest")

MiscSection:NewToggle("Auto Farm Chest", "Nhặt rương", function(state)
    _G.AutoChest = state
end)

MiscSection:NewToggle("Auto Stats (Melee)", "Cộng điểm đấm", function(state)
    _G.AutoStats = state
end)

-- 5. CÁC VÒNG LẶP LOGIC
spawn(function()
    while task.wait() do
        pcall(function()
            if _G.AutoFarm then
                local Enemy = game.Workspace.Enemies:FindFirstChildOfClass("Model")
                if Enemy and Enemy:FindFirstChild("HumanoidRootPart") then
                    if _G.BringMob then
                        Enemy.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                        Enemy.HumanoidRootPart.CanCollide = false
                    end
                    TweenTo(Enemy.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0))
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):ClickButton1(Vector2.new(851, 158))
                end
            elseif _G.AutoChest then
                for _, v in pairs(game.Workspace:GetChildren()) do
                    if v:IsA("Part") and v.Name:find("Chest") then
                        TweenTo(v.CFrame)
                        task.wait(0.5)
                        break
                    end
                end
            end
        end)
    end
end)

spawn(function()
    while task.wait(1) do
        if _G.AutoStats then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", 3)
        end
    end
end)

-- 6. ANTI-AFK
game:service'Players'.LocalPlayer.Idled:connect(function()
    game:service'VirtualUser':CaptureController()
    game:service'VirtualUser':ClickButton2(Vector2.new())
end)

Library:Notify("Mèo Béo Hub", "Đã kích hoạt thành công!", 5)
