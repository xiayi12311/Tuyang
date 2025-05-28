---@class Bossgun2_C:ArmedBuggy_C
---@field Cube UStaticMeshComponent
--Edit Below--
local Bossgun = {}
 
--[[
function Bossgun:ReceiveBeginPlay()
    Bossgun.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Bossgun:ReceiveTick(DeltaTime)
    Bossgun.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Bossgun:ReceiveEndPlay()
    Bossgun.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Bossgun:GetReplicatedProperties()
    return
end
--]]

--[[
function Bossgun:GetAvailableServerRPCs()
    return
end
--]]

return Bossgun