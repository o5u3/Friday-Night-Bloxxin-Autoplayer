-- New UI Version

if not game:IsLoaded() then game.Loaded:Wait() end

local DiscordInv = "tU87b6w" -- Change to your invite (WITHOUT "discord.gg/")

local HttpService = game:GetService("HttpService");
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local InputService = game:GetService("UserInputService")
local InputManager
if _G.apDefault == true then
InputManager = game:GetService("VirtualInputManager")
end

local Client = game:GetService("Players").LocalPlayer
local PlayerGui = Client:WaitForChild("PlayerGui")

local InputFolder = Client:WaitForChild("Input")
local Keybinds = InputFolder:WaitForChild("Keybinds")

local Old
local LP = Players.LocalPlayer

local Marked = {}

local KeysTable = {
    ["4"] = {"Up", "Down", "Left", "Right"},
    ["6"] = {S = "L3", D = "L2", F = "L1", J = "R1", K = "R2", L = "R3"},
    ["7"] = {S = "L3", D = "L2", F = "L1", Space = "Space", J = "R1", K = "R2", L = "R3"},
    ["9"] = {A = "L4", S = "L3", D = "L2", F = "L1", Space = "Space", H = "R1", J = "R2", K = "R3", L = "R4"}
}

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

local function AP()
    RunService.Heartbeat:Connect(function()
        if not tog then return end
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
                
                if Difference <= .30 and not IsHell then
                    Marked[#Marked + 1] = Object
                    
                    InputManager:SendKeyEvent(true, Enum.KeyCode[Keybind], false, nil)
                    repeat task.wait() until not Object or not Object:FindFirstChild("Frame") or Object.Frame.Bar.Size.Y.Scale <= 0
                    InputManager:SendKeyEvent(false, Enum.KeyCode[Keybind], false, nil)
                end
            end
        end
    end)
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/Splix"))()

local window = library:new({
    textsize = 13.5,
    font = Enum.Font.RobotoMono,
    name = "KiwisASkid's FNB' Auto-Player | Discontinued",
    color = Color3.fromRGB(225,58,81)
})

local tab = window:page({name = "Main"})
local GuiSets = window:page({name = "Gui"})
local tab2 = window:page({name = "Extra"})

local section1 = tab:section({name = "Scripts",side = "left",size = 250})
local sectionT21 = tab2:section({name = "Scripts",side = "left",size = 250})
local sectionTGS1 = GuiSets:section({name = "Scripts",side = "left",size = 250})

-- Tab 1
if _G.apDefault == true then
    tog = true
    AP()
end
section1:toggle({name = "Auto-Player",def = _G.apDefault,callback = function(value)
    tog = value
    AP()
end})

section1:button({name = "Instant Solo",callback = function()
    PlayerGui.SingleplayerUI.ButtonPressed:FireServer()
end})

-- Tab 2
sectionT21:button({name = "Rejoin",callback = function()
    game.StarterGui:SetCore("SendNotification", {Title = "Notification", Text = "Rejoining...", Duration = 4,})
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LP)
 end})

 sectionT21:button({name = "Unload Script",callback = function()
    tog = false
    RunService:ClearAllChildren()
    HttpService:GenerateGUID(false)
    game.StarterGui:SetCore("SendNotification", {Title = "Notification", Text = "Unloaded running scripts.", Duration = 4,})
 end})

-- Gui Sets
sectionTGS1:keybind({name = "UI Toggle Bind",def = nil,callback = function(key)
   window.key = key
end})

Old = hookmetamethod(game, "__newindex", newcclosure(function(self, ...)
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
