---@class BPC_Frozen_C:ActorComponent
---@field Temperature float
--Edit Below--
local BPC_Frozen = {};
 
function BPC_Frozen:ChangeTemperature(Offset)
    self.Temperature = self.Temperature + Offset
    if self.Temperature <= 0 then
        self:CreateIce()
    end
end

function BPC_Frozen:CreateIce()
    
end
--[[
function BPC_Frozen:ReceiveBeginPlay()
    self.SuperClass.ReceiveBeginPlay(self);
end
--]]

--[[
function BPC_Frozen:ReceiveTick(DeltaTime)
    self.SuperClass.ReceiveTick(self, DeltaTime);
end
--]]

--[[
function BPC_Frozen:ReceiveEndPlay()
    self.SuperClass.ReceiveEndPlay(self); 
end
--]]

--[[
function BPC_Frozen:GetReplicatedProperties()
    return
end
--]]

--[[
function BPC_Frozen:GetAvailableServerRPCs()
    return
end
--]]

return BPC_Frozen;