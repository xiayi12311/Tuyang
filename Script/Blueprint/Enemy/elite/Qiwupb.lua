---@class Qiwupb_C:UGC_BFS_BulletBall_C
--Edit Below--
local Jianqi = {}
 
--[[
function Jianqi:ReceiveBeginPlay()
    Jianqi.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Jianqi:ReceiveTick(DeltaTime)
    Jianqi.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Jianqi:ReceiveEndPlay()
    Jianqi.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Jianqi:GetReplicatedProperties()
    return
end
--]]

--[[
function Jianqi:GetAvailableServerRPCs()
    return
end
--]]

return Jianqi