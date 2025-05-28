---@class GPickupWrapper_C:Pistol_P1911_Wrapper_C
--Edit Below--
local GPickupWrapper = {}
 
--[[
function GPickupWrapper:ReceiveBeginPlay()
    GPickupWrapper.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function GPickupWrapper:ReceiveTick(DeltaTime)
    GPickupWrapper.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function GPickupWrapper:ReceiveEndPlay()
    GPickupWrapper.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function GPickupWrapper:GetReplicatedProperties()
    return
end
--]]

--[[
function GPickupWrapper:GetAvailableServerRPCs()
    return
end
--]]

return GPickupWrapper