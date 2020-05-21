local list = {
    [139121289] = true; -- 3xjn
    [102102634] = true; -- d0xycycl1n3
    [56712363] = true
}

local plrs = game.Players
local lplr = plrs.LocalPlayer
local sound = workspace:FindFirstChildOfClass("Sound")

if not sound then
    sound = Instance.new("Sound")
    sound.Volume = 1.5
    sound.MaxDistance = math.huge
    sound.Looped = true
    sound.Parent = workspace
end

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
            sound.SoundId = "rbxassetid://" .. id
            local start = tick()
            local done;
            repeat if tick()-start > 5 then done = true end wait() until sound.IsLoaded or done
            if done then
                message("Error loading music.")
            else
                sound:Play()
                message("Now playing " .. id .. ".")
            end
        end
    end;
    ["vol "] = function(msg) 
        local num = tonumber(string.sub(msg, 5, string.len(msg)))
        if num then
            sound.Volume = num
            message("Volume set to " .. num .. ".")
        end
    end;
    ["stop"] = function()
        sound:Pause()
        message("Song paused.")
    end;
    ["pause"] = function()
        sound:Pause()
        message("Song paused.")
    end;
    ["resume"] = function()
        sound:Play()
        message("Song resumed.")
    end;
    ["play"] = function()
        sound:Play()
        message("Song resumed.")
    end
}

lplr.Chatted:Connect(function(msg)
    wait()
    lplr.OsPlatform = msg
end)

function check(p)
    if list[p.UserId] then
        p.Changed:Connect(function(state)
            if state == "OsPlatform" then
                local msg = p.OsPlatform
                for command, func in pairs(commands) do
                    local len = string.len(command)
                    local a = string.sub(msg, 1, len)
                    if a == command then
                        func(msg)
                        break
                    end
                end
            end
        end)
    end
end

for _, a in pairs(game.Players:GetPlayers()) do check(a) end
plrs.PlayerAdded:Connect(function(a) check(a) end)
