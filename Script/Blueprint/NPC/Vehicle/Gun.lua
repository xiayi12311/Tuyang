---@class Gun_C:VehicleM2_C
--Edit Below--
local Gun = {}
 
--[[
function Gun:ReceiveBeginPlay()
    Gun.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Gun:ReceiveTick(DeltaTime)
    Gun.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Gun:ReceiveEndPlay()
    Gun.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Gun:GetReplicatedProperties()
    return
end
--]]

--[[
function Gun:GetAvailableServerRPCs()
    return
end
--]]

return Gun