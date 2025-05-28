---@class BPWidget_ShopItem_TuYang_UpLevel_C:UUserWidget
---@field BulletNeed UTextBlock
---@field DescriptionTextBlock UTextBlock
---@field Image_Background UImage
---@field Picture UImageEx
--Edit Below--
local Delegate = require("common.Delegate")

local BPWidget_ShopItem_TuYang_UpLevel = BPWidget_ShopItem_TuYang_UpLevel or {}

function BPWidget_ShopItem_TuYang_UpLevel:Construct()
	self:LuaInit();
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_ShopItem_TuYang_UpLevel:Construct] self=%s", GetObjectFullName_Dev(self)))
    print("BPWidget_ShopItem_TuYang_UpLevel:Construct")
    --UGCLog.Log("BPWidget_ShopItem_TuYang_UpLevel:Construct")
    BPWidget_ShopItem_TuYang_UpLevel.SuperClass.Construct(self)

  
    --self.GoldTextBlock = self:GetWidgetFromName("GoldTextBlock")
    self.DescriptionTextBlock = self:GetWidgetFromName("DescriptionTextBlock")
    self.BulletNeed = self:GetWidgetFromName("BulletNeed")
    self.Picture = self:GetWidgetFromName("Picture")
    
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)

    self:InvalidateDataSource()
end

function BPWidget_ShopItem_TuYang_UpLevel:InvalidateDataSource()
    sandbox.LogNormalDev(StringFormat_Dev("[BPWidget_ShopItem_TuYang_UpLevel:InvalidateDataSource] self=%s", GetObjectFullName_Dev(self)))
    print("BPWidget_ShopItem_TuYang_UpLevel:InvalidateDataSource")
    if self.DataSource ~= nil then
        --self.GoldTextBlock:SetText(self.DataSource.Cost)
        self.DescriptionTextBlock:SetText(self.DataSource.Description)
        self.Picture:SetBrushFromTexture(UE.LoadObject(self.DataSource.Picture),true)
        --if  self.DataSource.BulletNeed ~= nil then
        self.BulletNeed:SetText(self.DataSource.BulletNeed)
        --end
        
    end
end

-- [Editor Generated Lua] function define Begin:
function BPWidget_ShopItem_TuYang_UpLevel:LuaInit()
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





-- [Editor Generated Lua] function define End;

return BPWidget_ShopItem_TuYang_UpLevel