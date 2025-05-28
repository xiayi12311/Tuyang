require("common.ue_object")
UGCGameSystem.UGCRequire("ExtendResource.RankingList.OfficialPackage.Script.RankingList.RankingListManager")

local Action_GameWin = {}

--Action_GameWin.BPWidget_PlayerResultClassPath = string.format([[UGCWidgetBlueprint'%sAsset/BPWidget_PlayerResult.BPWidget_PlayerResult_C']], UGCMapInfoLib.GetRootLongPackagePath())

function Action_GameWin:Execute(...)
	ugcprint("Execute Game Win")
	UGCLog.Log("Action_GameWin:Execute")

	local GameState = GameplayStatics.GetGameState(self)	
	GameState.GameStatus = "GameWin"
	GameState.GameStatusChangedDelegate(GameState)
	
	local AllController = UGCGameSystem.GetAllPlayerController()
	for _,Controller in pairs(AllController) do
		-- 执行结束逻辑
		Controller:ClientRPC_GameOverResult()
		-- 更新排行榜数据
			-- 单局杀敌数
		local RankID = 1;
		local Score = Controller.PlayerState.EnemyCount;
		local UID = Controller:GetInt64UID();
		UGCLog.Log("UpdatePlayerRankingScore RankID = " .. RankID .. " Score = " .. Score .. " UID = " .. UID);
		RankingListManager:UpdatePlayerRankingScore(Controller, UID, RankID, Score);
		-- 胜场榜
		local RankID = 2;
		local Score = Controller.PlayerState.GameSavePlayerData["WinCount"];
		local UID = Controller:GetInt64UID();
		UGCLog.Log("UpdatePlayerRankingScore RankID = " .. RankID .. " Score = " .. Score .. " UID = " .. UID);
		RankingListManager:UpdatePlayerRankingScore(Controller, UID, RankID, Score);
	end
	-- 发送结算数据
	if UGCGameSystem.IsServer() then
		local PlayerStates = UGCGameSystem.GetAllPlayerState(false)
		for i, PlayerState in ipairs(PlayerStates) do
			if PlayerState then
				UGCGameSystem.SendPlayerSettlement(PlayerState.PlayerKey);
			end
		end
	end

	return true
end

-- function Action_GameWin:Update(deltaTime)

-- end

return Action_GameWin
