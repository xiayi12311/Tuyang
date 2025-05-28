---@class BPWidget_ShopItem_C:UUserWidget
---@field BPWidget_PayLock BPWidget_PayLock_C
---@field Image_Background UImage
---@field Image_Price UImage
---@field ItemButton UButton
---@field Picture UImageEx
--Edit Below--
local Delegate = require("common.Delegate")

local BPWidget_ShopItem = BPWidget_ShopItem or {}

function BPWidget_ShopItem:Construct()
	self:LuaInit();
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_ShopItem:Construct] self=%s", GetObjectFullName_Dev(self)))
    ugcprint("BPWidget_ShopItemConstruct"..self.DataSource.Key) 
    BPWidget_ShopItem.SuperClass.Construct(self)

    self.ItemButton = self:GetWidgetFromName("ItemButton")
    self.GoldTextBlock = self:GetWidgetFromName("GoldTextBlock")
    self.DescriptionTextBlock = self:GetWidgetFromName("DescriptionTextBlock")
    self.Picture = self:GetWidgetFromName("Picture")
    self.BulletNeed = self:GetWidgetFromName("BulletNeed")
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    self.ItemButton.OnReleased:Add(
        function ()
            ugcprint("ItemButtonOnReleased0"..self.DataSource.Key) 
            local PlayerController = GameplayStatics.GetPlayerController(self,0)
            PlayerController:ServerRPC_Buy(self.DataSource.Key)
        end
    )

    self:InvalidateDataSource()
end

function BPWidget_ShopItem:InvalidateDataSource()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_ShopItem:InvalidateDataSource] self=%s", GetObjectFullName_Dev(self)))

    if self.DataSource ~= nil then
        self.GoldTextBlock:SetText(self.DataSource.Cost)
        self.DescriptionTextBlock:SetText(self.DataSource.Description)
        self.Picture:SetBrushFromTexture(UE.LoadObject(self.DataSource.Picture),true)
        --if  self.DataSource.BulletNeed ~= nil then
        self.BulletNeed:SetText(self.DataSource.BulletNeed)
        --end
        self:PayLock(self.DataSource.PayLockNum == 1)
    end
end

-- [Editor Generated Lua] function define Begin:
function BPWidget_ShopItem:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	
	self.ItemButton.OnPressed:Add(self.ItemButton_OnPressed, self);
	-- [Editor Generated Lua] BindingEvent End;
end



function BPWidget_ShopItem:ItemButton_OnPressed()
	return nil;
end

function BPWidget_ShopItem:PayLock(InbLock)
    if UE.IsValid(self.BPWidget_PayLock) == false then
        UGCLog.Log("[YYH]PayLock BPWidget_PayLock == nil")
        return
    end
    if InbLock then
        self.BPWidget_PayLock:SetVisibility(ESlateVisibility.Visible)
    else
        self.BPWidget_PayLock:SetVisibility(ESlateVisibility.Hidden)
    end
end
-- [Editor Generated Lua] function define End;

return BPWidget_ShopItem