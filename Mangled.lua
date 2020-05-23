local num = 3
local min, max = 5, 8

local dictionaries = {
    [1] = "10k";
    [2] = "22k";
    [3] = "100k";
    [4] = "All";
    [5] = "Datamuse API";
}

local real = dictionaries[num]

local words = WordBombWords
local notifytext = game.CoreGui:FindFirstChild("Text")
local http = game:GetService("HttpService")
local TS = game:GetService("TweenService")
local TI = TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut)

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

		wait(2)

		TS:Create(Overall, TI, {BackgroundTransparency = 1}):Play()
		TS:Create(Sidebar, TI, {BackgroundTransparency = 1}):Play()
		TS:Create(NotifyText, TI, {TextTransparency = 1}):Play()

		Overall:Destroy()

		removing = true
		num = num - 1
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

function TableCheck(thetable, value)
	for iter, v in pairs(thetable) do
		if v == value or iter == value then
			return true, {iter, value}
		end
	end
	return false
end

function removeDuplicates(tbl)
	local newTable, count = {}, 0
	for iter, a in pairs(tbl) do
		if not TableCheck(newTable, a) then
			table.insert(newTable, a)
		else
			count = count + 1
		end
		if iter % 1000 == 0 then wait(0) end
	end
	createText("Removed " .. count .. " duplicate words.")
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
	local k22 = game:HttpGet("https://raw.githubusercontent.com/3xjn/Uploads/master/words.txt")
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

list = {
    "10k";
    "22k";
    "100k";
    "All";
    "Datamuse API";
}

function TableCheck(thetable, value)
	for iter, v in pairs(thetable) do
		if v == value or iter == value then
			return true, {iter, value}
		end
	end
	return false
end

function getWord(contains, min, max)
	local word;
	local dictionaryuse;
	local a = false
	if real == "Datamuse API" then
		local results = game:HttpGet(string.format("https://api.datamuse.com/words?sp=*%s*", contains))
		if results then
			results = http:JSONDecode(results)
			dictionaryuse = results
			a = true
		end
	else
		dictionaryuse = AllDicts[real]
	end

	for i, b in pairs(dictionaryuse) do
		c = b
		if real == "Datamuse API" then
			c = b.word
		end
		if string.match(c, contains) and string.len(c) >= min and string.len(c) <= max and not TableCheck(shared.used_words, c) then
			table.insert(shared.used_words, c)
			if real == "Datamuse API" then
				b = b.word
			end
			return b
		end
	end
end

local desk = game:GetService("Players").LocalPlayer.PlayerGui.GameUI.Container.GameSpace.DefaultUI.GameContainer.DesktopContainer
local letters = desk.InfoFrameContainer.InfoFrame.TextFrame

local contains = {};

for _, a in pairs(letters:GetChildren()) do
	if a:IsA("Frame") then
		contains[a.AbsolutePosition.X] = a.Letter.TextLabel.Text
	end
end

table.sort(contains)
local c = ""

for _, b in pairs(contains) do
	c = c .. b
end
print(c)
local word = getWord(string.lower(c), min, max)
local wa = waittime

if word then
    createText(word)
elseif not word and string.match(title, "Quick") then
    createText("No word could be found", "error")
end

local ye = desk.Typebar.Typebox
ye.Text = ""

for i=1, string.len(word) do
	ye.Text = string.sub(word, 1, i)
	wait(math.random(1,2)/8)
end

game:GetService("ReplicatedStorage").Network.Games.GameEvent:FireServer(
	-108,
	"TypingEvent",
	string.upper(word),
	true
)