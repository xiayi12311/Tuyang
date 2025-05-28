---@class BP_ShopLandBase_C:AActor
---@field Box UBoxComponent
---@field StaticMesh UStaticMeshComponent
---@field DefaultSceneRoot USceneComponent
---@field ShopID int32
---@field GroundID int32
--Edit Below--
-- 商店触发器基类
local BP_ShopLandBase = {}

BP_ShopLandBase.__index = BP_ShopLandBase
function BP_ShopLandBase:New(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
	-- 添加元表标识
    self._isBP_ShopLandBase = true
    return o
end
BP_ShopLandBase.BPWidget_ShopEntry = nil
BP_ShopLandBase.BPWidget_Shop = nil
function BP_ShopLandBase:GetBPWidget_ShopEntryClassPath()
    return UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/BPWidget_ShopEntry_TuYang.BPWidget_ShopEntry_TuYang_C')
end

function BP_ShopLandBase:GetBPWidget_ShopClassPath()
    return UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/TuYang_BPWidgetWeaponShop.TuYang_BPWidgetWeaponShop_C')
end
function BP_ShopLandBase:ReceiveBeginPlay()
	--UGCLog.Log("BP_ShopLandBase:ReceiveBeginPlay")
    BP_ShopLandBase.SuperClass.ReceiveBeginPlay(self)
	--添加碰撞体检测回调函数
	self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap,self)
	self.Box.OnComponentEndOverlap:Add(self.Box_OnComponentEndOverlap, self);
	
	
end


--[[
function BP_ShopLandBase:ReceiveTick(DeltaTime)
    BP_ShopLandBase.SuperClass.ReceiveTick(self, DeltaTime)	
end
--]]
function BP_ShopLandBase:GetReplicatedProperties()
    return "ShopID"
end
function BP_ShopLandBase:OnRep_ShopID()
	UGCLog.Log("BP_ShopLandBase:OnRep_ShopID", self.ShopID)
end

function BP_ShopLandBase:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
	ugcprint("Box_OnComponentBeginOverlap0")
	local PlayerController = OtherActor:GetPlayerControllerSafety()
	-- 仅在客户端进行处理
    if not self:HasAuthority() then
		if OtherActor:IsPlayerControlled() then
			ugcprint("Box_OnComponentBeginOverlap")
			 --在碰撞体区域内时，点击按钮后如果没有商店界面则生成商店界面，如果存在商店界面则销毁商店界面
			if UE.IsValid(PlayerController) and PlayerController:IsLocalController() then
				if UE.IsValid(self.BPWidget_Shop) then
					self.BPWidget_Shop:RemoveFromViewport()
				end
				local tClassPath = self:GetBPWidget_ShopClassPath()
				if UE.IsValid(PlayerController) and PlayerController:IsLocalController() and UGCPawnAttrSystem.GetHealth(PlayerController.pawn)>0 then
					local BPWidget_ShopClass = UE.LoadClass(tClassPath)
					if UE.IsValid(BPWidget_ShopClass) then
						if self.BPWidget_Shop == nil then
							self.BPWidget_Shop = UserWidget.NewWidgetObjectBP(PlayerController, BPWidget_ShopClass)
						end
						if UE.IsValid(self.BPWidget_Shop) then
							self.BPWidget_Shop.ShopID = self.ShopID
							self.BPWidget_Shop.GroundID = self.GroundID
							self.BPWidget_Shop:AddToViewport(10000)
						end
					end
				end
			end
		end
    end	
end


function BP_ShopLandBase:Box_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
	-- 仅在客户端进行处理
    if not self:HasAuthority() then
		if OtherActor:IsPlayerControlled() then
			if UE.IsValid(self.BPWidget_Shop) then
				self.BPWidget_Shop:RemoveFromViewport()
			end
		end
    end
	UGCLog.Log("BP_ShopLandBase:Box_OnComponentEndOverlap")
end

-- [Editor Generated Lua] function define End;

function BP_ShopLandBase:SetShopID(InNumber)
	self.ShopID = InNumber
	UGCLog.Log("BP_ShopLandBase:SetShopID", InNumber)
end


return BP_ShopLandBase