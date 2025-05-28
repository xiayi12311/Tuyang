---@class Tuyang_BuffSkillShopLand_C:BP_ShopLandBase_C
---@field StaticMesh_0 UStaticMeshComponent
--Edit Below--
--local Tuyang_BuffSkillShopLand = {}
local BP_ShopLandBase = require("Script.TuYnag.BP_ShopLandBase")
local Tuyang_BuffSkillShopLand = setmetatable({}, BP_ShopLandBase)
Tuyang_BuffSkillShopLand.__index = Tuyang_BuffSkillShopLand
-- 保留原有SuperClass引用
Tuyang_BuffSkillShopLand.SuperClass = BP_ShopLandBase


Tuyang_BuffSkillShopLand.BPWidget_ShopEntry = nil
Tuyang_BuffSkillShopLand.BPWidget_Shop = nil

function Tuyang_BuffSkillShopLand:GetBPWidget_ShopClassPath()
    return UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/TuYang_BPWidgetBuffSkillShop.TuYang_BPWidgetBuffSkillShop_C')
end


function Tuyang_BuffSkillShopLand:ReceiveBeginPlay()
	--老是报错
	Tuyang_BuffSkillShopLand.SuperClass.ReceiveBeginPlay(self)
    
		
	local GameState = UGCGameSystem.GetGameState()
	table.insert(GameState.BuffSkillShopLandList, self)
end


--[[
function Tuyang_BuffSkillShopLand:ReceiveTick(DeltaTime)
    Tuyang_BuffSkillShopLand.SuperClass.ReceiveTick(self, DeltaTime)
	local PlayerController = GameplayStatics.GetPlayerController(self, 0)
	local isintheshop = PlayerController.PlayerState.IsInTheShop
	
end
--]]

function Tuyang_BuffSkillShopLand:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
	ugcprint("Box_OnComponentBeginOverlap0")
	--local PlayerController = OtherActor:GetPlayerControllerSafety()
	local PlayerController = UGCGameSystem.GetPlayerControllerByPlayerPawn(OtherActor)
	-- 仅在客户端进行处理
    if not self:HasAuthority() then
		
		if OtherActor.IsPlayerControlled and OtherActor:IsPlayerControlled() then
			ugcprint("Box_OnComponentBeginOverlap")
			 --在碰撞体区域内时，点击按钮后如果没有商店界面则生成商店界面，如果存在商店界面则销毁商店界面
			if UE.IsValid(PlayerController) and PlayerController:IsLocalController() then
				if UE.IsValid(self.BPWidget_Shop) then
					self.BPWidget_Shop:RemoveFromViewport()
				end
				local tClassPath = self:GetBPWidget_ShopClassPath()
				if UE.IsValid(PlayerController) and PlayerController:IsLocalController() and UGCPawnAttrSystem.GetHealth(PlayerController.pawn) > 0 then
					local BPWidget_ShopClass = UE.LoadClass(tClassPath)
					if UE.IsValid(BPWidget_ShopClass) then
						if self.BPWidget_Shop == nil then
							self.BPWidget_Shop = UserWidget.NewWidgetObjectBP(PlayerController, BPWidget_ShopClass)
						end
						if UE.IsValid(self.BPWidget_Shop) then
							self.BPWidget_Shop.ShopID = self.ShopID
							self.BPWidget_Shop.GroundID = self.GroundID
							self.BPWidget_Shop:AddToViewport(10000-1)
						end
					end
				end
			end
		end
    end	
	if UE.IsValid(PlayerController) then
		PlayerController:SetBPWidget_BuffSkillShopUI(self.BPWidget_Shop,self.ShopID)
	else
		UGCLog.Log("Error Tuyang_BuffSkillShopLand:Box_OnComponentBeginOverlap PlayerController is nil")
	end
	
end


function Tuyang_BuffSkillShopLand:Box_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
	--	仅在客户端进行处理
    if not self:HasAuthority() then
		if OtherActor:IsPlayerControlled() then
			if UE.IsValid(self.BPWidget_Shop) then
				self.BPWidget_Shop:RemoveFromViewport()
			end
		end
    end
end

-- [Editor Generated Lua] function define End;

return Tuyang_BuffSkillShopLand