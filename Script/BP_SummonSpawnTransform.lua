local BP_SummonSpawnTransform = {};
 
--[[
function BP_SummonSpawnTransform:ReceiveBeginPlay()
    self.SuperClass.ReceiveBeginPlay(self);
end
--]]

--[[
function BP_SummonSpawnTransform:ReceiveTick(DeltaTime)
    self.SuperClass.ReceiveTick(self, DeltaTime);
end
--]]

--[[
function BP_SummonSpawnTransform:ReceiveEndPlay()
    self.SuperClass.ReceiveEndPlay(self); 
end
--]]

--[[
function BP_SummonSpawnTransform:GetReplicatedProperties()
    return
end
--]]

--[[
function BP_SummonSpawnTransform:GetAvailableServerRPCs()
    return
end
--]]

return BP_SummonSpawnTransform;