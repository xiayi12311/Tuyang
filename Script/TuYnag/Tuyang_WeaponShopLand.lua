---@class Tuyang_WeaponShopLand_C:BP_ShopLandBase_C
---@field CustomWidget UCustomWidgetComponent
---@field Box_0 UBoxComponent
---@field StaticMesh_0 UStaticMeshComponent
--Edit Below--
-- 商店触发器基类

local BP_ShopLandBase = require("Script.TuYnag.BP_ShopLandBase")
local Tuyang_WeaponShopLand = setmetatable({}, BP_ShopLandBase)
Tuyang_WeaponShopLand.__index = Tuyang_WeaponShopLand
-- 保留原有SuperClass引用
Tuyang_WeaponShopLand.SuperClass = BP_ShopLandBase

local TuYang_ShopConfig = require("Script.TuYang_ShopConfig")


Tuyang_WeaponShopLand.BPWidget_ShopEntry = nil
Tuyang_WeaponShopLand.BPWidget_Shop = nil

Tuyang_WeaponShopLand.DefaultShopID = 0
Tuyang_WeaponShopLand.ShopTitlePath = 
{
	UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Weapon/Shoptitle.Shoptitle_C'),
	UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Weapon/Shoptitle1.Shoptitle1_C'),
	UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Weapon/Shoptitle2.Shoptitle2_C'),
	UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Weapon/Shoptitle3.Shoptitle3_C')
}
Tuyang_WeaponShopLand.BP_WidgetShopTitle = nil
function Tuyang_WeaponShopLand:GetBPWidget_ShopClassPath()
    return UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/TuYang_BPWidgetWeaponShop.TuYang_BPWidgetWeaponShop_C')
end


function Tuyang_WeaponShopLand:ReceiveBeginPlay()
	Tuyang_WeaponShopLand.SuperClass.ReceiveBeginPlay(self)
    
	self.DefaultShopID = self.ShopID
	local GameState = UGCGameSystem.GetGameState()
	table.insert(GameState.WeaponShopLandList, self)
	self.BP_WidgetShopTitleClass = UE.LoadClass(self.ShopTitlePath[self.ShopID])
	if UE.IsValid(self.BP_WidgetShopTitleClass) then
		--self.CustomWidget.WidgetClass = self.BP_WidgetShopTitleClass
	end
	
end
function Tuyang_WeaponShopLand:GetReplicatedProperties()
    return "ShopID"
end
function Tuyang_WeaponShopLand:OnRep_ShopID()
	--UGCLog.Log("Tuyang_WeaponShopLand:OnRep_ShopID", self.ShopID)

end

--[[
function Tuyang_WeaponShopLand:ReceiveTick(DeltaTime)
    Tuyang_WeaponShopLand.SuperClass.ReceiveTick(self, DeltaTime)
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
	local isintheshop = PlayerController.PlayerState.IsInTheShop
	
end
--]]

function Tuyang_WeaponShopLand:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
	ugcprint("Box_OnComponentBeginOverlap0")
	local PlayerController = OtherActor:GetPlayerControllerSafety()
	-- 仅在客户端进行处理
    if not self:HasAuthority() then
		if OtherActor:IsPlayerControlled() then
			ugcprint("Box_OnComponentBeginOverlap")
			 --在碰撞体区域内时，点击按钮后如果没有商店界面则生成商店界面，如果存在商店界面则销毁商店界面
			if UE.IsValid(PlayerController) and PlayerController:IsLocalController() then
				--local isintheshop = PlayerController.PlayerState.IsInTheShop
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
							UGCLog.Log("Box_OnComponentBeginOverlap11",self.GroundID)
							self.BPWidget_Shop:RemoveFromViewport()
							self.BPWidget_Shop.ShopID = self.ShopID
							self.BPWidget_Shop.GroundID = self.GroundID
							self.BPWidget_Shop:AddToViewport(10000)
						end
					end
				end
			end
		end
    end	
	if UE.IsValid(PlayerController) then
		PlayerController:SetBPWidget_WeaponShopUI(self.BPWidget_Shop,self.ShopID)	
	end
	
end


function Tuyang_WeaponShopLand:Box_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
	-- 仅在客户端进行处理
    if not self:HasAuthority() then
		if OtherActor:IsPlayerControlled() then
			if UE.IsValid(self.BPWidget_Shop) then
				self.BPWidget_Shop:RemoveFromViewport()
			end
		end
    end
end

-- [Editor Generated Lua] function define End;

return Tuyang_WeaponShopLand