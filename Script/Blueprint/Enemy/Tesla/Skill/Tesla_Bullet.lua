---@class Tesla_Bullet_C:UGC_BulletBall_C
--Edit Below--
local Tesla_Bullet = {}
 
--[[
function Tesla_Bullet:ReceiveBeginPlay()
    Tesla_Bullet.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Tesla_Bullet:ReceiveTick(DeltaTime)
    Tesla_Bullet.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Tesla_Bullet:ReceiveEndPlay()
    Tesla_Bullet.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Tesla_Bullet:GetReplicatedProperties()
    return
end
--]]

--[[
function Tesla_Bullet:GetAvailableServerRPCs()
    return
end
--]]

return Tesla_Bullet