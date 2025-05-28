---@class BPWidget_RoundEnd_C:UUserWidget
---@field NewAnimation_1 UWidgetAnimation
---@field Background UImage
---@field Image_4 UImage
---@field Image_WinTeam UImage
---@field LeftDown UImage
---@field LeftUp UImage
---@field RightDown UImage
---@field RightUp UImage
---@field Text_TeamID UTextBlock
---@field TextBlock_5 UTextBlock
---@field TextBlock_SecceedTeam UTextBlock
--Edit Below--
local BPWidget_RoundEnd = { bInitDoOnce = false } 
BPWidget_RoundEnd.WidgetLifeSpan = 3
local TimeSet = 0
local Icon_ID1 = '/Game/Arts/UI/TableIcons/ProfessionResult_Icon/ZY_img_tujibing.ZY_img_tujibing'
local Icon_ID2 = '/Game/Arts/UI/TableIcons/ProfessionResult_Icon/ZY_img_houqinbing.ZY_img_houqinbing'
function BPWidget_RoundEnd:Construct()
    UGCLog.Log("BPWidget_RoundEndConstruct")
	self:PlayAnimation(self.NewAnimation_1,0,1,EUMGSequencePlayMode.Forward,1)
    self:SetWinTeam()
    TimeSet = 0
end


function BPWidget_RoundEnd:Tick(MyGeometry, InDeltaTime)
    TimeSet = TimeSet + InDeltaTime
    if TimeSet >= self.WidgetLifeSpan then
        self:Close()
    end
end

-- function BPWidget_RoundEnd:Destruct()

-- end
function BPWidget_RoundEnd:Close()
    self:RemoveFromViewport()
end

function BPWidget_RoundEnd:SetWinTeam()
    local GameState  = UGCGameSystem.GetGameState()
    local PlayerController = GameplayStatics.GetPlayerController(self, 0)
    local PlayerState = PlayerController.PlayerState
    UGCLog.Log("BPWidget_RoundEndSetWinTeam",PlayerState.iRoundWinTeamID)
    if PlayerState.iRoundWinTeamID == 1 then
        self.TextBlock_SecceedTeam:SetText("红方")
        self.Image_WinTeam:SetBrushFromTexture(UE.LoadObject(Icon_ID1),true)
    elseif PlayerState.iRoundWinTeamID == 2 then
        self.TextBlock_SecceedTeam:SetText("紫方")
        self.Image_WinTeam:SetBrushFromTexture(UE.LoadObject(Icon_ID2),true)
    end
end
return BPWidget_RoundEnd