---@class BPWidget_BuffItem_C:UUserWidget
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
---@field Image_Background UImage
---@field Image_Price UImage
---@field ItemButton UButton
---@field Picture UImageEx
---@field PRichText_0 UPRichText
---@field PRichText_1 UPRichText
---@field Text_Name UTextBlock
--Edit Below--
local Delegate = require("common.Delegate")
local TuYang_PlayerBuffConfig = require("Script.Config.TuYang_PlayerBuffConfig")
local HStringRule = require("Script.HStringRule")

local BPWidget_BuffItem = BPWidget_BuffItem or {}
BPWidget_BuffItem.CardWidget = nil
BPWidget_BuffItem.DataSource = {}
BPWidget_BuffItem.Key = 0

function BPWidget_BuffItem:Construct()
	self:LuaInit();
    --UGCLog.Log("BPWidget_BuffItem:Construct")
    BPWidget_BuffItem.SuperClass.Construct(self)

    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    self.ItemButton.OnReleased:Add(
        function ()
            --UGCLog.Log("BPWidget_BuffItem:Construct")
            UGCLog.Log("BPWidget_BuffItemOnButton",self.DataSource.Key)
            local PlayerController = GameplayStatics.GetPlayerController(self,0)
            PlayerController:OnBuffSkillChooseChick(self.DataSource.Key)
            self:Close()
        end
    )

    self:InvalidateDataSource()
end

function BPWidget_BuffItem:InvalidateDataSource()
    self.DataSource = TuYang_PlayerBuffConfig:GetItem(self.Key)
    --UGCLog.Log("BPWidget_BuffItemOnButtonInvalidateDataSource01",self.DataSource)
   
    if self.DataSource and self.DataSource.Name then

        if HStringRule then
            local tData = HStringRule:SplitIntoMultipleStringsBasedOnTheDelimiter(self.DataSource.Description)
            -- 效果
            self.PRichText_0:SetText(tData[1])
            -- 增益
            local tstring = HStringRule:SplitIntoMultipleLinesBasedOnTheDelimiter(tData[2])
            self.PRichText_1:SetText(tstring)
        end
        --self.GoldTextBlock:SetText(self.DataSource.Cost)
        --UGCLog.Log("BPWidget_BuffItemOnButtonInvalidateDataSource",self.DataSource)
        --self.DescriptionTextBlock:SetText(self.DataSource.Description)
        self.Picture:SetBrushFromTexture(UE.LoadObject(self.DataSource.Texture),true)
        self.Text_Name:SetText(self.DataSource.Name)
        
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
end

-- [Editor Generated Lua] function define Begin:
function BPWidget_BuffItem:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	self.PRichText_0:BindingProperty("Text", self.PRichText_0_Text, self);
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	
	--self.ItemButton.OnPressed:Add(self.ItemButton_OnPressed, self);
	-- [Editor Generated Lua] BindingEvent End;
end

function BPWidget_BuffItem:InitlizeWidget(InWidget)
    self.CardWidget = InWidget
end

function BPWidget_BuffItem:ItemButton_OnPressed()
	return nil;
end
function BPWidget_BuffItem:Close()
    self:RemoveFromViewport()
end
function BPWidget_BuffItem:PRichText_0_Text(ReturnValue)
	return "";
end
function BPWidget_BuffItem:PayLock(InbUnLock)
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

return BPWidget_BuffItem