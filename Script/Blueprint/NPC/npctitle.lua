---@class npctitle_C:AActor
---@field CustomWidget UCustomWidgetComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local npctitle = {}
 
--[[
function npctitle:ReceiveBeginPlay()
    npctitle.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function npctitle:ReceiveTick(DeltaTime)
    npctitle.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function npctitle:ReceiveEndPlay()
    npctitle.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function npctitle:GetReplicatedProperties()
    return
end
--]]

--[[
function npctitle:GetAvailableServerRPCs()
    return
end
--]]

return npctitle