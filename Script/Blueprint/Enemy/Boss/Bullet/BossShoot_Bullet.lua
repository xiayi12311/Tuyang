---@class BossShoot_Bullet_C:UGC_BulletBall_C
--Edit Below--
local BossShoot_Bullet = {}
 
--[[
function BossShoot_Bullet:ReceiveBeginPlay()
    BossShoot_Bullet.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function BossShoot_Bullet:ReceiveTick(DeltaTime)
    BossShoot_Bullet.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BossShoot_Bullet:ReceiveEndPlay()
    BossShoot_Bullet.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BossShoot_Bullet:GetReplicatedProperties()
    return
end
--]]

--[[
function BossShoot_Bullet:GetAvailableServerRPCs()
    return
end
--]]

return BossShoot_Bullet