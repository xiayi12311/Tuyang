---@class BossLacer_C:UGC_LaserAimingActor_C
--Edit Below--
local BossLacer = {}
 
--[[
function BossLacer:ReceiveBeginPlay()
    BossLacer.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function BossLacer:ReceiveTick(DeltaTime)
    BossLacer.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BossLacer:ReceiveEndPlay()
    BossLacer.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BossLacer:GetReplicatedProperties()
    return
end
--]]

--[[
function BossLacer:GetAvailableServerRPCs()
    return
end
--]]

return BossLacer