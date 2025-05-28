---@class DropParticle3_C:AActor
---@field ParticleSystem UParticleSystemComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local DropParticle3 = {}
 
--[[
function DropParticle3:ReceiveBeginPlay()
    DropParticle3.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function DropParticle3:ReceiveTick(DeltaTime)
    DropParticle3.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function DropParticle3:ReceiveEndPlay()
    DropParticle3.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function DropParticle3:GetReplicatedProperties()
    return
end
--]]

--[[
function DropParticle3:GetAvailableServerRPCs()
    return
end
--]]

return DropParticle3