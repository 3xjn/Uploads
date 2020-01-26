local words = WordBombWords
local used_words = {}
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
local gfdgdfjkgjkdf = window:Box('Minimum Letters', {flag = "min"; type = 'number';}, function(new, old, enter) min = tonumber(new) end)
local sfuiguisfgiuf = window:Box('Maximum Letters', {flag = "max"; type = 'number';}, function(new, old, enter) max = tonumber(new) end)
local fgfggfhfhhhhh = window:Box('Delay', {flag = "waittime"; type = 'number';}, function(new, old, enter) waittime = tonumber(new) end)

function getWord(contains, min, max)
	for i, b in pairs(words) do
	  if string.len(b) >= min and string.len(b) <= max and string.match(b, contains) and i > math.random(math.random(1, 400), math.random(500, 1000)) then
	  	return b
	  end
	end
end

while wait(wait) do
	if window.flags["autobot"] then
		local titleframe = game.Players.LocalPlayer.PlayerGui.WordBombUI.UIContainer.StageContainer.PC.TitleFrame
		local title = titleframe.Title.Text

		if string.match(title, "Quick") then
			print("Waiting " .. waittime)
			wait(waittime)
			local contains = string.lower(titleframe.Subtitle.Text)
			print("Getting word that contains " .. contains)
			print("Greater than or equal to " .. min)
			print("Smaller than or equal to " .. max)
			local word = getWord(contains, min, max)
			print("Got word " .. tostring(word))

			local intable = false

			for _, used in pairs(used_words) do
				if used == word then
					intable = true
					break
				end
			end

			if word and not intable then
				game:GetService("ReplicatedStorage").RemoteEvents.StageEvent:FireServer("Typed", string.upper(word))
			end
			print("-----------------------")
		end
	end
end
