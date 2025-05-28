---@class Secretweapon_C:StaticMeshActor
---@field CustomWidget UCustomWidgetComponent
--Edit Below--
local Springfestival = {}
 
--[[
function Springfestival:ReceiveBeginPlay()
    Springfestival.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Springfestival:ReceiveTick(DeltaTime)
    Springfestival.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Springfestival:ReceiveEndPlay()
    Springfestival.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Springfestival:GetReplicatedProperties()
    return
end
--]]

--[[
function Springfestival:GetAvailableServerRPCs()
    return
end
--]]

return Springfestival