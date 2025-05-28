---@class Tesla_2_C:STExtraSimpleCharacter
---@field Capsule UCapsuleComponent
---@field UAEMonsterAnimList UUAEMonsterAnimListComponent
---@field UAESkillManager UUAESkillManagerComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local Tesla_2 = {}
 
--[[
function Tesla_2:ReceiveBeginPlay()
    Tesla_2.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Tesla_2:ReceiveTick(DeltaTime)
    Tesla_2.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Tesla_2:ReceiveEndPlay()
    Tesla_2.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Tesla_2:GetReplicatedProperties()
    return
end
--]]

--[[
function Tesla_2:GetAvailableServerRPCs()
    return
end
--]]

return Tesla_2