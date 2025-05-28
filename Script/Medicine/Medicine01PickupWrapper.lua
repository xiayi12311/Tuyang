---@class Medicine01PickupWrapper_C:FirstAidBoxWrapper_C
---@field Treasuregold UParticleSystemComponent
--Edit Below--
local Medicine01PickupWrapper = {}
 
--[[
function Medicine01PickupWrapper:ReceiveBeginPlay()
    Medicine01PickupWrapper.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Medicine01PickupWrapper:ReceiveTick(DeltaTime)
    Medicine01PickupWrapper.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Medicine01PickupWrapper:ReceiveEndPlay()
    Medicine01PickupWrapper.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Medicine01PickupWrapper:GetReplicatedProperties()
    return
end
--]]

--[[
function Medicine01PickupWrapper:GetAvailableServerRPCs()
    return
end
--]]

return Medicine01PickupWrapper