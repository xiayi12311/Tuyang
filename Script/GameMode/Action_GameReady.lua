local Action_GameReady = {}

function Action_GameReady:Execute(...)
	sandbox.LogNormalDev(StringFormat_Dev("[Action_GameReady:Execute] self=%s", GetObjectFullName_Dev(self)))

	local GameState = GameplayStatics.GetGameState(self)
	sandbox.LogNormalDev(StringFormat_Dev("[Action_GameReady:Execute] GameState=%s GameState.GameStatus=%s", GetObjectFullName_Dev(GameState), ToString_Dev(GameState.GameStatus)))
	
	GameState.GameStatus = "WaitForPlayer"
	GameState.GameStatusChangedDelegate(GameState)
	--LuaQuickFireEvent("EnterGameFightEvent", self)
	return true
end

function Action_GameReady:Update(deltaTime)
	local GameState = GameplayStatics.GetGameState(self)

	if UE_BUILD_DEVELOPMENT then
		sandbox.LogNormalDev(StringFormat_Dev("[Action_GameReady:Update] self=%s", GetObjectFullName_Dev(self)))
		sandbox.LogNormalDev(
			StringFormat_Dev(
				"[Action_GameReady:Update] GameStatus=%s ReadyToFightSeconds=%s deltaTime=%s", 
				ToString_Dev(GameState.GameStatus), 
				ToString_Dev(GameState.ReadyToFightSeconds), 
				ToString_Dev(deltaTime)
			)
		)
	end

	self.bEnableActionTick = GameState.GameStatus == "WaitForPlayer" or GameState.GameStatus == "GameReady"
	if self.bEnableActionTick and GameState.GameStatus == "GameReady" then
		GameState.ReadyToFightSeconds = math.max(GameState.ReadyToFightSeconds - deltaTime, 0)
		GameState.ReadyToFightSecondsChangedDelegate(GameState)
		if GameState.ReadyToFightSeconds <= 0 then
			sandbox.LogNormalDev("[Action_GameReady:Update] EnterGameFightEvent")
			LuaQuickFireEvent("EnterGameFightEvent", self)
			
		end
	end
end

return Action_GameReady
