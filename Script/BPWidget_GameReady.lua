---@class BPWidget_GameReady_C:UUserWidget
---@field ReadyToFightSecondsTextBlock UTextBlock
--Edit Below--
local BPWidget_GameReady = BPWidget_GameReady or {}

function BPWidget_GameReady:Construct()
    --UGCLog.Log("BPWidget_GameReady:Construct")
    BPWidget_GameReady.SuperClass.Construct(self)

    self.ReadyToFightSecondsTextBlock = self:GetWidgetFromName("ReadyToFightSecondsTextBlock")
    
    local GameState = GameplayStatics.GetGameState(self)
    GameState.ReadyToFightSecondsChangedDelegate:Add(self.On_GameState_ReadyToFightSecondsChanegd, self)
    self:On_GameState_ReadyToFightSecondsChanegd(GameState)

    
    GameState.GameStatusChangedDelegate:Add(
        function (GameState)
            -- if GameState.GameStatus ~= "GameReady" then
            --     self:RemoveFromViewport()
            -- end
           
          
        end
    )
end


function BPWidget_GameReady:ReceiveTick(DeltaTime)
    local GameState = GameplayStatics.GetGameState(self)
    if GameState.ReadyToFightSeconds <= 0 then
        self:RemoveFromViewport()
    end
    
end

function BPWidget_GameReady:On_GameState_ReadyToFightSecondsChanegd(GameState)
    local ReadyToFightSeconds = math.modf(GameState.ReadyToFightSeconds)
	self.ReadyToFightSecondsTextBlock:SetText(tostring(ReadyToFightSeconds))
end

return BPWidget_GameReady