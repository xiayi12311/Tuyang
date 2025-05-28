---@class PosionBullet_C:BP_PoisonBallActorWithDot_C
--Edit Below--
local PosionBullet = {}
 
--[[
function PosionBullet:ReceiveBeginPlay()
    PosionBullet.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function PosionBullet:ReceiveTick(DeltaTime)
    PosionBullet.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function PosionBullet:ReceiveEndPlay()
    PosionBullet.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function PosionBullet:GetReplicatedProperties()
    return
end
--]]

--[[
function PosionBullet:GetAvailableServerRPCs()
    return
end
--]]

return PosionBullet