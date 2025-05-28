---@class BP_Shop_C:AActor
---@field DefaultSceneRoot USceneComponent
---@field BP_ShopComponent UBP_ShopComponent_C
--Edit Below--
local BP_Shop = BP_Shop or {}

function BP_Shop:GetAvailableServerRPCs()
    return "Server_Buy"
end
function BP_Shop:ReceiveBeginPlay()
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    ugcprint("BP_ShopReceiveBgeinPlay  "..GetObjectFullName_Dev(PlayerController))
    self:SetOwner(PlayerController)
    BP_Shop.SuperClass.ReceiveBeginPlay(self)
    local tOwner = self:GetOwner()
    ugcprint("BP_ShopReceiveBgeinPlay1  "..GetObjectFullName_Dev(tOwner))
end

function BP_Shop:Server_Buy(ItemKey, PlayerController)
    sandbox.LogNormalDev(StringFormat_Dev("[BP_Shop:Server_Buy] self=%s ItemKey=%s PlayerController=%s", GetObjectFullName_Dev(self), ToString_Dev(ItemKey), GetObjectFullName_Dev(PlayerController)))
    --UGCLog.Log("BP_ShopServer_Buy", ItemKey, PlayerController)
    ugcprint("BP_ShopServer_Buy".. ItemKey)
    if self:HasAuthority() and UE.IsValid(PlayerController) and PlayerController:HasAuthority() then
        self.BP_ShopComponent:Buy(ItemKey, PlayerController)
    else
        local PlayerController = PlayerController or GameplayStatics.GetPlayerController(self, 0)
        UnrealNetwork.CallUnrealRPC(PlayerController, self, "Server_Buy", ItemKey, PlayerController)
    end
end


function BP_Shop:Function01()
    ugcprint("[1111111111 ]BP_ShopFunction01")
end
return BP_Shop