---@class Shopnpc2_C:SkeletalMeshActor
---@field CustomWidget UCustomWidgetComponent
--Edit Below--
local Shopnpc2 = {}
 
--[[
function Shopnpc2:ReceiveBeginPlay()
    Shopnpc2.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Shopnpc2:ReceiveTick(DeltaTime)
    Shopnpc2.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Shopnpc2:ReceiveEndPlay()
    Shopnpc2.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Shopnpc2:GetReplicatedProperties()
    return
end
--]]

--[[
function Shopnpc2:GetAvailableServerRPCs()
    return
end
--]]

return Shopnpc2