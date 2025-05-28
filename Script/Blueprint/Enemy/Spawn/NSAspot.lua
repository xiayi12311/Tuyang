---@class NSAspot_C:StaticMeshActor
---@field StaticMesh1 UStaticMeshComponent
---@field Plane UStaticMeshComponent
---@field StaticMesh UStaticMeshComponent
---@field Cube UStaticMeshComponent
---@field STCustomMesh1 USTCustomMeshComponent
---@field STCustomMesh USTCustomMeshComponent
---@field CG05_Skill_Banner01 UStaticMeshComponent
--Edit Below--
local NSAspot = {}
 
--[[
function NSAspot:ReceiveBeginPlay()
    NSAspot.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function NSAspot:ReceiveTick(DeltaTime)
    NSAspot.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function NSAspot:ReceiveEndPlay()
    NSAspot.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function NSAspot:GetReplicatedProperties()
    return
end
--]]

--[[
function NSAspot:GetAvailableServerRPCs()
    return
end
--]]

return NSAspot