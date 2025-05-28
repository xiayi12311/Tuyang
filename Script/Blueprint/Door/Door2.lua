---@class Door2_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local Door2 = {}
 
local EventSystem =  require('Script.common.UGCEventSystem')
function Door2:ReceiveBeginPlay()
    Door2.SuperClass.ReceiveBeginPlay(self)
    EventSystem:AddListener("TankEnd",self.DestorySelf,self)
end


--[[
function Door2:ReceiveTick(DeltaTime)
    Door2.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Door2:ReceiveEndPlay()
    Door2.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Door2:GetReplicatedProperties()
    return
end
--]]

--[[
function Door2:GetAvailableServerRPCs()
    return
end
--]]
function Door2:DestorySelf()
    local oBTimerDelegate1 = ObjectExtend.CreateDelegate(self,
    function()                            
        self:K2_DestroyActor()
        
    end)
KismetSystemLibrary.K2_SetTimerDelegateForLua(oBTimerDelegate1, self, 10, false)
    return
end
return Door2