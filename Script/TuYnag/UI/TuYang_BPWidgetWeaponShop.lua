---@class TuYang_BPWidgetWeaponShop_C:UUserWidget
---@field NewAnimation_2 UWidgetAnimation
---@field NewAnimation_1 UWidgetAnimation
---@field Background UImage
---@field Button_Buy UButton
---@field LeftDown UImage
---@field LeftUp UImage
---@field RightDown UImage
---@field RightUp UImage
---@field TextBlock_4 UTextBlock
---@field TextBlock_Cost UTextBlock
---@field TextBlock_ShopName UTextBlock
--Edit Below--
local TuYang_ShopConfig = require("Script.TuYang_ShopConfig")
local TuYang_BPWidgetWeaponShop = { bInitDoOnce = false } 
local Key = nil
TuYang_BPWidgetWeaponShop.Cost = 0
TuYang_BPWidgetWeaponShop.ShopID = 0
TuYang_BPWidgetWeaponShop.GroundID = 0
TuYang_BPWidgetWeaponShop.ShopName = ""
function TuYang_BPWidgetWeaponShop:Construct()
    UGCLog.Log("[LJH]TuYang_BPWidgetWeaponShop:Construct")
	self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.Forward,1)
    self.TextBlock_Cost = self:GetWidgetFromName("TextBlock_Cost")
    self.Button_Buy.OnReleased:Add(self.Button_Buy_OnReleased, self);
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local tData = PlayerController:ModifyGetShopItems(TuYang_ShopConfig.ItemKey.WeaponShop,self.GroundID,self.ShopID)
    self.Cost = tData.Cost
    self.ShopName = tData.Name
    --UGCLog.Log("[YYH]TuYang_BPWidgetWeaponShopConstruct tcost:",tcost, tName)
    self.TextBlock_Cost:SetText(tostring(self.Cost))
    self.TextBlock_ShopName:SetText(self.ShopName)

    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    PlayerController.BPWidget_WeaponShop = self
    PlayerController.GoldCommodityList[5].Widget = PlayerController.BPWidget_WeaponShop
end

function TuYang_BPWidgetWeaponShop:InitializeWidget()

end

function TuYang_BPWidgetWeaponShop:Tick(MyGeometry, InDeltaTime)
    if self:IsInViewport() then
        local PlayerController = GameplayStatics.GetPlayerController(self, 0)
        PlayerController.BPWidget_WeaponShop = self
        local tcost = PlayerController:HandleStageDiscount(self.Cost)
        tcost = math.floor(tcost)
        self.TextBlock_Cost:SetText(tostring(tcost))
    end
end

-- function TuYang_BPWidgetWeaponShop:Destruct()

-- end


function TuYang_BPWidgetWeaponShop:Button_Buy_OnReleased()
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    PlayerController:ServerRPC_WeaponBuy(self.GroundID,self.ShopID)
    --PlayerController:ServerRPC_Buy(5)
end

function TuYang_BPWidgetWeaponShop:UpDataCostUI(InCost)
    --UGCLog.Log("[ljh]TuYang_BPWidgetWeaponShop:Close")
    self.TextBlock_Cost:SetText(tostring(InCost))
end

function TuYang_BPWidgetWeaponShop:Close()
    --UGCLog.Log("[ljh]TuYang_BPWidgetWeaponShop:Close")
    self:RemoveFromViewport()
end
function TuYang_BPWidgetWeaponShop:CheckBuyItem(iReason)
    if iReason == 1 then
        self:PlayAnimation(self.NewAnimation_2,0,1,EUMGSequencePlayMode.Forward,1)
    end
end
return TuYang_BPWidgetWeaponShop