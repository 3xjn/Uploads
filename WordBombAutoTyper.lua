local words = WordBombWords
local notifytext = game.CoreGui:FindFirstChild("Text")
local TS = game:GetService("TweenService")

if not notifytext then
	notifytext = Instance.new("ScreenGui")
	notifytext.Name = "Text"
	notifytext.Parent = game.CoreGui
end

local num = -1

function createText(text)
	spawn(function()
		num = num + 1
		local Number = Instance.new("NumberValue")
		local Overall = Instance.new("Frame")
		local Sidebar = Instance.new("Frame")
		local NotifyText = Instance.new("TextLabel")
		local numnow = num

		Overall.Name = "Overall"
		Overall.Parent = notifytext
		Overall.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
		Overall.BorderColor3 = Color3.fromRGB(62, 62, 62)
		Overall.BorderSizePixel = 0
		Overall.Position = UDim2.new(-.25, 0, (0.050 * numnow), 0)
		Overall.Size = UDim2.new(0.124, 0, 0.046, 0)
		Overall.Parent = notifytext

		Number.Name = "NumberPos"
		Number.Value = num
		Number.Parent = Overall

		Sidebar.Name = "Sidebar"
		Sidebar.Parent = Overall
		Sidebar.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
		Sidebar.BorderSizePixel = 0
		Sidebar.Size = UDim2.new(0.066, 0, 0.962, 0)
		Sidebar.Parent = Overall

		NotifyText.Name = "NotifyText"
		NotifyText.Parent = Overall
		NotifyText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotifyText.BackgroundTransparency = 1.000
		NotifyText.BorderSizePixel = 0
		NotifyText.Position = UDim2.new(0.112244897, 0, 0, 0)
		NotifyText.Size = UDim2.new(0.883, 0, 1, 0)
		NotifyText.SizeConstraint = Enum.SizeConstraint.RelativeXY
		NotifyText.Font = Enum.Font.SourceSans
		NotifyText.Text = text
		NotifyText.TextColor3 = Color3.fromRGB(255, 255, 255)
		NotifyText.TextScaled = true
		NotifyText.TextSize = 14.000
		NotifyText.TextWrapped = true
		NotifyText.TextXAlignment = Enum.TextXAlignment.Left
		NotifyText.Parent = Overall

		local removing = false

		spawn(function()
			while wait(0) do
				if Overall and not removing then
					TS:Create(Overall, TweenInfo.new(0.25), {Position = UDim2.new(0.0114140771, 0, 0.0410714298 + (0.050 * numnow), 0)}):Play()
				else
					break
				end
			end
		end)

		TS:Create(Overall, TweenInfo.new(0.25), {Position = UDim2.new(0.0114140771, 0, 0.0410714298, 0)}):Play()
		wait(.25)
		wait(2)
		removing = true
		num = num - 1
		TS:Create(Overall, TweenInfo.new(.25), {Position = UDim2.new(-.25, 0, -.25, 0)}):Play()
		wait(.25)
		Overall:Destroy()
	end)
end

function shuffle(tbl)
  for i=1, table.getn(tbl) do
    local j = math.random(i)
    tbl[i], tbl[j] = tbl[j], tbl[i]
  end
  return tbl
end

function MergeTables(tbloftables)
	local newTable = {}
	for _, a in pairs(tbloftables) do
		for k, v in pairs(a) do
			table.insert(newTable, v)
		end
	end
	return newTable
end

local AllDicts = {}

shared.used_words = shared.used_words or {}
local file;
local file2;
local file3;

pcall(function()
	file = readfile("22k.txt")
	file2 = readfile("10k.txt")
	file3 = readfile("100k.txt")
end)

if not file then
	local k22 = game:HttpGet("https://raw.githubusercontent.com/Tesseracting/Uploads/master/words.txt")
	AllDicts["22k"] = shuffle(k22:split("\n"))
	writefile("22k.txt", k22)
	createText("Downloaded 22k word list.")
else
	AllDicts["22k"] = shuffle(file:split("\n"))
end

if not file2 then
	local k10 = game:HttpGet("https://www.mit.edu/~ecprice/wordlist.10000")
	AllDicts["10k"] = shuffle(k10:split("\n"))
	writefile("10k.txt", k10)
	createText("Downloaded 10k word list.")
else
	AllDicts["10k"] = shuffle(file2:split("\n"))
end

if not file2 then
	local k100 = game:HttpGet("https://www.mit.edu/~ecprice/wordlist.100000")
	AllDicts["100k"] = shuffle(k100:split("\n"))
	writefile("100k.txt", k100)
	createText("Downloaded 100k word list.")
else
	AllDicts["100k"] = shuffle(file2:split("\n"))
end

AllDicts.All = shuffle(MergeTables({AllDicts["22k"], AllDicts["10k"], AllDicts["100k"]}))

local library = loadstring(game:HttpGet("https://pastebin.com/raw/eWKgbdix", true))()
local window = library:CreateWindow('Word Bomber')
local min, max, waittime = 3, 8, 0

local ghfggfhgfhfgh = window:Toggle("Autobot", {flag = "autobot"})
local gjhjhjhjhjjhh = window:Dropdown("Dictionaries", {
	flag = "dictionary";
		list = {
			"All";
			"10k";
			"22k";
			"100k";
		}
})
local fugufgufgufuf = window:Toggle("Realistic Speed", {flag = "realspeed"})
local girgiurgiigrr = window:Toggle("Miss 80%", {flag = "miss"})
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
	local dictionaryuse = AllDicts[window.flags.dictionary]
	if dictionaryuse then
		for i, b in pairs(dictionaryuse) do
		  if string.len(b) >= min and string.len(b) <= max and string.match(b, contains) and not TableCheck(shared.used_words, b) then
				table.insert(shared.used_words, b)
				return b
		  end
		end
	else
		createText("NO DICTIONARY FOUND PLS THERE'S ERROR")
	end
end

while wait(0.1) do
	if window.flags["autobot"] then
		local titleframe = game.Players.LocalPlayer.PlayerGui.WordBombUI.UIContainer.StageContainer.PC.TitleFrame
		local title = titleframe.Title.Text
		if string.match(title, "Quick") then
			local contains = string.lower(titleframe.Subtitle.Text)
			local word = getWord(contains, min, max)
			local wa = waittime

			if word then
				if window.flags.miss then
					if math.random(1, 8) == 8 then
						createText("Missing this word.")
						word = "fuckniggers"
					else
						createText("Got word " .. word)
					end
				else
					createText("Got word " .. word)
				end
				if window.flags.realspeed then
					wa = (string.len(word)/3)
				end
				tell("Waiting " .. wa)
				wait(wa)
				tell("Getting word that contains " .. contains)
				tell("Greater than or equal to " .. min)
				tell("Smaller than or equal to " .. max)
				if word == "fuckniggers" then tell("Missing this word.") else tell("Got word " .. tostring(word)) end
				tell("-----------------------")

				game:GetService("ReplicatedStorage").RemoteEvents.StageEvent:FireServer("Typed", string.upper(word))
			elseif not word and string.match(title, "Quick") then
				tell("No word could be found", "error")
			end
		end
	end
end
