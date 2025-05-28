---@class Shop_Land1_C:AActor
---@field Box UBoxComponent
---@field StaticMesh UStaticMeshComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local Shop2_Land = {}
Shop2_Land.BPWidget_ShopEntry = nil

function Shop2_Land:GetBPWidget_ShopEntryClassPath()
    return string.format([[UGCWidgetBlueprint'%sAsset/BPWidget_ShopEntry.BPWidget_ShopEntry_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

function Shop2_Land:GetBPWidget_ShopClassPath()
    return string.format([[UGCWidgetBlueprint'%sAsset/BPWidget_Shop.BPWidget_Shop_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

function Shop2_Land:ReceiveBeginPlay()
    Shop2_Land.SuperClass.ReceiveBeginPlay(self)
	if self:HasAuthority() == false then
		--添加碰撞体检测回调函数
		self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap,self)
		self.Box.OnComponentEndOverlap:Add(self.Box_OnComponentEndOverlap, self);
	end
	local GameState = GameplayStatics.GetGameState(self)
	self.DataSource = GameState.BP_ShopComponent.DataSource1
end



function Shop2_Land:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)

	-- 仅在客户端进行处理
    if not self:HasAuthority() and OtherActor:IsPlayerControlled() then
		local PlayerController = OtherActor:GetPlayerControllerSafety()
        if PlayerController then
		local BPWidget_ShopEntryClass = UE.LoadClass(self:GetBPWidget_ShopEntryClassPath())
		if UE.IsValid(PlayerController) and UE.IsValid(PlayerController.PlayerState) then
			--当碰撞体重叠时，且没有商店按钮实例时，生成商店按钮实例，并将商店按钮UI添加到视口中
			if not UE.IsValid(self.BPWidget_ShopEntry) then 
				self.BPWidget_ShopEntry = UserWidget.NewWidgetObjectBP(PlayerController, BPWidget_ShopEntryClass)
				self.BPWidget_ShopEntry.DataSource = self.DataSource
				self.BPWidget_ShopEntry:AddToViewport(0)
			end
			
		end
	end
    end	
end


function Shop2_Land:Box_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
	-- 仅在客户端进行处理
    if not self:HasAuthority() and OtherActor:IsPlayerControlled() then
        local PlayerController =OtherActor:GetPlayerControllerSafety()
		local BPWidget_ShopEntryClass = UE.LoadClass(self:GetBPWidget_ShopEntryClassPath())
		
		if UE.IsValid(PlayerController) and UE.IsValid(PlayerController.PlayerState) then
			local isintheshop = PlayerController.PlayerState.IsInTheShop1 
			if isintheshop then
				PlayerController.PlayerState:FalseIsInTheShop1()	
			end
			--当离开碰撞体时，调用CloseUI用于销毁商店界面，然后销毁商店按钮
			self.BPWidget_ShopEntry:CloseUI()
			self.BPWidget_ShopEntry:RemoveFromViewport()
        	self.BPWidget_ShopEntry = nil
			
			
				
		end
    else
		local PlayerController = GameplayStatics.GetPlayerController(self, 0)
		PlayerController.PlayerState:ResetPage()
	end
end

-- [Editor Generated Lua] function define End;

return Shop2_Land