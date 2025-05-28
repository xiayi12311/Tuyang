---@class shopNPC3_C:SkeletalMeshActor
---@field CustomWidget UCustomWidgetComponent
--Edit Below--
local shopNPC3 = {}
 
--[[
function shopNPC3:ReceiveBeginPlay()
    shopNPC3.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function shopNPC3:ReceiveTick(DeltaTime)
    shopNPC3.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function shopNPC3:ReceiveEndPlay()
    shopNPC3.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function shopNPC3:GetReplicatedProperties()
    return
end
--]]

--[[
function shopNPC3:GetAvailableServerRPCs()
    return
end
--]]

return shopNPC3