---@class DropParticle2_C:AActor
---@field ParticleSystem UParticleSystemComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local DropParticle2 = {}
 
--[[
function DropParticle2:ReceiveBeginPlay()
    DropParticle2.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function DropParticle2:ReceiveTick(DeltaTime)
    DropParticle2.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function DropParticle2:ReceiveEndPlay()
    DropParticle2.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function DropParticle2:GetReplicatedProperties()
    return
end
--]]

--[[
function DropParticle2:GetAvailableServerRPCs()
    return
end
--]]

return DropParticle2