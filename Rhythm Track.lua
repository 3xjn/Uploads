--if not getgenv().MTAPIMutex then loadstring(game:HttpGet("https://pastebin.com/raw/UwFCVrhS", true))() end

local screenGui;
local connection;

function guicheck(child)
	if child.Name == "ScreenGui" then
		screenGui = child
		connection:Disconnect()
	end
end

connection = game.CoreGui.ChildAdded:Connect(guicheck)

local library = loadstring(game:HttpGet("https://pastebin.com/raw/eWKgbdix", true))()
local window = library:CreateWindow("Rhythmer")

local con;
local destroyed = false

window:Toggle("On", {flag = "on"})
window:Toggle("Tracers", {flag = "tracers"})
window:Toggle("Distance", {flag = "show_dist"})
window:Bind("Hide", {
	flag = "hide";
	kbonly = true;
	default = Enum.KeyCode.RightAlt;
 }, function()
	screenGui.Enabled = not screenGui.Enabled
end)
window:Button("Destroy", function()
	window.flags.on = false
	window.flags.tracers = false
	window.flags.show_dist = false
	screenGui:Destroy()
	destroyed = true
	if con then
		con:Disconnect()
	end
end)

local show_dist = false

function presskey(cx)
	keypress(cx)
	keyrelease(cx)
end

local run = game:GetService("RunService")
local tb = workspace:WaitForChild('TrackBand')
local t1 = tb['1']
local t2 = tb['2']
local t3 = tb['3']
local t4 = tb['4']

local mid = Instance.new("Part")
mid.Position = Vector3.new(-10.65, 0.70, -41.25)
mid.Anchored = true
mid.Size = Vector3.new(0.1, 0.1, 0.1)
mid.Name = "Middle"

local KeyToVKey = {
	[0] = 48;
	[1] = 49;
	[2] = 50;
	[3] = 51;
	[4] = 52;
	[5] = 53;
	[6] = 54;
	[7] = 55;
	[8] = 56;
	[9] = 57;
	["A"] = 65;
	["B"] = 66;
	["C"] = 67;
	["D"] = 68;
	["E"] = 69;
	["F"] = 70;
	["G"] = 71;
	["H"] = 72;
	["I"] = 73;
	["J"] = 74;
	["K"] = 75;
	["L"] = 76;
	["M"] = 77;
	["N"] = 78;
	["O"] = 79;
	["P"] = 80;
	["Q"] = 81;
	["R"] = 82;
	["S"] = 83;
	["T"] = 84;
	["U"] = 85;
	["V"] = 86;
	["W"] = 87;
	["X"] = 88;
	["Y"] = 89;
	["Z"] = 90;
	["LeftControl"] = 17;
	["LeftMeta"] = 91;
	["LeftAlt"] = 18;
	["Space"] = 32;
	["RightAlt"] = 18;
	["RightControl"] = 17;
	["Left"] = 37;
	["Down"] = 40;
	["Right"] = 39;
	["KeypadZero"] = 45;
	["KeypadPeriod"] = 46;
	["KeypadEnter"] = 13;
	["LeftShift"] = 16;
	["RightShift"] = 16;
	["Up"] = 38;
	["KeypadOne"] = 35;
	["KeypadTwo"] = 40;
	["KeypadThree"] = 34;
	["KeypadFour"] = 37;
	["KeypadFive"] = 12;
	["KeypadSix"] = 39;
	["KeypadSeven"] = 36;
	["KeypadEight"] = 38;
	["KeypadNine"] = 33;
	["KeypadPlus"] = 107;
	["NumLock"] = 144;
	["KeypadDivide"] = 111;
	["KeypadMultiply"] = 106;
	["KeypadMinus"] = 109;
	["F1"] = 112;
	["F2"] = 113;
	["F3"] = 114;
	["F4"] = 115;
	["F5"] = 116;
	["F6"] = 117;
	["F7"] = 118;
	["F8"] = 119;
	["F9"] = 120;
	["F10"] = 121;
	["F11"] = 122;
	["F12"] = 123;
	["Tilde"] = 192;
	["Tab"] = 9;
	["CapsLock"] = 20;
	["Esc"] = 27;
	["ScrollLock"] = 145;
	["Pause"] = 19;
	["Insert"] = 45;
	["Home"] = 36;
	["PageUp"] = 33;
	["Delete"] = 46;
	["End"] = 35;
	["Backslash"] = 220;
	["PageDown"] = 34;
	["Minus"] = 189;
	["Equal"] = 187;
}

local controls = game.Players.LocalPlayer.Controls

