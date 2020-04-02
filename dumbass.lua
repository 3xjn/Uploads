local config = script.Parent.Config
while wait(0.1) do
    local a = {}
    for _, hit in pairs(script.Parent.Part:GetTouchingParts()) do
        if hit.Parent:FindFirstChildOfClass("Humanoid") then
            local plr = game.Players:GetPlayerFromCharacter(hit.Parent)
            if not a[plr.UserId] then
                if plr then
                    if plr:FindFirstChild("leaderstats") and plr.leaderstats:FindFirstChild("Rebirth") then
                        if plr.leaderstats.Cash.Value >= config.Cost.Value then
                            plr.leaderstats.Cash.Value = plr.leaderstats.Cash.Value - config.Cost.Value
                            plr.leaderstats.Multiplier.Value = plr.leaderstats.Multiplier.Value + config.Amount.Value * (plr.leaderstats.Rebirth.Value +1)
                        end
                        table.insert(a, plr.UserId)
                    end
                end
            end
        end
    end
end