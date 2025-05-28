---@class TuYang_TacticalBuffsVehicle_C:ArmedBuggy_C
---@field Cube UStaticMeshComponent
--Edit Below--
local TuYang_TacticalBuffsVehicle = {}
 

function TuYang_TacticalBuffsVehicle:ReceiveBeginPlay()
    TuYang_TacticalBuffsVehicle.SuperClass.ReceiveBeginPlay(self)
end


--[[
function TuYang_TacticalBuffsVehicle:ReceiveTick(DeltaTime)
    TuYang_TacticalBuffsVehicle.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TuYang_TacticalBuffsVehicle:ReceiveEndPlay()
    TuYang_TacticalBuffsVehicle.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TuYang_TacticalBuffsVehicle:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_TacticalBuffsVehicle:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_TacticalBuffsVehicle