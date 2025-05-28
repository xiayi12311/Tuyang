---@class XiaoqiNPC_C:SkeletalMeshActor
---@field CustomWidget UCustomWidgetComponent
--Edit Below--
local XiaoqiNPC = {}
 
--[[
function XiaoqiNPC:ReceiveBeginPlay()
    XiaoqiNPC.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function XiaoqiNPC:ReceiveTick(DeltaTime)
    XiaoqiNPC.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function XiaoqiNPC:ReceiveEndPlay()
    XiaoqiNPC.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function XiaoqiNPC:GetReplicatedProperties()
    return
end
--]]

--[[
function XiaoqiNPC:GetAvailableServerRPCs()
    return
end
--]]

return XiaoqiNPC