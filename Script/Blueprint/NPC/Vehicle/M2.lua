---@class M2_C:VehicleM2_C
--Edit Below--
local M2 = {}
 
--[[
function M2:ReceiveBeginPlay()
    M2.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function M2:ReceiveTick(DeltaTime)
    M2.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function M2:ReceiveEndPlay()
    M2.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function M2:GetReplicatedProperties()
    return
end
--]]

--[[
function M2:GetAvailableServerRPCs()
    return
end
--]]

return M2