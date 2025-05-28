---@class Insect_Jump_C:UGC_BFS_BulletBall_C
--Edit Below--
local Insect_Jump = {}
 
--[[
function Insect_Jump:ReceiveBeginPlay()
    Insect_Jump.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Insect_Jump:ReceiveTick(DeltaTime)
    Insect_Jump.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Insect_Jump:ReceiveEndPlay()
    Insect_Jump.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Insect_Jump:GetReplicatedProperties()
    return
end
--]]

--[[
function Insect_Jump:GetAvailableServerRPCs()
    return
end
--]]

return Insect_Jump