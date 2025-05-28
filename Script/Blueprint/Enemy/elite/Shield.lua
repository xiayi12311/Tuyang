---@class Shield_C:ZombieShield_C
--Edit Below--
local Shield = {}
 
--[[
function Shield:ReceiveBeginPlay()
    Shield.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Shield:ReceiveTick(DeltaTime)
    Shield.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Shield:ReceiveEndPlay()
    Shield.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Shield:GetReplicatedProperties()
    return
end
--]]

--[[
function Shield:GetAvailableServerRPCs()
    return
end
--]]

return Shield