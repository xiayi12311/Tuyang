---@class BLC_Respawn_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local BLC_Respawn = {}
 
--[[
function BLC_Respawn:ReceiveBeginPlay()
    BLC_Respawn.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function BLC_Respawn:ReceiveTick(DeltaTime)
    BLC_Respawn.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BLC_Respawn:ReceiveEndPlay()
    BLC_Respawn.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BLC_Respawn:GetReplicatedProperties()
    return
end
--]]

--[[
function BLC_Respawn:GetAvailableServerRPCs()
    return
end
--]]

return BLC_Respawn