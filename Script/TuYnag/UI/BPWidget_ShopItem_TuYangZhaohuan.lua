---@class BPWidget_ShopItem_TuYangZhaohuan_C:UUserWidget
---@field BPWidget_PayLock BPWidget_PayLock_C
---@field BulletNeed UTextBlock
---@field DescriptionTextBlock UTextBlock
---@field GoldTextBlock UTextBlock
---@field Image_0 UImage
---@field Image_Background UImage
---@field Image_Price UImage
---@field ItemButton UButton
---@field Picture UImageEx
--Edit Below--
local Delegate = require("common.Delegate")

local BPWidget_ShopItem_TuYang = BPWidget_ShopItem_TuYang or {}
BPWidget_ShopItem_TuYang.ShopID = 0
function BPWidget_ShopItem_TuYang:Construct()
	self:LuaInit();
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_ShopItem_TuYang:Construct] self=%s", GetObjectFullName_Dev(self)))
    print("BPWidget_ShopItem_TuYang:Construct")
    --UGCLog.Log("BPWidget_ShopItem_TuYang:Construct")
    BPWidget_ShopItem_TuYang.SuperClass.Construct(self)

    self.ItemButton = self:GetWidgetFromName("ItemButton")
    self.GoldTextBlock = self:GetWidgetFromName("GoldTextBlock")
    self.DescriptionTextBlock = self:GetWidgetFromName("DescriptionTextBlock")
    self.Picture = self:GetWidgetFromName("Picture")
    self.BulletNeed = self:GetWidgetFromName("BulletNeed")
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    self.ItemButton.OnReleased:Add(
        function ()
            --UGCLog.Log("BPWidget_ShopItem_TuYang:Construct")
            print("BPWidget_ShopItem_TuYang:Construct0"..self.DataSource.Key)
            local PlayerController = GameplayStatics.GetPlayerController(self,0)
            PlayerController:ServerRPC_MonsterShop(self.ShopID,self.DataSource.Key,self.DataSource.Belong)
        end
    )
    
    self:InvalidateDataSource()
end

function BPWidget_ShopItem_TuYang:InvalidateDataSource()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_ShopItem_TuYang:InvalidateDataSource] self=%s", GetObjectFullName_Dev(self)))
    print("BPWidget_ShopItem_TuYang:InvalidateDataSource")
    if self.DataSource ~= nil then
        self.GoldTextBlock:SetText(self.DataSource.Cost)
        self.DescriptionTextBlock:SetText(self.DataSource.Description)
        self.Picture:SetBrushFromTexture(UE.LoadObject(self.DataSource.Picture),true)
        --if  self.DataSource.BulletNeed ~= nil then
        self.BulletNeed:SetText(self.DataSource.BulletNeed)
        --end
        --self:PayLock(self.DataSource.PayLockNum == 1)
    end
end

-- [Editor Generated Lua] function define Begin:
function BPWidget_ShopItem_TuYang:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	
	--self.ItemButton.OnPressed:Add(self.ItemButton_OnPressed, self);
	-- [Editor Generated Lua] BindingEvent End;
end

function BPWidget_ShopItem_TuYang:PayLock(InbUnLock)
    if UE.IsValid(self.BPWidget_PayLock) == false then
        UGCLog.Log("[YYH]PayLock BPWidget_PayLock == nil")
        return
    end
    if InbUnLock then
        self.BPWidget_PayLock:SetVisibility(ESlateVisibility.Hidden)
    else
        self.BPWidget_PayLock:SetVisibility(ESlateVisibility.Visible)
        
    end
end


function BPWidget_ShopItem_TuYang:ItemButton_OnPressed()
	return nil;
end

-- [Editor Generated Lua] function define End;

return BPWidget_ShopItem_TuYang