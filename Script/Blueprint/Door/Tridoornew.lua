---@class Tridoornew_C:StaticMeshActor
---@field StaticMesh1 UStaticMeshComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local Tridoornew = {}
 
local EventSystem =  require('Script.common.UGCEventSystem')
function Tridoornew:ReceiveBeginPlay()
    Tridoornew.SuperClass.ReceiveBeginPlay(self)
    EventSystem:AddListener("DOOROpen",self.DestorySelf,self)
end


--[[
function Tridoornew:ReceiveTick(DeltaTime)
    Tridoornew.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Tridoornew:ReceiveEndPlay()
    Tridoornew.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Tridoornew:GetReplicatedProperties()
    return
end
--]]

--[[
function Tridoornew:GetAvailableServerRPCs()
    return
end
--]]
function Tridoornew:DestorySelf()
    ugcprint("Door Destory!")
     local oBTimerDelegate1 = ObjectExtend.CreateDelegate(self,
    function() 
        self:K2_DestroyActor()

    end)
    KismetSystemLibrary.K2_SetTimerDelegateForLua(oBTimerDelegate1, self, 10, false)
    return
end
return Tridoornew