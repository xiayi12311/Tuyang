---@class BulletBall_C:UGC_BulletBall_C
--Edit Below--
local BulletBall = {}
 
--[[
function BulletBall:ReceiveBeginPlay()
    BulletBall.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function BulletBall:ReceiveTick(DeltaTime)
    BulletBall.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BulletBall:ReceiveEndPlay()
    BulletBall.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BulletBall:GetReplicatedProperties()
    return
end
--]]

--[[
function BulletBall:GetAvailableServerRPCs()
    return
end
--]]

return BulletBall