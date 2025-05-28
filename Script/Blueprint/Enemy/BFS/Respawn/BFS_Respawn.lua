---@class BFS_Respawn_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local BFS_Respawn = {}
 
--[[
function BFS_Respawn:ReceiveBeginPlay()
    BFS_Respawn.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function BFS_Respawn:ReceiveTick(DeltaTime)
    BFS_Respawn.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BFS_Respawn:ReceiveEndPlay()
    BFS_Respawn.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BFS_Respawn:GetReplicatedProperties()
    return
end
--]]

--[[
function BFS_Respawn:GetAvailableServerRPCs()
    return
end
--]]

return BFS_Respawn