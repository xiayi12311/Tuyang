---@class Shop1_Land1_C:AActor
---@field Box UBoxComponent
---@field StaticMesh UStaticMeshComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local Shop1_Land1 = {}
Shop1_Land1.BPWidget_ShopEntry = nil

function Shop1_Land1:GetBPWidget_ShopEntryClassPath()
    return string.format([[UGCWidgetBlueprint'%sAsset/BPWidget_ShopEntry.BPWidget_ShopEntry_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

function Shop1_Land1:GetBPWidget_ShopClassPath()
    return string.format([[UGCWidgetBlueprint'%sAsset/BPWidget_Shop.BPWidget_Shop_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

function Shop1_Land1:ReceiveBeginPlay()
    Shop1_Land1.SuperClass.ReceiveBeginPlay(self)
	if self:HasAuthority() == false then
		--添加碰撞体检测回调函数
		self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap,self)
		self.Box.OnComponentEndOverlap:Add(self.Box_OnComponentEndOverlap, self);
	end
	local GameState = GameplayStatics.GetGameState(self)
	self.DataSource = GameState.BP_ShopComponent.DataSource
end


--[[
function Shop1_Land1:ReceiveTick(DeltaTime)
    Shop1_Land1.SuperClass.ReceiveTick(self, DeltaTime)
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
	local isintheshop = PlayerController.PlayerState.IsInTheShop
	
end
--]]

function Shop1_Land1:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)

	-- 仅在客户端进行处理
    if not self:HasAuthority() and OtherActor:IsPlayerControlled() then
		local PlayerController = OtherActor:GetPlayerControllerSafety()
        if PlayerController then
		local BPWidget_ShopEntryClass = UE.LoadClass(self:GetBPWidget_ShopEntryClassPath())
		if UE.IsValid(PlayerController) and UE.IsValid(PlayerController.PlayerState) then
			--isintheshop为定义在玩家状态中的变量，用于判断是否在碰撞体区域内
			
			local isintheshop = PlayerController.PlayerState.IsInTheShop

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


function Shop1_Land1:Box_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
	-- 仅在客户端进行处理
    if not self:HasAuthority() and OtherActor:IsPlayerControlled() then
        local PlayerController = GameplayStatics.GetPlayerController(self, 0)
		local BPWidget_ShopEntryClass = UE.LoadClass(self:GetBPWidget_ShopEntryClassPath())
		
		if UE.IsValid(PlayerController) and UE.IsValid(PlayerController.PlayerState) then
			local isintheshop = PlayerController.PlayerState.IsInTheShop 
			if isintheshop then
				PlayerController.PlayerState:FalseIsInTheShop()	
			end
			--当离开碰撞体时，调用CloseUI用于销毁商店界面，然后销毁商店按钮
			self.BPWidget_ShopEntry:CloseUI()
			self.BPWidget_ShopEntry:RemoveFromViewport()
        	self.BPWidget_ShopEntry = nil
			PlayerController.PlayerState:ResetPage()
			
				
		end
	else
		local PlayerController = GameplayStatics.GetPlayerController(self, 0)
		PlayerController.PlayerState:ResetPage()
    end
end

-- [Editor Generated Lua] function define End;

return Shop1_Land1