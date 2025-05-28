---@class BP_Widget_TuYangCard_C:UUserWidget
---@field NewAnimation_2 UWidgetAnimation
---@field NewAnimation_0 UWidgetAnimation
---@field NewAnimation_1 UWidgetAnimation
---@field Background UImage
---@field BPWidget_BuffItem BPWidget_BuffItem_C
---@field BPWidget_BuffItem_0 BPWidget_BuffItem_C
---@field BPWidget_BuffItem_1 BPWidget_BuffItem_C
---@field Button_0 UButton
---@field Button_Refresh UButton
---@field CanvasPanel_Close UCanvasPanel
---@field GoldTextBlock UTextBlock
---@field HorizontalBox_Card UHorizontalBox
---@field Image_Gold UImage
---@field LeftDown UImage
---@field LeftUp UImage
---@field RightDown UImage
---@field RightUp UImage
---@field TextBlock_RandamNum UTextBlock
---@field TextBlock_RemainingBuffSelectionTimes UTextBlock
---@field VerticalBox_1 UVerticalBox
---@field VerticalBox_2 UVerticalBox
---@field VerticalBox_3 UVerticalBox
--Edit Below--
local BP_Widget_TuYangCard = BP_Widget_TuYangCard or {} 
local TuYang_PlayerBuffConfig = require("Script.Config.TuYang_PlayerBuffConfig")

BP_Widget_TuYangCard.DataSource = {}
BP_Widget_TuYangCard.BuffCardPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/Buff/BPWidget_BuffItem.BPWidget_BuffItem_C')
BP_Widget_TuYangCard.BuffCardClass = nil

BP_Widget_TuYangCard.AllRandList = {}
BP_Widget_TuYangCard.RandList = {}
BP_Widget_TuYangCard.KeyList = {}
BP_Widget_TuYangCard.RefreshCost = 250

function BP_Widget_TuYangCard:Construct()
    UGCLog.Log("BP_Widget_TuYangCardConstruct")
	
    self.Button_0.OnClicked:Add(self.Button_0_OnClicked, self);
    self.Button_Refresh.OnClicked:Add(self.Button_Refresh_OnClicked,self)    
    if self.BuffCardClass == nil then
        self.BuffCardClass = UE.LoadClass(self.BuffCardPath)
    end
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local PlayerState = PlayerController.PlayerState
    PlayerController.BuffCardUI = self
    self:UpDateDataSource()

    --只在游戏开始时关闭X按钮（强制玩家选择初始武器）
    if PlayerState.bIsFirstChoose then
        self.CanvasPanel_Close:SetVisibility(ESlateVisibility.Hidden)
        self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.Forward,1)
    else
        self.CanvasPanel_Close:SetVisibility(ESlateVisibility.Visible)
        self:PlayAnimation(self.NewAnimation_0,0,1,EUMGSequencePlayMode.Forward,1)
    end
     if UE.IsValid(PlayerController) and UE.IsValid(PlayerState) then
       PlayerState.GoldChangedDelegate:Add(self.On_PlayerState_Gold_Changed, self)      
       self:On_PlayerState_Gold_Changed(PlayerState) 
    end
end


function BP_Widget_TuYangCard:Tick(MyGeometry, InDeltaTime)
    -- local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    -- local PlayerState = PlayerController.PlayerState
    -- self.TextBlock_RandamNum:SetText(self.RefreshCost)
    -- self.TextBlock_RemainingBuffSelectionTimes:SetText(tostring(PlayerState.iRemainingSelectionTimes_Buff))
end

-- function BP_Widget_TuYangCard:Destruct()

-- end


function BP_Widget_TuYangCard:UpDateDataSource()
    -- 清空所有的子控件
    if self.HorizontalBox_Card then 
        self.HorizontalBox_Card:ClearChildren() 
    end
    
    -- local PlayerState = PlayerController.PlayerState
    
    -- for i = 1, 3, 1 do
    --     local BPWidget_BuffCardItem = LuaExtendLibrary.NewLuaObject(self, self.BuffCardClass)
    --     --BPWidget_BuffCardItem.DataSource = TuYang_PlayerBuffConfig:GetItem(self.RandList[i])
    --     BPWidget_BuffCardItem.Key = self.RandList[i]
    --     --BPWidget_BuffCardItem.Key = 23
    --     self.HorizontalBox_Card:AddChild(BPWidget_BuffCardItem)
    --     BPWidget_BuffCardItem:InitlizeWidget(self)
    -- end
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    for k, v in pairs(self.KeyList) do
         local BPWidget_BuffCardItem = LuaExtendLibrary.NewLuaObject(self, self.BuffCardClass)
        BPWidget_BuffCardItem.Key = v
        --BPWidget_BuffCardItem.Key = 51
        self.HorizontalBox_Card:AddChild(BPWidget_BuffCardItem)
        BPWidget_BuffCardItem:InitlizeWidget(self)
        BPWidget_BuffCardItem:PayLock(PlayerController.BP_PayLockComponent:CheckUnlocked(tostring(v)))
    end
    
end

function BP_Widget_TuYangCard:Button_0_OnClicked()
    -- 跳过开场动画
    self:Close()
   
end

function BP_Widget_TuYangCard:SetKeyList(InKeyList)
    UGCLog.Log("TuYang_BPWidgetWeaponChoose:SetKeyList",InKeyList)
    self.KeyList = InKeyList
    self:UpDateDataSource()
end
-- 刷新按钮
function BP_Widget_TuYangCard:Button_Refresh_OnClicked()
    UGCLog.Log("Button_Refresh_OnClicked")
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local PlayerState = PlayerController.PlayerState
    PlayerController:ServerRPC_Buy(1)
    -- if PlayerState:GetRealRefreshPoint() > 0 then
    --     PlayerController:ServerRPC_UseCommercialCommodityRule(1006,1)
    -- else   
    --     PlayerController:ShowBuyRefreshPointUIFirstOrder()
    -- end
    
end

function BP_Widget_TuYangCard:RandomBuffCard()
    self.RandList = self:GetRandBuffList(3)
    self:UpDateDataSource()
end



function BP_Widget_TuYangCard:Close()
    self:RemoveFromViewport()
end

function BP_Widget_TuYangCard:On_PlayerState_Gold_Changed(PlayerState)
    self.GoldTextBlock:SetText(tostring(PlayerState.Gold))
end

function BP_Widget_TuYangCard:CheckBuyItem(iReason)
    if iReason == 1 then
        self:PlayAnimation(self.NewAnimation_2,0,1,EUMGSequencePlayMode.Forward,1)
    end
    
end
return BP_Widget_TuYangCard