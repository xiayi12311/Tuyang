---@class shop_C:BP_Shop_C
---@field CustomWidget UCustomWidgetComponent
---@field SkeletalMesh USkeletalMeshComponent
--Edit Below--
local shop = {};


function shop:ReceiveBeginPlay()
    --self.SuperClass.ReceiveBeginPlay(self);
	self:LuaInit();
	
end


--[[
function shop:ReceiveTick(DeltaTime)
    self.SuperClass.ReceiveTick(self, DeltaTime);
end
--]]

--[[
function shop:ReceiveEndPlay()
    self.SuperClass.ReceiveEndPlay(self); 
end
--]]

--[[
function shop:GetReplicatedProperties()
    return
end
--]]

--[[
function shop:GetAvailableServerRPCs()
    return
end
--]]

function shop:GetAvailableServerRPCs()
    return "Server_Buy"
end


function shop:Server_Buy(ItemKey, PlayerController)
    sandbox.LogNormalDev(StringFormat_Dev("[BP_Shop:Server_Buy] self=%s ItemKey=%s PlayerController=%s", GetObjectFullName_Dev(self), ToString_Dev(ItemKey), GetObjectFullName_Dev(PlayerController)))
    --UGCLog.Log("BP_ShopServer_Buy", ItemKey, PlayerController)
    ugcprint("BP_ShopServer_Buy".. ItemKey)
    if self:HasAuthority() and UE.IsValid(PlayerController) and PlayerController:HasAuthority() then
		ugcprint("BP_ShopServer_Buy1 ".. ItemKey)
        self.BP_ShopComponent:Buy(ItemKey, PlayerController)
    else
		ugcprint("BP_ShopServer_Buy2 ".. ItemKey)
        local PlayerController = PlayerController or GameplayStatics.GetPlayerController(self, 0)
        UnrealNetwork.CallUnrealRPC(PlayerController, self, "Server_Buy", ItemKey, PlayerController)
    end
end


-- [Editor Generated Lua] function define Begin:
function shop:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	
	-- [Editor Generated Lua] BindingEvent End;
end

function shop:CustomBoxCollision_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    if not self:HasAuthority() then
        print("Program_Begin")
        local PlayerController = GameplayStatics.GetPlayerController(self, 0)
	    if UE.IsValid(PlayerController) and UE.IsValid(PlayerController.PlayerState) then
		    local isintheshop = PlayerController.PlayerState.IsInTheShop 
		    if not isintheshop then
			    PlayerController.PlayerState:TrueIsInTheShop()
                print("ok")
		    end		
	    end
    end   
end

function shop:CustomBoxCollision_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
    if not self:HasAuthority() then
        local PlayerController = GameplayStatics.GetPlayerController(self, 0)
	    if UE.IsValid(PlayerController) and UE.IsValid(PlayerController.PlayerState) then
		    local isintheshop = PlayerController.PlayerState.IsInTheShop 
		    if isintheshop then
			    PlayerController.PlayerState:FalseIsInTheShop()
		    end	
	    end
    end	
end

-- [Editor Generated Lua] function define End;

return shop;