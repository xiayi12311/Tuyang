---@class Damagenumber_C:BP_DamageNumberHUD_UGC_C
--Edit Below--
local Damagenumber = {}
 
--[[
function Damagenumber:ReceiveBeginPlay()
    Damagenumber.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Damagenumber:ReceiveTick(DeltaTime)
    Damagenumber.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Damagenumber:ReceiveEndPlay()
    Damagenumber.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Damagenumber:GetReplicatedProperties()
    return
end
--]]

--[[
function Damagenumber:GetAvailableServerRPCs()
    return
end
--]]

return Damagenumber