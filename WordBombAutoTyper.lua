local words = WordBombWords
shared.used_words = shared.used_words or {}
local file;

pcall(function()
	file = readfile("words.txt")
end)

if not file then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Tesseracting/Uploads/master/words.txt"))()
	writefile("words.txt", WordBombWords)
else
	loadstring(file)()
end
words = WordBombWords

local library = loadstring(game:HttpGet("https://pastebin.com/raw/eWKgbdix", true))()
local window = library:CreateWindow('Word Bomber')
local min, max, waittime = 3, 8, 0

local ghfggfhgfhfgh = window:Toggle("Autobot", {flag = "autobot"})
local ghirugurgurgu = window:Toggle("RConsole", {flag = "rconsole"})
local gfdgdfjkgjkdf = window:Box('Minimum Letters', {flag = "min"; type = 'number';}, function(new, old, enter) min = tonumber(new) end)
local sfuiguisfgiuf = window:Box('Maximum Letters', {flag = "max"; type = 'number';}, function(new, old, enter) max = tonumber(new) end)
local fgfggfhfhhhhh = window:Box('Delay', {flag = "waittime"; type = 'number';}, function(new, old, enter) waittime = tonumber(new) end)

local tell = function(Message, Type)
	if Type then Type = string.lower(Type) end
	if window.flags.rconsole then
		if not Type or Type == "print" then
			rconsoleprint(Message .. "\n")
		elseif Type == "warn" then
			rconsolewarn(Message .. "\n")
		elseif Type == "error" then
			rconsoleerr(Message .. "\n")
		end
	else
		if not Type then
			print(Message)
		elseif Type == "warn" then
			warn(Message)
		elseif Type == "error" then
			pcall(function() error(Message) end)
		end
	end
end

function TableCheck(thetable, value)
	for iter, v in pairs(thetable) do
		if v == value or iter == value then
			return true, {iter, value}
		end
	end
	return false
end

function getWord(contains, min, max)
	local AllWords = {}
	for i, b in pairs(words) do
	  if string.len(b) >= min and string.len(b) <= max and string.match(b, contains) and not TableCheck(shared.used_words, b) then
			table.insert(shared.used_words, b)
			return b
	  end
	end
end

while wait(wait) do
	if window.flags["autobot"] then
		local titleframe = game.Players.LocalPlayer.PlayerGui.WordBombUI.UIContainer.StageContainer.PC.TitleFrame
		local title = titleframe.Title.Text
		if string.match(title, "Quick") then
			local contains = string.lower(titleframe.Subtitle.Text)
			local word = getWord(contains, min, max)

			if word then
				tell("Waiting " .. waittime)
				wait(waittime)
				tell("Getting word that contains " .. contains)
				tell("Greater than or equal to " .. min)
				tell("Smaller than or equal to " .. max)
				tell("Got word " .. tostring(word))
				tell("-----------------------")

				game:GetService("ReplicatedStorage").RemoteEvents.StageEvent:FireServer("Typed", string.upper(word))
			elseif not word and string.match(title, "Quick") then
				tell("No word could be found", "error")
			end
		end
	end
end
