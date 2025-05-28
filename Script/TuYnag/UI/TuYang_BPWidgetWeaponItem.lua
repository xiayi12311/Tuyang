---@class TuYang_BPWidgetWeaponItem_C:UUserWidget
---@field Animation_LevelFourAppear UWidgetAnimation
---@field Animation_LevelThreeAppear UWidgetAnimation
---@field Animation_LevelTwoAppear UWidgetAnimation
---@field Animation_LevelOneAppear UWidgetAnimation
---@field BPWidget_PayLock BPWidget_PayLock_C
---@field CircleImage_1 UImage
---@field CircleImage_2 UImage
---@field DescriptionTextBlock UTextBlock
---@field GoldTextBlock UTextBlock
---@field Image_0 UImage
---@field Image_1 UImage
---@field Image_2 UImage
---@field Image_3 UImage
---@field Image_Background UImage
---@field Image_Level UImage
---@field Image_Price UImage
---@field ItemButton UButton
---@field Picture UImageEx
---@field Text_Name UTextBlock
---@field TextBlock_BaseDamage UTextBlock
---@field TextBlock_Clip UTextBlock
---@field TextBlock_ShootTime UTextBlock
--Edit Below--
local Delegate = require("common.Delegate")
local WeaponConfig = require("Script.TuYang_WeaponConfig")

local TuYang_BPWidgetWeaponItem = TuYang_BPWidgetWeaponItem or {}
TuYang_BPWidgetWeaponItem.CardWidget = nil
TuYang_BPWidgetWeaponItem.DataSource = {}
TuYang_BPWidgetWeaponItem.LevelTexturePath = 
{
    UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/UIpic/B.B'),
    UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/UIpic/A.A'),
    UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/UIpic/S.S'),
    UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/UIpic/sss.sss')
}

function TuYang_BPWidgetWeaponItem:Construct()
	self:LuaInit();
    --UGCLog.Log("TuYang_BPWidgetWeaponItem:Construct")
    TuYang_BPWidgetWeaponItem.SuperClass.Construct(self)
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    self.ItemButton.OnReleased:Add(
        function ()
            --UGCLog.Log("TuYang_BPWidgetWeaponItem:Construct")
            UGCLog.Log("BPWidget_BuffItemOnButton",self.DataSource.Key)
            local PlayerController = GameplayStatics.GetPlayerController(self,0)
            PlayerController:OnWeaponChooseChick(self.Key)
            if self.CardWidget then
                self.CardWidget:Close()
            end
        end
    )
    self.DataSource = WeaponConfig:GetWeaponItems(WeaponConfig.ItemKey.WeaponKey,self.Key)
    self:InvalidateDataSource()
    if self.DataSource.Level == 1 then
        self:PlayAnimation(self.Animation_LevelOneAppear,0,1,EUMGSequencePlayMode.Forward,1)
    elseif self.DataSource.Level == 2 then
        self:PlayAnimation(self.Animation_LevelTwoAppear,0,1,EUMGSequencePlayMode.Forward,1)
    elseif self.DataSource.Level == 3 then
        self:PlayAnimation(self.Animation_LevelThreeAppear,0,1,EUMGSequencePlayMode.Forward,1)
    elseif self.DataSource.Level == 4 then
        self:PlayAnimation(self.Animation_LevelFourAppear,0,1,EUMGSequencePlayMode.Forward,1)
    end
    
end

function TuYang_BPWidgetWeaponItem:InvalidateDataSource()
    if self.DataSource ~= nil then
        --self.GoldTextBlock:SetText(self.DataSource.Cost)

        self.DescriptionTextBlock:SetText(self.DataSource.Description)
        self.Picture:SetBrushFromTexture(UE.LoadObject(self.DataSource.TexturePath),true)
        --if  self.DataSource.BulletNeed ~= nil then
        self.Text_Name:SetText(self.DataSource.Name)
        --end
        self.Image_Level:SetBrushFromTexture(UE.LoadObject(self.LevelTexturePath[self.DataSource.Level]),true)

        local tItemID = self.DataSource.ItemID
        local tData = UGCGameSystem.GetTableDataByRowName(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Weapon/TuYang_WeaponConfig.TuYang_WeaponConfig'),tItemID)
        if tData then
            local tBaseDamage = tostring(tData.BulletBaseDamage)
            local tClip = tostring(tData.MaxBulletNumInOneClip)
            local tShootTime = math.floor((1 / tData.ShootIntervalTime)*10)
            tShootTime = tostring(tShootTime / 10).."/s"
            self.TextBlock_BaseDamage:SetText(tBaseDamage)
            self.TextBlock_Clip:SetText(tClip)
            self.TextBlock_ShootTime:SetText(tShootTime)
        else
            UGCLog.Log("Error [LJH]TuYang_BPWidgetWeaponItem:InvalidateDataSource tData == nil",tItemID)
        end
        
        -- if self.DataSource.Level == 1 then
            
        -- elseif self.DataSource.Level == 2 then
        --     self.Image_Level:SetColorAndOpacity({R=0.000000,G=0.000000,B=1.000000,A=1.000000})
        -- elseif self.DataSource.Level == 3 then
        --     self.Image_Level:SetColorAndOpacity({R=1.000000,G=0.000000,B=1.000000,A=1.000000})
        -- elseif self.DataSource.Level == 4 then
        --     self.Image_Level:SetColorAndOpacity({R=1.000000,G=0.000000,B=0.000000,A=1.000000})
        -- end
        
    end
end

-- [Editor Generated Lua] function define Begin:
function TuYang_BPWidgetWeaponItem:LuaInit()
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

function TuYang_BPWidgetWeaponItem:InitlizeWidget(InWidget)
    self.CardWidget = InWidget
end

function TuYang_BPWidgetWeaponItem:ItemButton_OnPressed()
	return nil;
end
function TuYang_BPWidgetWeaponItem:PayLock(InbUnLock)
    if UE.IsValid(self.BPWidget_PayLock) == false then
        UGCLog.Log("[LJH]PayLock BPWidget_PayLock == nil")
        return
    end
    if InbUnLock then
        self.BPWidget_PayLock:SetVisibility(ESlateVisibility.Hidden)
    else
        self.BPWidget_PayLock:SetVisibility(ESlateVisibility.Visible)
        
    end
end
-- [Editor Generated Lua] function define End;

return TuYang_BPWidgetWeaponItem