function conv(obj)
	local color = tostring(obj.BrickColor)
	local tbl = {}
	if (obj.Size - Vector3.new(0.9, 5.9, 1.2)).magnitude <= 0.2 then
		tbl = {
			["check"] = mid;
			["key"] = KeyToVKey[controls.Orange.Value];
		}
	elseif color == "Shamrock" then
		tbl = {
			["check"] = t1;
			["key"] = KeyToVKey[controls.Green.Value];
		}
	elseif color == "Persimmon" then
		tbl = {
			["check"] = t2;
			["key"] = KeyToVKey[controls.Red.Value];
		}
	elseif color == "Pastel Blue" then
		tbl = {
			["check"] = t3;
			["key"] = KeyToVKey[controls.Blue.Value];
		}
	elseif color == "Daisy orange" then
		tbl = {
			["check"] = t4;
			["key"] = KeyToVKey[controls.Yellow.Value];
		}
	end

	return tbl;
end

function WorldPointToViewPoint(vec)
	local camera = workspace.CurrentCamera
	local vector, onScreen = camera:WorldToScreenPoint(vec)

	return Vector2.new(vector.X, vector.Y)
end

local holder = {
	["1"] = {};
	["2"] = {};
	["3"] = {};
	["4"] = {};
	["Middle"] = {};
}

function doit(c)
	if c.ClassName == 'Part' and c:FindFirstChild('Mesh') and not destroyed then
		--c.Mesh:Destroy()
		local a = conv(c)

		local key = a.key
		local check = a.check

		local checktbl = holder[check.Name]
		table.insert(checktbl, c)

		--print(c.Name .. ': ' .. key .. ', ' .. tostring(check) .. ", " .. tostring(c.BrickColor))
		local ay;
		--[[if window.flags.show_dist then
			local cba = Instance.new("SurfaceGui")
			cba.Adornee = c
			cba.AlwaysOnTop = true
			cba.Face = "Left"
			cba.LightInfluence = 0
			cba.Parent = c

			ay = Instance.new("TextLabel")
			ay.BackgroundTransparency = 1
			ay.TextColor3 = Color3.fromRGB(223, 38, 38)
			ay.Size = UDim2.new(0.5, 0, 0.5, 0)
			ay.TextScaled = true
			ay.Font = Enum.Font.SourceSansLight
			ay.Rotation = -90
			ay.Parent = cba
		end--]]

		local close = false
		local line;

		if window.flags.tracers then
			line = Drawing.new("Line")
			line.From = WorldPointToViewPoint(check.Position)
			line.To = WorldPointToViewPoint(c.Position)
			line.Thickness = 2
			--line.Transparency = 0.25
			line.Color = c.BrickColor.Color
		end

		local text;

		function get2D()
			local a = WorldPointToViewPoint(c.Position)
			return a
		end

		if window.flags.show_dist then
			text = Drawing.new("Text")
			--local clr = c.BrickColor.Color
			text.Color = Color3.new(1, 1, 1)
			text.Position = WorldPointToViewPoint(c.Position)
			text.Size = 60.0
			text.Outline = false
			text.Position = WorldPointToViewPoint(check.Position + Vector3.new(0, check.Size.Y/2, 0))
			text.Center = true
			text.Visible = true
		end

		local conc;

		conc = run.RenderStepped:Connect(function()
			if not close then
				local dist = (check.Position - c.Position).magnitude
				
				if dist <= 0.29 and window.flags.on then -- If it on the corresponding block
					table.remove(checktbl, 1)
					presskey(key)
					pcall(function() 
						line:Remove() 
						text.Visible = false
						if conc then 
							conc:Disconnect() 
						end
					end)
					close = true
				end

				if not c.Parent then
					table.remove(checktbl, 1)
					pcall(function() 
						line:Remove() 
						text.Visible = false
						if conc then
							conc:Disconnect() 
						end
					end)
					close = true
				end

				if window.flags.show_dist then
					pcall(function()
						if checktbl[1] == c then -- and dist <= 25 then
							--text.Size = map(dist, 0, 30, 0, 60)
							text.Visible = true
							--text.Position = WorldPointToViewPoint(c.Position)
							text.Text = tostring(round(dist, 2))
						end
					end)
				end

				spawn(function()
					pcall(function()
						if window.flags.tracers then
							if checktbl[1] == c then -- and dist <= 15 then
								line.Visible = true
							end

							line.From = WorldPointToViewPoint(check.Position + Vector3.new(0, check.Size.Y/2, 0))
							line.To = WorldPointToViewPoint(c.Position - Vector3.new(0, check.Size.Y/2, 0))
						end
					end)
				end)
			end
		end)
	end
end

con = tb.ChildAdded:connect(function(c) doit(c) end)
