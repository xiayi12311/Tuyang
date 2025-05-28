---@class GameEndActor_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local GameEndActor = {}
 
function GameEndActor:ReceiveBeginPlay()
    GameEndActor.SuperClass.ReceiveBeginPlay(self)
    if self:HasAuthority() then
    local oBTimerDelegate1 = ObjectExtend.CreateDelegate(self,
    function()      
        ugcprint("Spawn Game End")            
    end)
    KismetSystemLibrary.K2_SetTimerDelegateForLua(oBTimerDelegate1, self, 10, false)
end
    return
end
--[[
function GameEndActor:ReceiveTick(DeltaTime)
    GameEndActor.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function GameEndActor:ReceiveEndPlay()
    GameEndActor.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function GameEndActor:GetReplicatedProperties()
    return
end
--]]

--[[
function GameEndActor:GetAvailableServerRPCs()
    return
end
--]]

return GameEndActor