-- [[ MÈO BÉO HUB V1 - PHIÊN BẢN ĐỘC QUYỀN 2014 ]]
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- 1. THIẾT LẬP MÃ KEY MỚI
getgenv().Key = "meobeohub2014"

-- 2. THƯ VIỆN GIAO DIỆN (MARU PURPLE STYLE)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Mèo Béo Hub 🐱 - Key: " .. getgenv().Key, "PurpleTheme")

-- 3. BIẾN ĐIỀU KHIỂN
_G.AutoFarm = false
_G.BringMob = false
_G.AutoChest = false
_G.AutoStats = false

-- 4. HÀM BAY (TWEEN SERVICE)
function TweenTo(Target)
    local Character = game.Players.LocalPlayer.Character
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        local Distance = (Target.p - Character.HumanoidRootPart.Position).Magnitude
        local Speed = 280 
        game:GetService("TweenService"):Create(Character.HumanoidRootPart, TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear), {CFrame = Target}):Play()
    end
end

-- 5. GIAO DIỆN CHÍNH
local Main = Window:NewTab("Auto Farm")
local FarmSection = Main:NewSection("Cày Cấp & Gom Quái")

FarmSection:NewToggle("Auto Farm Level", "Tự đánh quái xung quanh", function(state)
    _G.AutoFarm = state
end)

FarmSection:NewToggle("Bring Mobs (Gom Quái)", "Hút quái lại 1 chỗ", function(state)
    _G.BringMob = state
end)

local Misc = Window:NewTab("Tiện Ích & Stats")
local MiscSection = Misc:NewSection("Kiếm Tiền & Cộng Điểm")

MiscSection:NewToggle("Auto Farm Chest", "Bay nhặt rương lấy tiền", function(state)
    _G.AutoChest = state
end)

MiscSection:NewToggle("Auto Stats (Melee)", "Tự cộng điểm vào Đấm", function(state)
    _G.AutoStats = state
end)

-- 6. HỆ THỐNG TỰ ĐỘNG CỘNG ĐIỂM
spawn(function()
    while task.wait(1) do
        if _G.AutoStats then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", 3)
        end
    end
end)

-- 7. HỆ THỐNG NHẶT RƯƠNG
spawn(function()
    while task.wait() do
        if _G.AutoChest then
            pcall(function()
                for _, v in pairs(game.Workspace:GetChildren()) do
                    if v:IsA("Part") and v.Name:find("Chest") then
                        TweenTo(v.CFrame)
                        task.wait(0.5)
                    end
                end
            end)
        end
    end
end)

-- 8. HỆ THỐNG FARM QUÁI & GOM QUÁI
spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
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
            end)
        end
    end
end)

-- 9. ANTI-AFK & THÔNG TIN
game:service'Players'.LocalPlayer.Idled:connect(function()
    game:service'VirtualUser':CaptureController()
    game:service'VirtualUser':ClickButton2(Vector2.new())
end)

local Info = Window:NewTab("Credits")
Info:NewSection("Bản quyền: Mèo Béo Premium")
Info:NewSection("Mã Key: " .. getgenv().Key .. " ✅")

Library:Notify("Mèo Béo Hub", "Đã kích hoạt với Key: meobeohub2014", 5)
