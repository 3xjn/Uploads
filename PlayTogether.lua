local list = {
    [139121289] = true; -- 3xjn
    [102102634] = true -- d0xycycl1n3
}

local plrs = game.Players
local lplr = plrs.LocalPlayer
local sound = Instance.new("Sound")
sound.Volume = 1.5
sound.MaxDistance = math.huge
sound.Looped = true
sound.Parent = workspace

function message(msg)
    game:GetService('StarterGui'):SetCore("ChatMakeSystemMessage",
		{
			Text = msg,
			Color = BrickColor.new("Gold").Color,
			Font = Enum.Font.SourceSansBold,
			FontSize = Enum.FontSize.Size10,
		}
	);
end

local round = function(num, numDecimalPlaces)
	local mult = 10 ^ (numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

local commands = {
    ["play "] = function(msg)
        local id = tonumber(string.sub(msg, 6, string.len(msg)))
        if id then
            lplr.OsPlatform = id
        end
    end;
    ["vol "] = function(msg) 
        local num = tonumber(string.sub(msg, 5, string.len(msg)))
        if num then
            sound.Volume = num
        end
    end;
    ["stop"] = function()
        sound:Pause()
    end;
    ["pause"] = function()
        sound:Pause()
    end;
    ["resume"] = function()
        sound:Play()
    end;
    ["play"] = function()
        sound:Play()
    end
}

lplr.Chatted:Connect(function(msg)
    lplr.OsPlatform = msg
end)

function check(p)
    if list[p.UserId] then
        p.Changed:Connect(function(state)
            if state == "OsPlatform" then
                for command, func in pairs(commands) do
                    local len = string.len(command)
                    local a = string.sub(msg, 1, len)
                    if a == command then
                        wait()
                        func(msg)
                    end
                end
            end
        end)
    end
end

for _, a in pairs(game.Players:GetPlayers()) do check(a) end
plrs.PlayerAdded:Connect(function(a) check(a) end)
