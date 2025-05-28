local Action_GameFight = Action_GameFight or {}

Action_GameFight.bGameEndCoundDown = true

Action_GameFight.SpawnEnemy1 = nil
Action_GameFight.SpawnEnemy2 = nil
function Action_GameFight:GetBP_SummonSpawnTransformClassPath()
	return string.format([[Blueprint'%sAsset/BP_SummonSpawnTransform.BP_SummonSpawnTransform_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

function Action_GameFight:GetBP_SummonClassPath()
	-- return string.format([[Blueprint'%sAsset/BP_Summon.BP_Summon_C']], UGCMapInfoLib.GetRootLongPackagePath())--修改生成敌人的种类就是修改这边的路径
	return string.format([[Blueprint'%sAsset/Blueprint/BP_Enemy.BP_Enemy_C')]], UGCMapInfoLib.GetRootLongPackagePath())
	-- return string.format([[Blueprint'%sAsset/BP_SummonBoss.BP_SummonBoss_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

function Action_GameFight:GetBP_SummonBossClassPath()
	return string.format([[Blueprint'%sAsset/BP_SummonBoss.BP_SummonBoss_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

function Action_GameFight:GetBPWidget_GameFightClassPath()
	return string.format([[UGCWidgetBlueprint'%sAsset/BPWidget_GameFight.BPWidget_GameFight_C']], UGCMapInfoLib.GetRootLongPackagePath())
end



function Action_GameFight:GetTestPercentClassPath()
	return string.format([[UGCWidgetBlueprint'%sAsset/TestPercent.TestPercent_C']], UGCMapInfoLib.GetRootLongPackagePath())
end

function Action_GameFight:Execute(...)
	ugcprint("被启用")
	sandbox.LogNormalDev(StringFormat_Dev("[Action_GameFight:Execute] self=%s", GetObjectFullName_Dev(self)))

	local GameState = GameplayStatics.GetGameState(self)

	sandbox.LogNormalDev(StringFormat_Dev("[Action_GameFight:Execute] GameState=%s", GetObjectFullName_Dev(GameState)))

	print("Action_GameFight:Execute")



	

	if GameState:HasAuthority() then
		GameState.GameStatus = "GameFight"
		self.bEnableActionTick = true
		GameState.GameStatusChangedDelegate(GameState)


		-- TuYnag
		GameState.CurrentRoundChangedDelegate:Add(function () self:On_GameState_CurrentRoundChangedDelegate(GameState) end)
		GameState.MonsterNumberChangedDelegate:Add(self.On_GameState_MonsterNumberChangeDelegate,self)
		self:RoundStart()
		
		return false
	else
		local PlayerController = GameplayStatics.GetPlayerController(self, 0)
		sandbox.LogNormalDev(StringFormat_Dev("[Action_GameFight:Execute] PlayerController=%s", GetObjectFullName_Dev(PlayerController)))

		-- if UE.IsValid(PlayerController) and PlayerController:IsLocalController() then
		-- 	local BPWidget_GameFightClass = UE.LoadClass(self:GetBPWidget_GameFightClassPath())
		-- 	sandbox.LogNormalDev(StringFormat_Dev("[Action_GameFight:Execute] BPWidget_GameFightClass=%s", GetObjectFullName_Dev(BPWidget_GameFightClass)))
		-- 	if UE.IsValid(BPWidget_GameFightClass) then
		-- 		self.BPWidget_GameFight = UserWidget.NewWidgetObjectBP(PlayerController, BPWidget_GameFightClass)
		-- 		sandbox.LogNormalDev(StringFormat_Dev("[Action_GameFight:Execute] BPWidget_GameFight=%s", GetObjectFullName_Dev(BPWidget_GameFight)))

		-- 		if UE.IsValid(self.BPWidget_GameFight) then
		-- 			if self.BPWidget_GameFight:AddToViewport(0) then
		-- 				return true
		-- 			end
		-- 		end
		-- 	end
		-- end
		
		if UE.IsValid(PlayerController) and PlayerController:IsLocalController() then
			
		end
		
		return false
	end

	
end
Action_GameFight.fEndStage = 0
Action_GameFight.bRoundStart = false
function Action_GameFight:Update(DeltaSeconds)
	local GameState = GameplayStatics.GetGameState(self)
	self.bEnableActionTick = GameState.GameStatus == "GameFight"
	if self.bEnableActionTick then
		
	end
	if self.bRoundStart then
		GameState.ReadyToFightSeconds = math.max(GameState.ReadyToFightSeconds - DeltaSeconds, 0)
		GameState.ReadyToFightSecondsChangedDelegate(GameState)
		-- BUG 数据初始化有时候会在monster的endplay前
		GameState:InitializeTuYangData()
		if GameState.ReadyToFightSeconds <= 0 then
			self.bRoundStart = false
			self:RoundStart()
		end
	end
end

function Action_GameFight:On_GameState_CurrentRoundChangedDelegate(GameState)	
	
end

--  tuyang
-- 检查回合结束条件数
function Action_GameFight:CheckGameOver()
	ugcprint("Action_GameFightCheckGameOver")
	local GameState = GameplayStatics.GetGameState(self)
	local AllController = UGCGameSystem.GetAllPlayerController()
	ugcprint("Action_GameFightCheckGameOver Round0 "..GameState.iWinRoundCount.."  Max "..GameState.MaxRound)
	if GameState.iWinRoundCount < GameState.MaxRound then
		-- 回到准备阶段倒计时
		if GameState:HasAuthority() then
			GameState.ReadyToFightSeconds = GameState.RoundReadyToFightSeconds
			self.bRoundStart = true
			--GameState.GameStatus = "GameReady"
			for _,Controller in pairs(AllController) do
				--回合结束
				Controller:ClientRPC_RoundCountdownStart()
				
			end
			GameState:InitializeTuYangData()
			GameState:InitializeTacticalShop()
		end
		
	else
		-- 游戏结束
		LuaQuickFireEvent("EnterGameWinEvent", self)
	end
end


function Action_GameFight:RoundStart()
	-- 回合开始
	local SpawnEnemyPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/BP_TuYangSpawnEnemy.BP_TuYangSpawnEnemy_C')
	local TransformActorClass = UE.LoadClass(SpawnEnemyPath);
	local BP_SpawnEnemy = GameplayStatics.GetAllActorsOfClass(self, TransformActorClass, {})
	local GameMode = UGCGameSystem.GetGameMode()
	local GameState = UGCGameSystem.GetGameState()
	ugcprint(string.format("[BPGameMode_ProtectAthena:BP_SpawnEnemy = %s]",#(BP_SpawnEnemy)))
	for i, SpawnEnemy in ipairs(BP_SpawnEnemy) do  
		ugcprint(string.format("[ljh BP_SpawnEnemyID = %s]",SpawnEnemy.ID))
		--SpawnEnemy.SpawnEnemyStart(SpawnEnemy)
		if SpawnEnemy.ID == 1 then
			self.SpawnEnemy1 = SpawnEnemy
			elseif SpawnEnemy.ID == 2 then
				self.SpawnEnemy2 = SpawnEnemy
		end
	end
	self:SpawnEnemyStart()
	UGCLog.Log("ljh回合开始")
	local AllController = UGCGameSystem.GetAllPlayerController()
	for _,Controller in pairs(AllController) do
		Controller:ClientRPC_GameRoundFightStart()
	end
	GameState:RoundStart()
	GameState:InitializeTacticalShop() -- maoyu代码
end


--怪物生成或者死亡通知
function  Action_GameFight:On_GameState_MonsterNumberChangeDelegate(InID)
	ugcprint("怪物生成或者死亡通知"..InID)
	local GameState = GameplayStatics.GetGameState(self)
	if GameState:HasAuthority() then
		local AllController = UGCGameSystem.GetAllPlayerController()
		if GameState:CheckMonsterNumber(InID) then
			-- 结束倒计时开始
			if InID == 1 then
				if self.FailCountDowntimerID1 == nil then
					GameState.fID1CurrentFailCountDown = GameState.fFailCountDown
				self.FailCountDowntimerID1 = Timer.InsertTimer(1,
					function()
						ugcprint("Action_GameFight:TimerGameEndCoundDownID10  "..InID)
						self:TimerGameEndCoundDownID1()
					end,
						true)
				end
				
			elseif InID == 2 then
				if self.FailCountDowntimerID2 == nil then
					GameState.fID2CurrentFailCountDown = GameState.fFailCountDown
					self.FailCountDowntimerID2 = Timer.InsertTimer(1,
					function()
						ugcprint("Action_GameFight:TimerGameEndCoundDownID20  "..InID)
						self:TimerGameEndCoundDownID2()
					end,
						true)
				end
			end
			-- 添加倒计时UI
			ugcprint("Action_GameFight:TimerGameEndCoundDown1  "..InID)
			for _,Controller in pairs(AllController) do
				if Controller.PlayerState.TeamID == InID then
					Controller:AddEndCountDownUI()
				end
			end
			self.bGameEndCoundDown = false
		else
			-- 清空结束倒计时
			self:ClearTargetTimer(InID)
			-- 清空UI
			ugcprint("Action_GameFight:TimerGameEndCoundDown2 ID ="..InID)
			for _,Controller in pairs(AllController) do
				if Controller.PlayerState.TeamID == InID then
					Controller:RemoveEndCountUI()
				end
			end
			self.bGameEndCoundDown = true
		end
		
	end

end
-- 真空期结束
function Action_GameFight:TimerRoundVacuum()
	self:CheckGameOver()
end
--回合结束
function Action_GameFight:RoundEnd()
	local GameState = UGCGameSystem.GetGameState()
	local AllController = UGCGameSystem.GetAllPlayerController()
	-- 倒计时结束
	self:ClearTargetTimer(1)
	self:ClearTargetTimer(2)
	-- 清除场上所有怪物
	self:KillAllMonster()
	-- 停止刷怪
	if self.SpawnEnemyTimer ~= nil then
		Timer.RemoveTimer(self.SpawnEnemyTimer)
		self.SpawnEnemyTimer = nil
	end
	-- 进入回合真空期 可以用来处理同步数据
	if self.RoundVacuum ~= nil then
		Timer.RemoveTimer(self.RoundVacuum)
			self.RoundVacuum = nil
	end 
	self.RoundVacuum = Timer.InsertTimer(GameState.RoundEndVacuumTime,
		function()
			UGCLog.Log("Action_GameFight:RoundVacuum")
			self:TimerRoundVacuum()
		end,
		false)
	-- 回合结束UI
	Timer.InsertTimer(1,
		function()
			for _,Controller in pairs(AllController) do
				Controller:ClientRPC_PlayRoundEndUI()
				-- 回合复活
				Controller:RoundEndRespawn()
			end
		end,
		false)
	-- 关闭商店购买
	GameState.bIsOpenShovelAbility = false
end

function Action_GameFight:TimerGameEndCoundDownID1()
	local GameState = UGCGameSystem.GetGameState()
	if UE.IsValid(GameState) and GameState:HasAuthority() then
		UGCLog.Log("Action_GameFightTimerGameEndCoundDownID1",GameState.fID1CurrentFailCountDown)
		if GameState.fID1CurrentFailCountDown <= 0 then
			-- 回合结束结算
			
			self:RoundEnd()
			GameState.fID1CurrentFailCountDown = GameState.fFailCountDown
			GameState:SetWinRound(2)
		else
			GameState.fID1CurrentFailCountDown = GameState.fID1CurrentFailCountDown - 1
		end
	end
	
end
function Action_GameFight:TimerGameEndCoundDownID2()
	local GameState = UGCGameSystem.GetGameState()
	if UE.IsValid(GameState) and GameState:HasAuthority() then
		UGCLog.Log("Action_GameFightTimerGameEndCoundDownID2",GameState.fID2CurrentFailCountDown)
		if GameState.fID2CurrentFailCountDown <= 0 then
			-- 回合结束结算
			GameState:SetWinRound(1)
			self:RoundEnd()
			GameState.fID2CurrentFailCountDown = GameState.fFailCountDown
		else
			GameState.fID2CurrentFailCountDown = GameState.fID2CurrentFailCountDown - 1
		end
	end
end
-- 清空结束倒计时
function Action_GameFight:ClearTargetTimer(InID)
	if InID == 1 then
		if self.FailCountDowntimerID1 ~= nil then
			Timer.RemoveTimer(self.FailCountDowntimerID1)
			self.FailCountDowntimerID1 = nil
		end
	elseif InID == 2 then
		if self.FailCountDowntimerID2 ~= nil then
			Timer.RemoveTimer(self.FailCountDowntimerID2)
			self.FailCountDowntimerID2 = nil
		end
	end
	self:RemoveEndCountUI(InID)
end
-- 清除倒计时UI
function Action_GameFight:RemoveEndCountUI(InID)
	-- 清空UI
	local AllController = UGCGameSystem.GetAllPlayerController()
	ugcprint("Action_GameFight:RemoveEndCountUI ")
	for _,Controller in pairs(AllController) do
		if Controller.PlayerState.TeamID == InID then
			Controller:RemoveEndCountUI()
		end
	end
end
-- 固定时间刷怪
function  Action_GameFight:SpawnEnemyStart()
	UGCLog.Log("Action_GameFightSpawnEnemyStart")
	if self.SpawnEnemy1 ~= nil then
		--UGCLog.Log("Action_GameFightSpawnFirstEnemy1")
		self.SpawnEnemy1:SpawnFirstEnemy()
	end
	if self.SpawnEnemy2 ~= nil then
		--UGCLog.Log("Action_GameFightSpawnFirstEnemy2")
		self.SpawnEnemy2:SpawnFirstEnemy()
	end
	if self.SpawnEnemyTimer == nil then
		self.SpawnEnemyTimer = Timer.InsertTimer(1,
		function()
			--UGCLog.Log("TimerAction_GameFightSpawnEnemyStart")
			self:TimerSpawnEnemy()
			
		end,
		true)
	end
	
	
end

function Action_GameFight:TimerSpawnEnemy()
	local AllController = UGCGameSystem.GetAllPlayerController()
	local GameState = UGCGameSystem.GetGameState()
	if self.SpawnEnemy1 ~= nil then
		--UGCLog.Log("TimerAction_GameFightSpawnEnemyStart1")
		if GameState.iID2KillNum == 0 and GameState.iID1MonsterNum == 0 then
			for _,Controller in pairs(AllController) do
				if Controller.PlayerState.TeamID == 1 then
					Controller:ZeroMonsterAddGold()
				end
				Controller:ClientRPC_NoMonsterAddGoldUI(1)
			end
			--
			self.SpawnEnemy2:SpawnNewEnemy(1)
		end
		self.SpawnEnemy1:TimerSpawnEnemy()
	end
	if self.SpawnEnemy2 ~= nil then
		--UGCLog.Log("TimerAction_GameFightSpawnEnemyStart2")
		if GameState.iID1KillNum == 0 and GameState.iID2MonsterNum == 0 then
			for _,Controller in pairs(AllController) do
				if Controller.PlayerState.TeamID == 2 then
					Controller:ZeroMonsterAddGold()
				end
				Controller:ClientRPC_NoMonsterAddGoldUI(2)
			end
			self.SpawnEnemy1:SpawnNewEnemy(1)
		end
		self.SpawnEnemy2:TimerSpawnEnemy()
	end
	self:FinalityMechanism()
end
	
-- 新需求 终局机制 每回合五分钟应该结束了  加快进度 双方刷怪
function Action_GameFight:FinalityMechanism()
	--UGCLog.Log("Action_GameFightFinalityMechanism")
	local GameState = UGCGameSystem.GetGameState()
	--UGCLog.Log("Action_GameFightFinalityMechanism1",GameState.bIsInRound,GameState.fRoundTime)
	if GameState.bIsInRound then
        GameState.fRoundTime = GameState.fRoundTime + 1
		if GameState.fRoundTime >= GameState.FinalityMechanismTime then
			-- 触发终局机制 刷怪
			self.SpawnEnemy1:SpawnNewEnemy(2)
			self.SpawnEnemy2:SpawnNewEnemy(2)
		end
    else 
        GameState.fRoundTime = 0
    end
end
	
--添加特殊怪物
function  Action_GameFight:AddSpecialMoster(InTeamID,InMonsterKey)
	ugcprint("Action_GameFight:AddSpecialMoster")

	local SpawnEnemyPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/BP_TuYangSpawnEnemy.BP_TuYangSpawnEnemy_C')
	local TransformActorClass = UE.LoadClass(SpawnEnemyPath);
	local GameState = UGCGameSystem.GetGameState()
	local BP_SpawnEnemy = GameplayStatics.GetAllActorsOfClass(GameState, TransformActorClass, {})
	ugcprint(string.format("[Action_GameFightCheckGameOver = %s]",#(BP_SpawnEnemy)))
	for i, SpawnEnemy in ipairs(BP_SpawnEnemy) do 
		if SpawnEnemy.ID ~= InTeamID then
			SpawnEnemy:SpawnSpecialMonster(InMonsterKey)			
		end
	end
	--UGCLog.Log("Action_GameFightAddSpecialMoster", self.iID1SpawnEnemy)
	--UGCLog.Log("Action_GameFightAddSpecialMoster", self.iID2SpawnEnemy)
	--全队播报
    local AllController = UGCGameSystem.GetAllPlayerController()
    for _,Controller in pairs(AllController) do
        Controller:ClientRPC_PlayTeamAnnouncerUI(2,InTeamID)
    end
end

function Action_GameFight:KillAllMonster()
	if self.SpawnEnemy1 ~= nil then
		UGCLog.Log("Action_GameFightKillAllMonster1")
		self.SpawnEnemy1:RountEndClearAllMonster()
	end
	if self.SpawnEnemy2 ~= nil then
		UGCLog.Log("Action_GameFightKillAllMonster2")
		self.SpawnEnemy2:RountEndClearAllMonster()
	end
end

return Action_GameFight
