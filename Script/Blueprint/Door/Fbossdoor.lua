---@class Fbossdoor_C:StaticMeshActor
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local Fbossdoor = {}
 
local EventSystem =  require('Script.common.UGCEventSystem')

function Fbossdoor:ReceiveBeginPlay()
    Fbossdoor.SuperClass.ReceiveBeginPlay(self)
    EventSystem:AddListener("TankEnd",self.DestorySelf,self)
end


--[[
function Fbossdoor:ReceiveTick(DeltaTime)
    Fbossdoor.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Fbossdoor:ReceiveEndPlay()
    Fbossdoor.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Fbossdoor:GetReplicatedProperties()
    return
end
--]]

--[[
function Fbossdoor:GetAvailableServerRPCs()
    return
end
--]]
function Fbossdoor:DestorySelf()
    ugcprint("Door Destory!")
     local oBTimerDelegate1 = ObjectExtend.CreateDelegate(self,
    function() 
        self:K2_DestroyActor()

    end)
    KismetSystemLibrary.K2_SetTimerDelegateForLua(oBTimerDelegate1, self, 10, false)
    return
end
return Fbossdoor