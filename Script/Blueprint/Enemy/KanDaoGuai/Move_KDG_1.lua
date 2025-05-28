---@class Move_KDG_1_C:AActor
---@field Cube UStaticMeshComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local Move_KDG_1 = {}
 
--[[
function Move_KDG_1:ReceiveBeginPlay()
    Move_KDG_1.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Move_KDG_1:ReceiveTick(DeltaTime)
    Move_KDG_1.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Move_KDG_1:ReceiveEndPlay()
    Move_KDG_1.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Move_KDG_1:GetReplicatedProperties()
    return
end
--]]

--[[
function Move_KDG_1:GetAvailableServerRPCs()
    return
end
--]]

return Move_KDG_1