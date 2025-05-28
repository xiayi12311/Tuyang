---@class PosionBullet_3_C:BP_PoisonBallActorWithDot_C
--Edit Below--
local PosionBullet_3 = {}
 
--[[
function PosionBullet_3:ReceiveBeginPlay()
    PosionBullet_3.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function PosionBullet_3:ReceiveTick(DeltaTime)
    PosionBullet_3.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function PosionBullet_3:ReceiveEndPlay()
    PosionBullet_3.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function PosionBullet_3:GetReplicatedProperties()
    return
end
--]]

--[[
function PosionBullet_3:GetAvailableServerRPCs()
    return
end
--]]

return PosionBullet_3