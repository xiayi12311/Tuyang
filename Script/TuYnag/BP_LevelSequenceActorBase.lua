---@class BP_LevelSequenceActorBase_C:LevelSequenceActor
--Edit Below--
local BP_LevelSequenceActorBase = {}
 
--[[
function BP_LevelSequenceActorBase:ReceiveBeginPlay()
    BP_LevelSequenceActorBase.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function BP_LevelSequenceActorBase:ReceiveTick(DeltaTime)
    BP_LevelSequenceActorBase.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BP_LevelSequenceActorBase:ReceiveEndPlay()
    BP_LevelSequenceActorBase.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BP_LevelSequenceActorBase:GetReplicatedProperties()
    return
end
--]]

--[[
function BP_LevelSequenceActorBase:GetAvailableServerRPCs()
    return
end
--]]

return BP_LevelSequenceActorBase