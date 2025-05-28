---@class ScientistAI_C:MobAIController
--Edit Below--
local ScientistAI = {}
 
--[[
function ScientistAI:ReceiveBeginPlay()
    ScientistAI.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function ScientistAI:ReceiveTick(DeltaTime)
    ScientistAI.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function ScientistAI:ReceiveEndPlay()
    ScientistAI.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function ScientistAI:GetReplicatedProperties()
    return
end
--]]

--[[
function ScientistAI:GetAvailableServerRPCs()
    return
end
--]]

return ScientistAI