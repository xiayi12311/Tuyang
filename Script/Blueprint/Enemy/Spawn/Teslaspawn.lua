---@class Teslaspawn_C:StaticMeshActor
---@field P_028_Qishi UParticleSystemComponent
---@field STCustomMesh USTCustomMeshComponent
--Edit Below--
local Teslaspawn = {}
 
--[[
function Teslaspawn:ReceiveBeginPlay()
    Teslaspawn.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Teslaspawn:ReceiveTick(DeltaTime)
    Teslaspawn.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Teslaspawn:ReceiveEndPlay()
    Teslaspawn.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Teslaspawn:GetReplicatedProperties()
    return
end
--]]

--[[
function Teslaspawn:GetAvailableServerRPCs()
    return
end
--]]

return Teslaspawn