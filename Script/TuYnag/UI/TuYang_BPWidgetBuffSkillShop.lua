---@class TuYang_BPWidgetBuffSkillShop_C:UUserWidget
---@field NewAnimation_2 UWidgetAnimation
---@field NewAnimation_1 UWidgetAnimation
---@field Background UImage
---@field Button_Buy UButton
---@field Image_0 UImage
---@field LeftDown UImage
---@field LeftUp UImage
---@field RightDown UImage
---@field RightUp UImage
---@field TextBlock_3 UTextBlock
---@field TextBlock_4 UTextBlock
---@field TextBlock_CheckBuyItem UTextBlock
---@field TextBlock_Cost UTextBlock
---@field TextBlock_ShopName UTextBlock
--Edit Below--
local TuYang_ShopConfig = require("Script.TuYang_ShopConfig")
local TuYang_BPWidgetBuffSkillShop = { bInitDoOnce = false } 
local Key = nil
TuYang_BPWidgetBuffSkillShop.GroundID = 1
function TuYang_BPWidgetBuffSkillShop:Construct()
    --UGCLog.Log("[YYH]TuYang_BPWidgetBuffSkillShop:Construct")
	self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.Forward,1)
    self.TextBlock_Cost = self:GetWidgetFromName("TextBlock_Cost")
    self.Button_Buy.OnReleased:Add(self.Button_Buy_OnReleased, self);
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local tData = PlayerController:ModifyGetShopItems(TuYang_ShopConfig.ItemKey.BuffSkillShop,self.GroundID,self.ShopID)
    --local tcost = tData.Cost
    local tcost = PlayerController:HandleStageDiscount(tData.Cost)
    tcost = math.floor(tcost)
    local tName = tData.Name
    self.TextBlock_Cost:SetText(tostring(tcost))
    self.TextBlock_ShopName:SetText(tName)
    PlayerController.GoldCommodityList[4].Widget = self
end

function TuYang_BPWidgetBuffSkillShop:InitializeWidget()

end

function TuYang_BPWidgetBuffSkillShop:Tick(MyGeometry, InDeltaTime)

end

-- function TuYang_BPWidgetBuffSkillShop:Destruct()

-- end


function TuYang_BPWidgetBuffSkillShop:Button_Buy_OnReleased()
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    PlayerController:ServerRPC_BuffSkillBuy(self.GroundID,self.ShopID)
   
end

function TuYang_BPWidgetBuffSkillShop:Close()
    --UGCLog.Log("[ljh]TuYang_BPWidgetBuffSkillShop:Close")
    self:RemoveFromViewport()
end
function TuYang_BPWidgetBuffSkillShop:CheckBuyItem(iReason)
    if iReason == 0 then
        return
    end
    if iReason == 1 then
        self.TextBlock_CheckBuyItem:SetText("金币不足")
    elseif iReason == 6 then
        self.TextBlock_CheckBuyItem:SetText("粽子不足")
    end
    self:PlayAnimation(self.NewAnimation_2,0,1,EUMGSequencePlayMode.Forward,1)
end
return TuYang_BPWidgetBuffSkillShop