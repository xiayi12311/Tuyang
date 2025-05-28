---@class Shoppeijiannpc_C:SkeletalMeshActor
---@field CustomWidget UCustomWidgetComponent
--Edit Below--
local Shoppeijiannpc = {}
 
--[[
function Shoppeijiannpc:ReceiveBeginPlay()
    Shoppeijiannpc.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Shoppeijiannpc:ReceiveTick(DeltaTime)
    Shoppeijiannpc.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Shoppeijiannpc:ReceiveEndPlay()
    Shoppeijiannpc.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Shoppeijiannpc:GetReplicatedProperties()
    return
end
--]]

--[[
function Shoppeijiannpc:GetAvailableServerRPCs()
    return
end
--]]

return Shoppeijiannpc