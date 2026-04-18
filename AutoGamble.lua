local GaryWins = 0
local frame = CreateFrame("Frame")

frame:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
frame:RegisterEvent("GOSSIP_SHOW")

frame:SetScript("OnEvent", function()
    -- Gary uses the Monster Emote type of chat message. I believe this has to be enabled on at least one chat box for the addon to read it. But I didn't bother to test lol
    if event == "CHAT_MSG_MONSTER_EMOTE" then
        local _, _, roll = string.find(arg1, "Gold%-Tooth Gary rolls a dice for .*%.%.%. (%d+)!$")
        
        if roll then
            local val = tonumber(roll)
            if val > 50 then
                GaryWins = GaryWins + 1
            else
                GaryWins = 0
            end
        end
    end
    if event == "GOSSIP_SHOW" then
        if (UnitName("target") == "Gold-Tooth Gary") then
            if GaryWins >= 2 then
                -- Gary has a streak system which actually turns the gambling to the house's favor by a good bit. This balances it back out to 50|50
                SelectGossipOption(3)
                GaryWins = 0 
            else
                SelectGossipOption(4)
            end
        end
    end
end)

ChatFrame1:AddMessage("|cffff0000[AutoGamble]|r Loaded. Good luck at the tables, matey.")