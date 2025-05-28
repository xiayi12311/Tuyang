---@class firstchapter2_BLL_C:LevelSequenceActor
--Edit Below--
local firstchapter2_BLL = {}
 
--[[
function firstchapter2_BLL:ReceiveBeginPlay()
    firstchapter2_BLL.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function firstchapter2_BLL:ReceiveTick(DeltaTime)
    firstchapter2_BLL.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function firstchapter2_BLL:ReceiveEndPlay()
    firstchapter2_BLL.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function firstchapter2_BLL:GetReplicatedProperties()
    return
end
--]]

--[[
function firstchapter2_BLL:GetAvailableServerRPCs()
    return
end
--]]

return firstchapter2_BLL