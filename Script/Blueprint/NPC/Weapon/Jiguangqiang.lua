---@class Jiguangqiang_C:BP_UGC_LaserGun_C
--Edit Below--
local Jiguangqiang = {}
 
--[[
function Jiguangqiang:ReceiveBeginPlay()
    Jiguangqiang.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Jiguangqiang:ReceiveTick(DeltaTime)
    Jiguangqiang.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Jiguangqiang:ReceiveEndPlay()
    Jiguangqiang.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Jiguangqiang:GetReplicatedProperties()
    return
end
--]]

--[[
function Jiguangqiang:GetAvailableServerRPCs()
    return
end
--]]

return Jiguangqiang