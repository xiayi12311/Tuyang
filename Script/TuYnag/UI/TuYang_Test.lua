---@class TuYang_Test_C:UUserWidget
---@field NewAnimation_2 UWidgetAnimation
---@field NewAnimation_1 UWidgetAnimation
---@field Background UImage
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
---@field TuYang_BPWidgetWeaponItem TuYang_BPWidgetWeaponItem_C
---@field TuYang_BPWidgetWeaponItem_0 TuYang_BPWidgetWeaponItem_C
---@field TuYang_BPWidgetWeaponItem_1 TuYang_BPWidgetWeaponItem_C
---@field VerticalBox_1 UVerticalBox
---@field VerticalBox_2 UVerticalBox
---@field VerticalBox_3 UVerticalBox
--Edit Below--
local TuYang_BPWidgetWeaponChoose = TuYang_BPWidgetWeaponChoose or {} 

TuYang_BPWidgetWeaponChoose.DataSource = {}
TuYang_BPWidgetWeaponChoose.CardPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/UI/TuYang_BPWidgetWeaponItem.TuYang_BPWidgetWeaponItem_C')
TuYang_BPWidgetWeaponChoose.CardClass = nil

TuYang_BPWidgetWeaponChoose.AllRandList = {}
TuYang_BPWidgetWeaponChoose.RandList = {}
TuYang_BPWidgetWeaponChoose.RefreshCost = 250
function TuYang_BPWidgetWeaponChoose:Construct()
    UGCLog.Log("TuYang_BPWidgetWeaponChooseConstruct")
	self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.Forward,1)
    self.Button_0.OnClicked:Add(self.Button_0_OnClicked, self);
    self.Button_Refresh.OnClicked:Add(self.Button_Refresh_OnClicked,self)
    --local GameState = GameplayStatics.GetGameState(self)
    if self.CardClass == nil then
        self.CardClass = UE.LoadClass(self.CardPath)
    end    
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local PlayerState = PlayerController.PlayerState
    if UE.IsValid(PlayerController) and UE.IsValid(PlayerState) then
       PlayerState.GoldChangedDelegate:Add(self.On_PlayerState_Gold_Changed, self) 
       self:On_PlayerState_Gold_Changed(PlayerState)     
    end
    
end


function TuYang_BPWidgetWeaponChoose:Tick(MyGeometry, InDeltaTime)
    -- local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    -- local PlayerState = PlayerController.PlayerState
    -- self.TextBlock_RandamNum:SetText(tostring(self.RefreshCost))
end

-- function TuYang_BPWidgetWeaponChoose:Destruct()

-- end
TuYang_BPWidgetWeaponChoose.KeyList = {}
function TuYang_BPWidgetWeaponChoose:SetKeyList(InKeyList)
    --UGCLog.Log("TuYang_BPWidgetWeaponChoose:SetKeyList",InKeyList)
    self.KeyList = InKeyList
    self:UpDateDataSource()
end

function TuYang_BPWidgetWeaponChoose:UpDateDataSource()
    --UGCLog.Log("TuYang_BPWidgetWeaponChoose:UpDateDataSource",self.KeyList)
    -- 清空所有的子控件
    if self.HorizontalBox_Card then 
        self.HorizontalBox_Card:ClearChildren() 
    end
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local PlayerState = PlayerController.PlayerState
    for k, v in pairs(self.KeyList) do
        local BPWidget_CardItem = LuaExtendLibrary.NewLuaObject(self, self.CardClass)
        BPWidget_CardItem.Key = v
        self.HorizontalBox_Card:AddChild(BPWidget_CardItem)
        BPWidget_CardItem:InitlizeWidget(self)
        PlayerController.BP_PayLockComponent:PrintBinary()
        BPWidget_CardItem:PayLock(PlayerController.BP_PayLockComponent:CheckUnlocked(v))
    end
    --UGCLog.Log("[LJH]TuYang_BPWidgetWeaponChooseUpDateDataSource",PlayerState.bIsFirstChoose)
    --只在游戏开始时关闭X按钮（强制玩家选择初始武器）
    if PlayerState.bIsFirstChoose then
        self.CanvasPanel_Close:SetVisibility(ESlateVisibility.Hidden)
    else
        self.CanvasPanel_Close:SetVisibility(ESlateVisibility.Visible)
    end
end

function TuYang_BPWidgetWeaponChoose:Button_0_OnClicked()
    -- 
    self:Close()
   
end
-- 刷新按钮
function TuYang_BPWidgetWeaponChoose:Button_Refresh_OnClicked()
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local PlayerState = PlayerController.PlayerState
    
    -- if PlayerState:GetRealRefreshPoint() > 0 then
    --     PlayerController:ServerRPC_UseCommercialCommodityRule(1006,1)
    -- else   
    --     PlayerController:ShowBuyRefreshPointUIFirstOrder()
    -- end
    PlayerController:ServerRPC_Buy(2)
end

function TuYang_BPWidgetWeaponChoose:On_PlayerState_Gold_Changed(PlayerState)
    self.GoldTextBlock:SetText(tostring(PlayerState.Gold))
end

function TuYang_BPWidgetWeaponChoose:CheckBuyItem(iReason)
    if iReason == 1 then
        self:PlayAnimation(self.NewAnimation_2,0,1,EUMGSequencePlayMode.Forward,1)
    end
end


function TuYang_BPWidgetWeaponChoose:Close()
    self:RemoveFromViewport()
end
return TuYang_BPWidgetWeaponChoose