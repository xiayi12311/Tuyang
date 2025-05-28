---@class DropParticle1_C:AActor
---@field ParticleSystem UParticleSystemComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local DropParticle1 = {}
 
--[[
function DropParticle1:ReceiveBeginPlay()
    DropParticle1.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function DropParticle1:ReceiveTick(DeltaTime)
    DropParticle1.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function DropParticle1:ReceiveEndPlay()
    DropParticle1.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function DropParticle1:GetReplicatedProperties()
    return
end
--]]

--[[
function DropParticle1:GetAvailableServerRPCs()
    return
end
--]]

return DropParticle1