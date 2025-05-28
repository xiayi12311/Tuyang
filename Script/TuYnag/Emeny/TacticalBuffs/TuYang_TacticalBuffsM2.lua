---@class TuYang_TacticalBuffsM2_C:VehicleM2_C
--Edit Below--
local TuYang_TacticalBuffsM2 = {}
 
--[[
function TuYang_TacticalBuffsM2:ReceiveBeginPlay()
    TuYang_TacticalBuffsM2.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function TuYang_TacticalBuffsM2:ReceiveTick(DeltaTime)
    TuYang_TacticalBuffsM2.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TuYang_TacticalBuffsM2:ReceiveEndPlay()
    TuYang_TacticalBuffsM2.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TuYang_TacticalBuffsM2:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_TacticalBuffsM2:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_TacticalBuffsM2