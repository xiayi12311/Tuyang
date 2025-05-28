---@class BPWidget_TeleportUI_C:UUserWidget
---@field NewAnimation_2 UWidgetAnimation
---@field NewAnimation_1 UWidgetAnimation
---@field Background UImage
---@field Button_TP UButton
---@field LeftDown UImage
---@field LeftUp UImage
---@field RightDown UImage
---@field RightUp UImage
---@field TextBlock_4 UTextBlock
---@field TextBlock_Cost UTextBlock
--Edit Below--
local BPWidget_TeleportUI = { bInitDoOnce = false } 
BPWidget_TeleportUI.WidgetLifeSpan = 3
BPWidget_TeleportUI.ID = 1
local TimeSet = 5
function BPWidget_TeleportUI:Construct()
	self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.Forward,1)
    self.TextBlock_Cost = self:GetWidgetFromName("TextBlock_Cost")
    self.Button_TP.OnReleased:Add(self.Button_TP_OnReleased, self);
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    if PlayerController then
        PlayerController.TeleportUI = self
        PlayerController.GoldCommodityList[3].Widget = PlayerController.TeleportUI
    end
end

function BPWidget_TeleportUI:InitializeWidget()
    TimeSet = 5
end

function BPWidget_TeleportUI:Tick(MyGeometry, InDeltaTime)
   if TimeSet <= 0 then
        self:Close()
   else
        local PlayerController = GameplayStatics.GetPlayerController(self, 0)
        local PlayerState = PlayerController.PlayerState
        local tNeedCost = PlayerState.TeleportCost * PlayerState.TeleportCostScale
        self.TextBlock_Cost:SetText(tostring(math.ceil(tNeedCost)))
        TimeSet = TimeSet - InDeltaTime
   end
end

-- function BPWidget_TeleportUI:Destruct()

-- end


function BPWidget_TeleportUI:Button_TP_OnReleased()
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    PlayerController:ServerRPC_PlayerTeleportStart(self.ID)
    --self:Close()
end

function BPWidget_TeleportUI:Close()
    self:RemoveFromViewport()
end
function BPWidget_TeleportUI:CheckBuyItem(iReason)
    if iReason == 1 then
        self:PlayAnimation(self.NewAnimation_2,0,1,EUMGSequencePlayMode.Forward,1)
    end
end
return BPWidget_TeleportUI