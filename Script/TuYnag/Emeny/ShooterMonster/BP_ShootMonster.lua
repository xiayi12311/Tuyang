---@class BP_ShootMonster_C:TuYangMonsterBase_C
---@field UAEMonsterAnimList UUAEMonsterAnimListComponent
--Edit Below--
local BP_ShootMonster = {}
 
--[[
function BP_ShootMonster:ReceiveBeginPlay()
    BP_ShootMonster.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function BP_ShootMonster:ReceiveTick(DeltaTime)
    BP_ShootMonster.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function BP_ShootMonster:ReceiveEndPlay()
    BP_ShootMonster.SuperClass.ReceiveEndPlay(self) 

end


--[[
function BP_ShootMonster:GetReplicatedProperties()
    return
end
--]]

--[[
function BP_ShootMonster:GetAvailableServerRPCs()
    return
end
--]]

return BP_ShootMonster