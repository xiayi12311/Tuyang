---@class hud_C:BP_BattleRoyaleHUD_UGC_C
--Edit Below--
local hud = {}
 
--[[
function hud:ReceiveBeginPlay()
    hud.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function hud:ReceiveTick(DeltaTime)
    hud.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function hud:ReceiveEndPlay()
    hud.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function hud:GetReplicatedProperties()
    return
end
--]]

--[[
function hud:GetAvailableServerRPCs()
    return
end
--]]

return hud