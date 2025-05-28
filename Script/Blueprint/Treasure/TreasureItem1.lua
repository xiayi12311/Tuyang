---@class TreasureItem1_C:BP_TreasureBox_C
---@field ParticleSystem UParticleSystemComponent
--Edit Below--
local TreasureItem = {}
 
--[[
function TreasureItem:ReceiveBeginPlay()
    TreasureItem.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function TreasureItem:ReceiveTick(DeltaTime)
    TreasureItem.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TreasureItem:ReceiveEndPlay()
    TreasureItem.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TreasureItem:GetReplicatedProperties()
    return
end
--]]

--[[
function TreasureItem:GetAvailableServerRPCs()
    return
end
--]]

return TreasureItem