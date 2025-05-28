---@class NPC1_C:NPC1_C
--Edit Below--
local NPC1 = {};
 
--[[
function NPC1:ReceiveBeginPlay()
    self.SuperClass.ReceiveBeginPlay(self);
end
--]]

--[[
function NPC1:ReceiveTick(DeltaTime)
    self.SuperClass.ReceiveTick(self, DeltaTime);
end
--]]

--[[
function NPC1:ReceiveEndPlay()
    self.SuperClass.ReceiveEndPlay(self); 
end
--]]

--[[
function NPC1:GetReplicatedProperties()
    return
end
--]]

--[[
function NPC1:GetAvailableServerRPCs()
    return
end
--]]

return NPC1;