---@class Tridoor_C:StaticMeshActor
---@field StaticMesh1 UStaticMeshComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local Tridoor = {}
 
--[[
function Tridoor:ReceiveBeginPlay()
    Tridoor.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Tridoor:ReceiveTick(DeltaTime)
    Tridoor.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Tridoor:ReceiveEndPlay()
    Tridoor.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Tridoor:GetReplicatedProperties()
    return
end
--]]

--[[
function Tridoor:GetAvailableServerRPCs()
    return
end
--]]

return Tridoor