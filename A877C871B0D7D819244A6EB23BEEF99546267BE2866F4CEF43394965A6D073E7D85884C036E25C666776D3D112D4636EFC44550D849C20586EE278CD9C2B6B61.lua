-- Legacy UI Version

if not game:IsLoaded() then game.Loaded:Wait() end

local DiscordInv = "tU87b6w" -- Change to your invite (WITHOUT "discord.gg/")

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local InputService = game:GetService("UserInputService")
local InputManager
if _G.apDefault == true then
InputManager = game:GetService("VirtualInputManager")
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/uwuware-ui/main/main.lua"))()

local Client = game:GetService("Players").LocalPlayer
local PlayerGui = Client:WaitForChild("PlayerGui")

local InputFolder = Client:WaitForChild("Input")
local Keybinds = InputFolder:WaitForChild("Keybinds")

local Marked = {}

local KeysTable = {
    ["4"] = {"Up", "Down", "Left", "Right"},
    ["6"] = {S = "L3", D = "L2", F = "L1", J = "R1", K = "R2", L = "R3"},
    ["7"] = {S = "L3", D = "L2", F = "L1", Space = "Space", J = "R1", K = "R2", L = "R3"},
    ["9"] = {A = "L4", S = "L3", D = "L2", F = "L1", Space = "Space", H = "R1", J = "R2", K = "R3", L = "R4"}
}

local mt = getrawmetatable(game)
make_writeable(mt)

local namecall = mt.__namecall

RunService.Heartbeat:Connect(function()

    if not Library.flags.AutoPlayer then return end
    if not Menu or not Menu.Parent then return end
    if Menu.Config.TimePast.Value <= 0 then return end
    InputManager = game:GetService("VirtualInputManager")
    
    local SideMenu = Menu.Game:FindFirstChild(Menu.PlayerSide.Value)
    local IncomingArrows = SideMenu.Arrows.IncomingNotes

    local Keys = KeysTable[tostring(#IncomingArrows:GetChildren())] or IncomingArrows:GetChildren()

    for Key, Direction in pairs(Keys) do
        Direction = tostring(Direction)

        local ArrowsHolder = IncomingArrows:FindFirstChild(Direction) or IncomingArrows:FindFirstChild(Key)
        if not ArrowsHolder then continue end

        for _, Object in ipairs(ArrowsHolder:GetChildren()) do
            if table.find(Marked, Object) then continue end
            local Keybind = Keybinds:FindFirstChild(Direction) and Keybinds[Direction].Value

            local Start = SideMenu.Arrows:FindFirstChild(Direction) and SideMenu.Arrows[Direction].AbsolutePosition.Y or SideMenu.Arrows[Key].AbsolutePosition.Y
            local Current = Object.AbsolutePosition.Y
            local Difference = not InputFolder.Downscroll.Value and (Current - Start) or (Start - Current)

            local IsHell = Object:FindFirstChild("HellNote") and Object:FindFirstChild("HellNote").Value
            local OnMiss = Object:FindFirstChild("GimmickNotes") and Object:FindFirstChild("GimmickNotes").Value

            if Difference <= 0.35 and not IsHell then
                Marked[#Marked + 1] = Object

                InputManager:SendKeyEvent(true, Enum.KeyCode[Keybind], false, nil)
                repeat task.wait() until not Object or not Object:FindFirstChild("Frame") or Object.Frame.Bar.Size.Y.Scale <= 0
                InputManager:SendKeyEvent(false, Enum.KeyCode[Keybind], false, nil)
            end
        end
    end
end)

PlayerGui.ChildAdded:Connect(function(Object)
    if Object:IsA("ScreenGui") and Object:FindFirstChild("Game") then
        table.clear(Marked)
        getgenv().Menu = Object
    end
end)

for _, ScreenGui in ipairs(PlayerGui:GetChildren()) do
    if not ScreenGui:FindFirstChild("Game") then continue end
    getgenv().Menu = ScreenGui
end

do
    local Window = Library:CreateWindow("Friday Night Bloxxin'") do
        local Folder = Window:AddFolder("Autoplayer") do
            local Toggle = Folder:AddToggle({text = "AutoPlayer", state = _G.apDefault, flag = "AutoPlayer" })
        end
        
        Folder:AddLabel({text = "Final Update (11/06/22):"})
    Folder:AddLabel({text = "Discontinued"})
	Folder:AddLabel({text = "Open Source"})
        Folder:AddLabel({text = " "})
        Folder:AddLabel({text = "Credits:"})
        Folder:AddLabel({text = "Edited by KiwisASkid"})
        Folder:AddLabel({text = "Made by Malware10"})
        Window:AddBind({text = "Menu toggle", key = Enum.KeyCode.Delete, callback = function() Library:Close() end })
        Window:AddButton({text = "DestroyGui", callback = function()
            pcall(function()
                RunService:ClearAllChildren()
                HttpService:GenerateGUID(false)
                game:GetService("CoreGui").ScreenGui:Destroy()
            end)
        end})
        Window:AddButton({text = "Instant Solo", callback = function()
            pcall(function()
                PlayerGui.SingleplayerUI.ButtonPressed:FireServer()
            end)
        end})
    end
    Library:Init()
end

local Old; Old = hookmetamethod(game, "__newindex", newcclosure(function(self, ...)
    local Args = {...}
    local Property = Args[1]

    if not Client.Character then return end
    local Humanoid = Client.Character:FindFirstChild("Humanoid")
    if not Humanoid then return end

    if self == Humanoid and Property == "Health" and not checkcaller() then return end
    
    return Old(self, ...)
end))

if req and _G.joinDiscord == true then
req({
Url = 'http://127.0.0.1:6463/rpc?v=1',
Method = 'POST',
Headers = {
['Content-Type'] = 'application/json',
Origin = 'https://discord.com'
},
Body = http:JSONEncode({
cmd = 'INVITE_BROWSER',
nonce = http:GenerateGUID(false),
args = {code = DiscordInv}
})
})
else if not req and _G.joinDiscord == true then
    setclipboard("discord.gg/"..DiscordInv)
    game.StarterGui:SetCore("SendNotification", {Title = "Notification", Text = "Invite copied.", Duration = 4,})
end
end

game.StarterGui:SetCore("SendNotification", {Title = "Notification", Text = "Script loaded!", Duration = 4,})
