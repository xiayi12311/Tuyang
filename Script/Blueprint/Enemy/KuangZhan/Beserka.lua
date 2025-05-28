---@class Beserka_C:BPPawn_Zombie_Beserker_C
--Edit Below--
local Beserka = {}
 
--[[
function Beserka:ReceiveBeginPlay()
    Beserka.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Beserka:ReceiveTick(DeltaTime)
    Beserka.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Beserka:ReceiveEndPlay()
    Beserka.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Beserka:GetReplicatedProperties()
    return
end
--]]

--[[
function Beserka:GetAvailableServerRPCs()
    return
end
--]]

return Beserka