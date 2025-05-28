local Action_GameStart = {}



function Action_GameStart:Execute(...)
	
	-- TuYnag
	local GameState = GameplayStatics.GetGameState(self)
	GameState.GameStatus = "GameStart"
	GameState.GameStatusChangedDelegate(GameState)
	ugcprint("使用")
	LuaQuickFireEvent("EnterGameReadyEvent", self)
	
	return false
end

function Action_GameStart:Update(deltaTime)

end

return Action_GameStart
