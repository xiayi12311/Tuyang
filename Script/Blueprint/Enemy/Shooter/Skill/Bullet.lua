---@class Bullet_C:UGC_BFS_BulletBall_C
---@field P_light_bullet_03 UParticleSystemComponent
--Edit Below--
local Bullet = {}
 
--[[
function Bullet:ReceiveBeginPlay()
    Bullet.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Bullet:ReceiveTick(DeltaTime)
    Bullet.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Bullet:ReceiveEndPlay()
    Bullet.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Bullet:GetReplicatedProperties()
    return
end
--]]

--[[
function Bullet:GetAvailableServerRPCs()
    return
end
--]]

return Bullet