---@class TuYang_SkillDetails_C:UUserWidget
---@field NewAnimation_3 UWidgetAnimation
---@field NewAnimation_2 UWidgetAnimation
---@field NewAnimation_1 UWidgetAnimation
---@field BPWidget_BuffItemDetail BPWidget_BuffItemDetail_C
---@field CloseButton UButton
---@field Image_1 UImage
---@field Image_16 UImage
---@field Image_17 UImage
---@field Image_18 UImage
---@field Image_19 UImage
---@field Image_20 UImage
---@field Image_21 UImage
---@field Image_22 UImage
---@field Image_23 UImage
---@field Image_24 UImage
---@field Image_27 UImage
---@field Image_31 UImage
---@field Image_33 UImage
---@field Image_34 UImage
---@field Image_35 UImage
---@field Image_38 UImage
---@field Image_39 UImage
---@field Image_40 UImage
---@field Image_41 UImage
---@field Image_42 UImage
---@field Image_43 UImage
---@field Image_47 UImage
---@field Image_48 UImage
---@field Image_49 UImage
---@field Image_1_1 UImage
---@field Image_1_2 UImage
---@field Image_1_3 UImage
---@field Image_1_4 UImage
---@field Image_1_7 UImage
---@field Image_1_9 UImage
---@field Image_2_1 UImage
---@field Image_2_2 UImage
---@field Image_2_3 UImage
---@field Image_2_4 UImage
---@field Image_2_9 UImage
---@field Image_3_1 UImage
---@field Image_3_2 UImage
---@field Image_3_3 UImage
---@field Image_3_4 UImage
---@field Image_3_5 UImage
---@field Image_8_8 UImage
---@field Image_menu UImage
---@field TuYang_SkillDetailsIcon TuYang_SkillDetailsIcon_C
---@field UniformGridPanel_0 UUniformGridPanel
---@field VerticalBox_0 UVerticalBox
--Edit Below--
local TuYang_SkillDetails = { bInitDoOnce = false } 


TuYang_SkillDetails.BPWidget_ShopItemClassPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Buff/TuYang_SkillDetailsIcon.TuYang_SkillDetailsIcon_C')

TuYang_SkillDetails.BP_ShopClassPath = string.format([[UGCWidgetBlueprint'%sAsset/BP_Shop.BP_Shop_C']], UGCMapInfoLib.GetRootLongPackagePath())

TuYang_SkillDetails.BPWidget_ShopItemClass = nil

TuYang_SkillDetails.IsInitializedForPlayer = false

TuYang_SkillDetails.ShopID = 0

local Page = 1
local PageMax = {}
local Category = 1

TuYang_SkillDetails.BuffArrangement = 
{
    {11,14,19,17,47,45},
    {13,15,18,20,48,46},
    {29,28,16,30,49,44},
    {21,23,22,27,50,39},
    {24,26,25,12,51},
    {9,7,3,10},
}

TuYang_SkillDetails.BuffIconWidget = {}

function TuYang_SkillDetails:Construct()
    --UGCLog.Log("BPWidget_Shop_TuYangConstruct")
    if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	self:LuaInit();
    TuYang_SkillDetails.SuperClass.Construct(self)
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)

    if GameplayStatics.GetPlayerController(self, 0):IsLocalPlayerController() then -- dedicated server better

        self.CloseButton.OnReleased:Add(self.Close, self);
        self:InvalidateDataSource()
    end
    --self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.forward,1)
end

function TuYang_SkillDetails:Destruct()
    TuYang_SkillDetails.SuperClass.Destruct(self)
end

function TuYang_SkillDetails:Tick(Geometry, DeltaSeconds)
    TuYang_SkillDetails.SuperClass.Tick(self, Geometry, DeltaSeconds)

end



function TuYang_SkillDetails:InvalidateDataSource()
    self:ClearItems()
    for i, row in ipairs(TuYang_SkillDetails.BuffArrangement) do
        for j, value in ipairs(row) do
            local ShopItem = UGCWidgetManagerSystem.AddNewUI(self.BPWidget_ShopItemClassPath,true)
            ShopItem.Key = value
            local solt = self.UniformGridPanel_0:AddChildToUniformGrid(ShopItem)
            solt:SetRow(i - 1)
            solt:SetColumn(j - 1)
            --ShopItem.Key = value--self.BuffArrangement[i][j]
            ShopItem:InItializeWidget(self,value)
            ShopItem:AddToViewport(self:GetZOrderOfViewportWidget())
            self.BuffIconWidget[value] = ShopItem
        end
    end
end

-- [Editor Generated Lua] function define Begin:
function TuYang_SkillDetails:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:

	-- [Editor Generated Lua] BindingEvent End;
end

function TuYang_SkillDetails:ClearItems()
    -- 清空所有的子控件
    if self.UniformGridPanel_0 then 
        self.UniformGridPanel_0:ClearChildren() 
    end
   
end

function TuYang_SkillDetails:OpenDetail(InKey)
    UGCLog.Log("TuYang_SkillDetails：OpenDetail",InKey)
    self.BPWidget_BuffItemDetail:InvalidateDataSource(InKey)
end

function TuYang_SkillDetails:Close()
    self:RemoveFromParent()
end

function TuYang_SkillDetails:SetAlreadyHaveBuff(InList)
    for k, v in pairs(InList) do
        if self.BuffIconWidget[v] then
            self.BuffIconWidget[v]:SetAlreadyHaveBuff()
        end
    end
end
-- [Editor Generated Lua] function define End;

return TuYang_SkillDetails