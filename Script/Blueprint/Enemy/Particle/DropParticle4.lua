---@class DropParticle4_C:AActor
---@field ParticleSystem UParticleSystemComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local DropParticle4 = {}
 
--[[
function DropParticle4:ReceiveBeginPlay()
    DropParticle4.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function DropParticle4:ReceiveTick(DeltaTime)
    DropParticle4.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function DropParticle4:ReceiveEndPlay()
    DropParticle4.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function DropParticle4:GetReplicatedProperties()
    return
end
--]]

--[[
function DropParticle4:GetAvailableServerRPCs()
    return
end
--]]

return DropParticle4