---@class TreasureL1_C:BP_TreasureBox_C
---@field ParticleSystem UParticleSystemComponent
--Edit Below--
local TreasureGun = {}
 
--[[
function TreasureGun:ReceiveBeginPlay()
    TreasureGun.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function TreasureGun:ReceiveTick(DeltaTime)
    TreasureGun.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TreasureGun:ReceiveEndPlay()
    TreasureGun.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TreasureGun:GetReplicatedProperties()
    return
end
--]]

--[[
function TreasureGun:GetAvailableServerRPCs()
    return
end
--]]

return TreasureGun