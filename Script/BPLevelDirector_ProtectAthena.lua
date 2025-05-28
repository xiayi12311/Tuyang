local BPLevelDirector_ProtectAthena = {}
 
--[[
function BPLevelDirector_ProtectAthena:ReceiveBeginPlay()
    BPLevelDirector_ProtectAthena.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function BPLevelDirector_ProtectAthena:ReceiveTick(DeltaTime)
    BPLevelDirector_ProtectAthena.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BPLevelDirector_ProtectAthena:ReceiveEndPlay()
    BPLevelDirector_ProtectAthena.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BPLevelDirector_ProtectAthena:GetReplicatedProperties()
    return
end
--]]

--[[
function BPLevelDirector_ProtectAthena:GetAvailableServerRPCs()
    return
end
--]]

return BPLevelDirector_ProtectAthena