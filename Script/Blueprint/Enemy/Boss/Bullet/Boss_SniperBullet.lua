---@class Boss_SniperBullet_C:UGC_BulletBall_C
--Edit Below--
local Boss_SniperBullet = {}
 
--[[
function Boss_SniperBullet:ReceiveBeginPlay()
    Boss_SniperBullet.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Boss_SniperBullet:ReceiveTick(DeltaTime)
    Boss_SniperBullet.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Boss_SniperBullet:ReceiveEndPlay()
    Boss_SniperBullet.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Boss_SniperBullet:GetReplicatedProperties()
    return
end
--]]

--[[
function Boss_SniperBullet:GetAvailableServerRPCs()
    return
end
--]]

return Boss_SniperBullet