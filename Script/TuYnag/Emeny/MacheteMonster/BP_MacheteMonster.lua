---@class BP_MacheteMonster_C:TuYangMonsterBase_C
--Edit Below--
local BP_MacheteMonster = {}
 
--[[
function BP_MacheteMonster:ReceiveBeginPlay()
    BP_MacheteMonster.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function BP_MacheteMonster:ReceiveTick(DeltaTime)
    BP_MacheteMonster.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function BP_MacheteMonster:ReceiveEndPlay()
    BP_MacheteMonster.SuperClass.ReceiveEndPlay(self) 

end


--[[
function BP_MacheteMonster:GetReplicatedProperties()
    return
end
--]]

--[[
function BP_MacheteMonster:GetAvailableServerRPCs()
    return
end
--]]

return BP_MacheteMonster