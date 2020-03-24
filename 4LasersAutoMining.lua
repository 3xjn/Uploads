local IdToOre = {
    [2] = "Silicate Ore";
    [4] = "Carbon Ore";
    [6] = "Iridium Ore";
    [8] = "Adamantite Ore";
    [12] = "Titanium Ore";
    [14] = "Quantium Ore";
}

function getOre()
  local ore;
  local val = 0;
  for _, a in pairs(workspace.Asteroids:GetChildren()) do
    local id = a:FindFirstChild("ID")
    if id then
      if a == 14 then return a end
      if id.Value > val and IdToOre[id.Value] then
        ore = a
        val = id.Value
      end
    end
  end
  return ore
end

while wait(0) do

  local hack = getsenv(game.Players.LocalPlayer.PlayerGui.MyScreenGui.TurretFrame.Button1.TurretLocalScript)
  local call = debug.getupvalues(hack.fire)
  local ccall = debug.getupvalues(call[7].Fire)[22]
  local firefunc = debug.getupvalues(call[7].Fire)[2]
  debug.setupvalue(ccall,1,getfenv(1))
  local cf = CFrame.new(0,0,0)
  local enemy = getOre()
  if enemy then
    local center = enemy:WaitForChild'CenterPoint'
    ccall(firefunc,center,cf,enemy,enemy,center)
  end

  local hack = getsenv(game.Players.LocalPlayer.PlayerGui.MyScreenGui.TurretFrame.Button2.TurretLocalScript)
  local call = debug.getupvalues(hack.fire)
  local ccall = debug.getupvalues(call[7].Fire)[22]
  local firefunc = debug.getupvalues(call[7].Fire)[2]
  debug.setupvalue(ccall,1,getfenv(1))
  local cf = CFrame.new(0,0,0)
  enemy = getOre()
  if enemy then
    local center = enemy:WaitForChild'CenterPoint'
    ccall(firefunc,center,cf,enemy,enemy,center)
  end

  local hack = getsenv(game.Players.LocalPlayer.PlayerGui.MyScreenGui.TurretFrame.Button3.TurretLocalScript)
  local call = debug.getupvalues(hack.fire)
  local ccall = debug.getupvalues(call[7].Fire)[22]
  local firefunc = debug.getupvalues(call[7].Fire)[2]
  debug.setupvalue(ccall,1,getfenv(1))
  local cf = CFrame.new(0,0,0)
  local enemy = getOre()
  if enemy then
    local center = enemy:WaitForChild'CenterPoint'
    ccall(firefunc,center,cf,enemy,enemy,center)
  end

  local hack = getsenv(game.Players.LocalPlayer.PlayerGui.MyScreenGui.TurretFrame.Button4.TurretLocalScript)
  local call = debug.getupvalues(hack.fire)
  local ccall = debug.getupvalues(call[7].Fire)[22]
  local firefunc = debug.getupvalues(call[7].Fire)[2]
  debug.setupvalue(ccall,1,getfenv(1))
  local cf = CFrame.new(0,0,0)
  local enemy = getOre()
  if enemy then
    local center = enemy:WaitForChild'CenterPoint'
    ccall(firefunc,center,cf,enemy,enemy,center)
  end

  ccall(workspace.Bases["Mega Base"]["Mega Base"].SellOre)

end
