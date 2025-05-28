---@class Bossdamage_C:BP_WolfDamageType_C
--Edit Below--
local Bossdamage = {}
 
--[[
function Bossdamage:ReceiveBeginPlay()
    Bossdamage.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Bossdamage:ReceiveTick(DeltaTime)
    Bossdamage.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Bossdamage:ReceiveEndPlay()
    Bossdamage.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Bossdamage:GetReplicatedProperties()
    return
end
--]]

--[[
function Bossdamage:GetAvailableServerRPCs()
    return
end
--]]

return Bossdamage