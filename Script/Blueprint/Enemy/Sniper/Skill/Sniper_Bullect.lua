---@class Sniper_Bullect_C:UGC_BulletBall_C
---@field ParticleSystem UParticleSystemComponent
--Edit Below--
local Sniper_Bullect = {}
 
--[[
function Sniper_Bullect:ReceiveBeginPlay()
    Sniper_Bullect.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Sniper_Bullect:ReceiveTick(DeltaTime)
    Sniper_Bullect.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Sniper_Bullect:ReceiveEndPlay()
    Sniper_Bullect.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Sniper_Bullect:GetReplicatedProperties()
    return
end
--]]

--[[
function Sniper_Bullect:GetAvailableServerRPCs()
    return
end
--]]

return Sniper_Bullect