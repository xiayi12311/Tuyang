---@class Level_6_C:BP_YXMonsterBase_C
---@field TurnAroundView UTurnAroundViewComponent
---@field MonsterAnimList_BLC MonsterAnimList_BLC_C
---@field CrowdAgent1 UCrowdAgentComponent
---@field UAESkillManager UUAESkillManagerComponent
--Edit Below--
local Level_6 = {}
 
--[[
function Level_6:ReceiveBeginPlay()
    Level_6.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Level_6:ReceiveTick(DeltaTime)
    Level_6.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Level_6:ReceiveEndPlay()
    Level_6.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Level_6:GetReplicatedProperties()
    return
end
--]]

--[[
function Level_6:GetAvailableServerRPCs()
    return
end
--]]

return Level_6