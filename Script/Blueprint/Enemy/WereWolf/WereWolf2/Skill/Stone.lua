---@class Stone_C:UGC_BulletBall_C
---@field ParticleSystem UParticleSystemComponent
--Edit Below--
local Stone = {}
 
--[[
function Stone:ReceiveBeginPlay()
    Stone.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Stone:ReceiveTick(DeltaTime)
    Stone.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Stone:ReceiveEndPlay()
    Stone.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Stone:GetReplicatedProperties()
    return
end
--]]

--[[
function Stone:GetAvailableServerRPCs()
    return
end
--]]

return Stone