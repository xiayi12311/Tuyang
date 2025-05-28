---@class Teleport_C:StaticMeshActor
---@field CustomWidget UCustomWidgetComponent
--Edit Below--
local Upgrade = {}
 
--[[
function Upgrade:ReceiveBeginPlay()
    Upgrade.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Upgrade:ReceiveTick(DeltaTime)
    Upgrade.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Upgrade:ReceiveEndPlay()
    Upgrade.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Upgrade:GetReplicatedProperties()
    return
end
--]]

--[[
function Upgrade:GetAvailableServerRPCs()
    return
end
--]]

return Upgrade