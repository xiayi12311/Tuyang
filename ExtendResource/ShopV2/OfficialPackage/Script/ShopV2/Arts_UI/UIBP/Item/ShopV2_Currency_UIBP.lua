---@class ShopV2_Currency_UIBP_C:UUserWidget
---@field AmountText UTextBlock
---@field CurrencyIcon UImage
---@field ItemID int32
---@field CurrencyIconTexture UTexture2D
--Edit Below--
local ShopV2_Currency_UIBP = 
{ 
    bInitDoOnce = false;
    bBindBackpackDelegate = false;
} 

function ShopV2_Currency_UIBP:Construct()
	
    self.CurrencyIcon:SetBrushFromTexture(self.CurrencyIconTexture);
    self.AmountText:SetText("0");

    ShopV2Manager.OnItemNumChangeDelegate:Add(self.Refresh, self);
end

function ShopV2_Currency_UIBP:Destruct()

    ShopV2Manager.OnItemNumChangeDelegate:Remove(self.Refresh, self);
end

function ShopV2_Currency_UIBP:Refresh()

    local PlayerController = STExtraGameplayStatics.GetFirstPlayerController(self);
    local CoinNum = ShopV2Manager:GetVirtualItemManager():GetItemNum(self.ItemID);
    self.AmountText:SetText(tostring(CoinNum));
end

return ShopV2_Currency_UIBP
