function getVel(a)
    local b = a
    wait(3)
    local c = (a - b)/3
    return c
end

local con;
local yeah = 1
local samples = 10

local avg;

con = workspace.TrackBand.ChildAdded:Connect(function(c)
    if yeah >= samples then
        con:Disconnect()
    end
    if not avg then avg = getVel(c.Position) else
        avg = avg + getVel(c.Position)
    end
    print(yeah, avg)
    yeah = yeah + 1
end)

repeat
    wait(0)
until yeah >= samples
    
print(avg/yeah)

local UserInputService = game:GetService("UserInputService")