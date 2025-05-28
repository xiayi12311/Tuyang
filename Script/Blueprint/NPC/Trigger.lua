---@class Trigger_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local Trigger = {}
 
--[[
function Trigger:ReceiveBeginPlay()
    Trigger.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Trigger:ReceiveTick(DeltaTime)
    Trigger.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Trigger:ReceiveEndPlay()
    Trigger.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Trigger:GetReplicatedProperties()
    return
end
--]]

--[[
function Trigger:GetAvailableServerRPCs()
    return
end
--]]

return Trigger