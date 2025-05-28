---@class BPWidget_RoundGameReady_C:UUserWidget
---@field ReadyToFightSecondsTextBlock UTextBlock
--Edit Below--
local BPWidget_RoundGameReady = {}

function BPWidget_RoundGameReady:Construct()    
    UGCLog.Log("BPWidget_RoundGameReadyConstruct")
    --BPWidget_RoundGameReady.SuperClass.Construct(self)

    self.ReadyToFightSecondsTextBlock = self:GetWidgetFromName("ReadyToFightSecondsTextBlock")
    
    local GameState = GameplayStatics.GetGameState(self)
    GameState.ReadyToFightSecondsChangedDelegate:Add(self.On_GameState_ReadyToFightSecondsChanegd, self)
    self:On_GameState_ReadyToFightSecondsChanegd(GameState)

   
end

function BPWidget_RoundGameReady:On_GameState_ReadyToFightSecondsChanegd(GameState)
    local ReadyToFightSeconds = math.modf(GameState.ReadyToFightSeconds)
	self.ReadyToFightSecondsTextBlock:SetText(tostring(ReadyToFightSeconds))
    if GameState.ReadyToFightSeconds <= 0 then
        self:RemoveFromViewport()
    end  
end

function BPWidget_RoundGameReady:Close()
    self:RemoveFromViewport()
end
return BPWidget_RoundGameReady