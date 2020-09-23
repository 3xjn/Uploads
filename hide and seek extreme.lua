local library = loadstring(game:HttpGet("https://pastebin.com/raw/qwdPKKDN"))()
local venyxObj;
connection = game:GetService("CoreGui").ChildAdded:Connect(function(obj)
    if obj.Name == "Venyx" then
        venyxObj = obj
        connection:Disconnect()
    end
end)

local venyx = library.new("Venyx", 5013109572)
local values = {
    teleport = false;
}

function copyTable(tbl)
    local tbl2 = {}
    for k, v in pairs(tbl) do
        tbl2[k] = v
    end
    return tbl2
end

function setVal(value, opt)
    values[value] = opt or not values[value]
    return values[value]
end

function findPath(info, line)
    if line then print(line) end
    if typeof(info[1]) ~= "Instance" then print("Starting object wasn't an Instance class type. Returned type -", type(info[i]), "- example:", info[i], DisplayData(info)) return end

    local obj = info[1]
    for i=2, table.getn(info) do
        local found;
        if typeof(info[i]) == "table" then
            found = obj:FindFirstChildOfClass(info[i][1])
        else
            local test;
            pcall(function() test = obj[info[i]] end)
            found = obj:FindFirstChild(info[i]) or test
        end
        
        if found then
            obj = found
        else
            return
        end
    end
    return obj
end

-- themes
local themes = {
    Background = Color3.fromRGB(24, 24, 24),
    Glow = Color3.fromRGB(0, 0, 0),
    Accent = Color3.fromRGB(10, 10, 10),
    LightContrast = Color3.fromRGB(20, 20, 20),
    DarkContrast = Color3.fromRGB(14, 14, 14),  
    TextColor = Color3.fromRGB(255, 255, 255)
}

local gameObjs = workspace.GameObjects

local runService = game:GetService("RunService")
local playerService = game:GetService("Players")

local players = playerService:GetPlayers()
local client = playerService.LocalPlayer
playerService.PlayerAdded:Connect(function(p)
    table.insert(players, p)
end)

playerService.PlayerRemoving:Connect(function(p)
    if players[p] then
        players[p] = nil
    end
end)

local clientChar = client.Character
client.CharacterAdded:Connect(function(char)
    clientChar = char
end)

runService.RenderStepped:Connect(function()
    if values.teleport then
        for a, b in pairs(players) do
            if b and b ~= client then
                local humanoidRoot = findPath({b, "Character", "HumanoidRootPart"})
                print(humanoidRoot)
                if humanoidRoot and clientChar then
                    local clientRoot = findPath({clientChar, "HumanoidRootPart"})
                    if clientRoot then
                        humanoidRoot.CFrame = clientRoot.CFrame
                    end
                end
            end
        end
    end
end)


local page = venyx:addPage("Game", 5012544693)
local section1 = page:addSection("Seeker")

section1:addToggle("Teleport Players", false, function()
    print(setVal("teleport"))
end)

section1:addButton("Coins", function()
    for _, a in pairs(gameObjs:GetChildren()) do
        if a.Name == "Credit" and clientChar and clientChar:FindFirstChild("Head") then
            firetouchinterest(a, clientChar.Head, 0)
        end
    end
end)

local musicProp = {
    SoundId = "id here";
    Volume = 1;
    Pitch = 1;
    Parent = clientChar.HumanoidRootPart
}
local page = venyx:addPage("Music", 302250236)
local section2 = page:addSection("Properties")

local soundBox;
soundBox = section2:addTextbox("SoundId", musicProp.SoundId, function(value, focuslost)
    if focuslost then
        local toNum = tonumber(value)

        if toNum ~= nil then
            musicProp.SoundId = toNum
        else
            section2:updateTextbox(soundBox, "SoundId", tostring(musicProp.SoundId))
        end
    end
end)

section2:addSlider("Volume", musicProp.Volume, 1, 10, function(value)
    musicProp.Volume = value
end) 

local pitchBox;
pitchBox = section2:addTextbox("Pitch", musicProp.Pitch, function(value, focuslost)
    if focuslost then 
        local toNum = tonumber(value)

        if toNum ~= nil then
            musicProp.Pitch = toNum
        else
            section2:updateTextbox(pitchBox, "Pitch", tostring(musicProp.Pitch))
        end
    end
end)

local parentBox;
parentBox = section2:addTextbox("Parent", musicProp.Parent.Name, function(value, focuslost)
    if focuslost then
        local obj = game

        for _, a in pairs(value:split(".")) do
            print(a)
            obj = obj[a]
        end

        if obj then
            musicProp.Parent = obj
        else
            section2:updateTextbox(parentBox, musicProp.Parent.Name)
        end
    end
end)

section2:addButton("Play", function()
    spawn(function()
        print("created instance")
        local instance = Instance.new("Sound")
        for k, v in pairs(musicProp) do
            print("set",k,"equal to",tostring(v))
            instance[k] = v
        end

        local copy = copyTable(musicProp)

        instance.SoundId = "rbxassetid://" .. copy.SoundId
        print("soundid to", instance.SoundId)
        repeat wait() until instance.IsLoaded
        instance:Play()
        print("Playing song and settings soundid to nil")

        copy.SoundId = nil

        game:GetService("ReplicatedStorage").Remotes.PlaySoundOthers:FireServer(id, info)
        print("fire server")
    end)
end)

-- second page
local theme = venyx:addPage("Ui", 5107141151)
local keybinds = theme:addSection("Keybinds")

keybinds:addKeybind("Toggle Keybind", Enum.KeyCode.Tab, function()
   venyx:toggle()
end)


keybinds:addKeybind("Exit", Enum.KeyCode.Delete, function()
    venyxObj:Destroy()
end)

local colors = theme:addSection("Colors")

for theme, color in pairs(themes) do -- all in one theme changer, i know, im cool
    colors:addColorPicker(theme, color, function(color3)
        venyx:setTheme(theme, color3)
    end)
end

-- load
venyx:SelectPage(venyx.pages[1], true) -- no default for more freedom