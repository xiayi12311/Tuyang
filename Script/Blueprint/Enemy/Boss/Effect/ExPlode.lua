---@class Explode_C:AActor
---@field ParticleSystem UParticleSystemComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local ExPlode = {}
 
--[[
function ExPlode:ReceiveBeginPlay()
    ExPlode.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function ExPlode:ReceiveTick(DeltaTime)
    ExPlode.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function ExPlode:ReceiveEndPlay()
    ExPlode.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function ExPlode:GetReplicatedProperties()
    return
end
--]]

--[[
function ExPlode:GetAvailableServerRPCs()
    return
end
--]]

return ExPlode