local StopRestore = {}
 

function StopRestore:ReceiveBeginPlay()
    StopRestore.SuperClass.ReceiveBeginPlay(self)
    local SkillPawn
    SkillPawn = self:GetOwnerPawn()
end



function StopRestore:ReceiveTick(DeltaTime)
    StopRestore.SuperClass.ReceiveTick(self, DeltaTime)
end



function StopRestore:ReceiveEndPlay()
    StopRestore.SuperClass.ReceiveEndPlay(self) 
end


--[[
function StopRestore:GetReplicatedProperties()
    return
end
--]]

--[[
function StopRestore:GetAvailableServerRPCs()
    return
end
--]]

return StopRestore