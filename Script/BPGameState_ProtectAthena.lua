---@class BPGameState_ProtectAthena_C:BP_UGCGameState_C
---@field BP_EnemyShopComponent BP_EnemyShopComponent_C
---@field BP_ShopComponent BP_ShopComponent_C
--Edit Below--
require("common.ue_object")
UGCLog = require("Script.UGCLog")
UGCGameSystem.UGCRequire('Script.Common.ue_enum_custom')
local Delegate = require("common.Delegate")
local DependencyProperty = require("common.DependencyProperty")
local Action_GameFight = require("Script.GameMode.Action_GameFight")
local TuYang_PlayerBuffConfig = require("Script.Config.TuYang_PlayerBuffConfig")
--local BPGameState_ProtectAthena = BPGameState_ProtectAthena or {}
local BPGameState_ProtectAthena =
 {
    IsVoteEnd = false;
    IsVoteStart =false;
    VoteTimeCount = 40;
    TimeCount = 900;--900
    MainTaskStage = 0;
    IfGameEnd = false,
    -- 断线重连相关数据
    PlayerData = {
       
    },
    RegionCount =7, -- n-1
    Region ={
        56000,
        49669,
        24594,
        11827,
        -20670,
        -36532,
        -48837,
        -100000,
    },
    VoteCount ={
        0,
        0,
        0,
        0
    },
    Difficulty = 1,
    PlayerControllerList ={}
    
 }

BPGameState_ProtectAthena.GameStatus = ""

BPGameState_ProtectAthena.GameStatusChangedDelegate = Delegate.New()



BPGameState_ProtectAthena.ReadyToFightSecondsChangedDelegate = Delegate.New()



BPGameState_ProtectAthena.CurrentSummonCount = 0

BPGameState_ProtectAthena.CurrentSummonCountChangedDelegate = Delegate.New()

BPGameState_ProtectAthena.SummonCountPerRound = 1

BPGameState_ProtectAthena.CurrentRoundElapsedSeconds = 0

BPGameState_ProtectAthena.CurrentRoundElapsedSecondsChangedDelegate = Delegate.New()

BPGameState_ProtectAthena.MonsterLevelChangedDelegate = Delegate.New()

BPGameState_ProtectAthena.MaxRoundElapsedSeconds = 30

BPGameState_ProtectAthena.RespawnPlayer ={}

local EventSystem =  require('Script.common.UGCEventSystem')
BPGameState_ProtectAthena.TaskStage_Insect = 0
BPGameState_ProtectAthena.TaskStage_XiaoQi = 0
BPGameState_ProtectAthena.InsectCount = 0;
BPGameState_ProtectAthena.TimeSet = 0;
BPGameState_ProtectAthena.InsectNum = 0
BPGameState_ProtectAthena.Insect = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Insect/Insect1.Insect1_C'))


--TuYang
-- 1队杀敌数
BPGameState_ProtectAthena.iID1KillNum = 0
-- 2队杀敌数
BPGameState_ProtectAthena.iID2KillNum = 0
-- ID == 1的队伍的怪物等级
BPGameState_ProtectAthena.iID1MonsterLevel = 1
BPGameState_ProtectAthena.iID1MonsterLevelMax = 20
-- ID == 2的队伍的怪物等级
BPGameState_ProtectAthena.iID2MonsterLevel = 1
BPGameState_ProtectAthena.iID2MonsterLevelMax = 20

-- 1队方怪物数
BPGameState_ProtectAthena.iID1MonsterNum = 0
-- 2队方怪物数
BPGameState_ProtectAthena.iID2MonsterNum = 0
-- 1队方怪物数上限
BPGameState_ProtectAthena.MaxID1MonsterNum = 50
-- 2队方怪物数上限
BPGameState_ProtectAthena.MaxID2MonsterNum = 50

--阶段二怪物数
BPGameState_ProtectAthena.MonsterNumStage2 = 25
--阶段三怪物数
BPGameState_ProtectAthena.MonsterNumStage3 = 50
BPGameState_ProtectAthena.MonsterNumberChangedDelegate = Delegate.New()

--击杀怪物掉落技能碎片概率
BPGameState_ProtectAthena.DropSkillElementRate = 775 -- 万分位精度判断 775/10000 = 7.75%

-- 队伍1阶段数
BPGameState_ProtectAthena.CurrentMonsterNumStage_ID1 = 1
-- 队伍2阶段数
BPGameState_ProtectAthena.CurrentMonsterNumStage_ID2 = 1
-- 失败倒计时
BPGameState_ProtectAthena.fFailCountDown = 10
-- 1队方失败倒计时时间
BPGameState_ProtectAthena.fID1CurrentFailCountDown = 10
-- 2队方失败倒计时时间
BPGameState_ProtectAthena.fID2CurrentFailCountDown = 10
--1队胜利回合数
BPGameState_ProtectAthena.iWinRound_ID1 = 0
--2队胜利回合数
BPGameState_ProtectAthena.iWinRound_ID2 = 0
--胜利的队伍是
BPGameState_ProtectAthena.iWinTeamID = 0 -- 0 未结束 1 1队 2 2队
-- 胜利回合数
BPGameState_ProtectAthena.iWinRoundCount = 0
--播放第二阶段BGM DoOnce
BPGameState_ProtectAthena.PlayStageTwoBGMOnce = true

--1队战术增益技能是否正在被使用Map
BPGameState_ProtectAthena.Team1TacticalBuffIsUsingMap = {}
BPGameState_ProtectAthena.Team1TacticalBuffIsUsingMap["skill_2"] = false
--2队战术增益技能是否正在被使用Map
BPGameState_ProtectAthena.Team2TacticalBuffIsUsingMap = {}
BPGameState_ProtectAthena.Team2TacticalBuffIsUsingMap["skill_2"] = false
--战术增益技能Projectile的Target
BPGameState_ProtectAthena.TacticalSkillProjectileTarget = nil
-- 车载武器初始化子弹数量
BPGameState_ProtectAthena.VehicleWeaponBulletNum = 1000
-- 当前回合数
BPGameState_ProtectAthena.CurrentRound = 1

--修改敌人数量和round的时间
BPGameState_ProtectAthena.MaxRound = 2
BPGameState_ProtectAthena.ReadyToFightSeconds = 60
-- 新回合开始后等待时间
BPGameState_ProtectAthena.RoundReadyToFightSeconds = 45

BPGameState_ProtectAthena.CurrentRoundChangedDelegate = Delegate.New()
--终局机制触发时间
BPGameState_ProtectAthena.FinalityMechanismTime = 270
-- 回合时间
BPGameState_ProtectAthena.bIsInRound = false
BPGameState_ProtectAthena.fRoundTime = 0
-- 回合胜利方
BPGameState_ProtectAthena.iRoundWinTeamID = 0
--回合结束 N s 真空期
BPGameState_ProtectAthena.RoundEndVacuumTime = 5
--BPGameState_ProtectAthena.RoundWinTeamIDDelegate = Delegate.New()
-- 限制商店购买  在真空期和准备期间不应该可以购买
BPGameState_ProtectAthena.bIsOpenShovelAbility = false
-- 传送门Actor
BPGameState_ProtectAthena.TepeportActorList = {}
-- 回合开始玩家传送点
BPGameState_ProtectAthena.RoundStartTepeportActorLocation = {}
-- 技能商店
BPGameState_ProtectAthena.BuffSkillShopLandList = {}
-- 武器商店
BPGameState_ProtectAthena.WeaponShopLandList = {}

function BPGameState_ProtectAthena:GetReplicatedProperties()
    return 
       
        "MainTaskStage",
        "PlayerData",
        "GameStatus", 
        "ReadyToFightSeconds", 
        "CurrentRound", 
        "iWinRoundCount",
        "CurrentSummonCount", 
        "CurrentRoundElapsedSeconds",
        "VoteTimeCount",
        "TaskStage_Insect",
        "TaskStage_XiaoQi",
        "InsectCount",
        "IsVoteEnd",
        "iID1MonsterNum",
        "iID2MonsterNum",
        "iID1MonsterLevel",
        "iID2MonsterLevel",
        "fID1CurrentFailCountDown",
        "fID2CurrentFailCountDown",
        "CurrentMonsterNumStage_ID1",
        "CurrentMonsterNumStage_ID2",
        "iWinRound_ID1",
        "iWinRound_ID2",
        "iWinTeamID",
        "TepeportActorList",
        "iRoundWinTeamID"
end


function BPGameState_ProtectAthena:OnRep_GameStatus()
    sandbox.LogNormalDev(StringFormat_Dev("[BPGameState_ProtectAthena:OnRep_GameStatus] self=%s GameStatus=%s", GetObjectFullName_Dev(self), ToString_Dev(self.GameStatus)))

    self.GameStatusChangedDelegate(self)
end

function BPGameState_ProtectAthena:OnRep_ReadyToFightSeconds()
    sandbox.LogNormalDev(StringFormat_Dev("[BPGameState_ProtectAthena:OnRep_GameStatus] self=%s ReadyToFightSeconds=%s", GetObjectFullName_Dev(self), ToString_Dev(self.ReadyToFightSeconds)))

    self.ReadyToFightSecondsChangedDelegate:Broadcast(self)
end

function BPGameState_ProtectAthena:OnRep_CurrentRound()
    sandbox.LogNormalDev(StringFormat_Dev("[BPGameState_ProtectAthena:OnRep_GameStatus] self=%s CurrentRound=%s", GetObjectFullName_Dev(self), ToString_Dev(self.CurrentRound)))
    
    self.CurrentRoundChangedDelegate(self)
end

function BPGameState_ProtectAthena:OnRep_CurrentSummonCount()
    sandbox.LogNormalDev(StringFormat_Dev("[BPGameState_ProtectAthena:OnRep_CurrentSummonCount] self=%s CurrentRound=%s", GetObjectFullName_Dev(self), ToString_Dev(self.CurrentSummonCount)))
    
    self.CurrentSummonCountChangedDelegate(self)
end

function BPGameState_ProtectAthena:OnRep_iID1MonsterLevel()
    sandbox.LogNormalDev(StringFormat_Dev("[BPGameState_ProtectAthena:OnRep_iID1MonsterLevel] self=%s CurrentRound=%s", GetObjectFullName_Dev(self), ToString_Dev(self.iID1MonsterLevel)))
    ugcprint("iID1MonsterLevel is "..self.iID1MonsterLevel)
    self.MonsterLevelChangedDelegate:Broadcast(1)
end
function BPGameState_ProtectAthena:OnRep_iID2MonsterLevel()
    sandbox.LogNormalDev(StringFormat_Dev("[BPGameState_ProtectAthena:OnRep_iID2MonsterLevel] self=%s CurrentRound=%s", GetObjectFullName_Dev(self), ToString_Dev(self.iID2MonsterLevel)))
    ugcprint("iID2MonsterLevel is "..self.iID2MonsterLevel)
    self.MonsterLevelChangedDelegate:Broadcast(2)
end

function BPGameState_ProtectAthena:OnRep_iID1MonsterNum()
    ugcprint("iID1MonsterNum is "..self.iID1MonsterNum)
end
function BPGameState_ProtectAthena:OnRep_iID2MonsterNum()
    ugcprint("iID2MonsterNum is "..self.iID2MonsterNum)
end
function BPGameState_ProtectAthena:OnRep_iWinTeamID()
    
end
function BPGameState_ProtectAthena:OnRep_iRoundWinTeamID()
    ugcprint("iRoundWinTeamID is "..self.iRoundWinTeamID)
end
function BPGameState_ProtectAthena:OnRep_CurrentRoundElapsedSeconds()
    sandbox.LogNormalDev(StringFormat_Dev("[BPGameState_ProtectAthena:OnRep_CurrentRoundElapsedSeconds] self=%s CurrentRoundElapsedSeconds=%s", GetObjectFullName_Dev(self), ToString_Dev(self.CurrentRoundElapsedSeconds)))
    self.CurrentRoundElapsedSecondsChangedDelegate(self)
end

function BPGameState_ProtectAthena:OnRep_fID1CurrentFailCountDown()
    
end
function BPGameState_ProtectAthena:OnRep_fID2CurrentFailCountDown()
    
end
function BPGameState_ProtectAthena:OnRep_CurrentMonsterNumStage_ID1()
    local AllController = UGCGameSystem.GetAllPlayerController()
    for _,Controller in pairs(AllController) do
        Controller:PlayTaskStage(1,self.CurrentMonsterNumStage_ID1)
    end
    
end
function BPGameState_ProtectAthena:OnRep_CurrentMonsterNumStage_ID2()
    local AllController = UGCGameSystem.GetAllPlayerController()
    for _,Controller in pairs(AllController) do
        Controller:PlayTaskStage(2,self.CurrentMonsterNumStage_ID2)
    end
    
end
function BPGameState_ProtectAthena:OnRep_iWinRound_ID1()
    
end
function BPGameState_ProtectAthena:OnRep_iWinRound_ID2()
    
end

function BPGameState_ProtectAthena:ReceiveBeginPlay()
    sandbox.LogNormalDev(StringFormat_Dev("[BPGameState_ProtectAthena:ReceiveBeginPlay] self=%s", GetObjectFullName_Dev(self)))
    self.bIsOpenShovelAbility = false
    BPGameState_ProtectAthena.SuperClass.ReceiveBeginPlay(self)
    --EventSystem:AddListener("FirstChapter",self.SpawnFirstChapter)
    self.bAllowBPReceiveTickEvent = true --not self:HasAuthority()
     


    
    UGCCommoditySystem.BuyUGCCommodityResultDelegate:Add(self.OnBuyUGCCommodityResult, self)
    UGCCommoditySystem.UseUGCCommodityResultDelegate:Add(self.OnUseUGCCommodityResult, self)
end

function BPGameState_ProtectAthena:GetAvailableServerRPCs()
    return 
end




function BPGameState_ProtectAthena:ReceiveTick(DeltaSeconds)
    BPGameState_ProtectAthena.SuperClass.ReceiveTick(self, DeltaSeconds)
end

function BPGameState_ProtectAthena:UpDatePlayerEnemyCount(InKey,num)
    if self.PlayerData[InKey] ~= nil then
        self.PlayerData[InKey].EnemyCount = num
    end
end

function BPGameState_ProtectAthena:UpDatePlayerGold(InKey,InGold)
    if self.PlayerData[InKey] ~= nil then
        self.PlayerData[InKey].Gold = InGold
    end
end
function BPGameState_ProtectAthena:UpDatePlayerDamage(InKey,InDamage)
    if self.PlayerData[InKey] ~= nil then
        self.PlayerData[InKey].Damage = InDamage
    end
end
function BPGameState_ProtectAthena:UpDatePlayerIsFirstChoose(InKey,InbIsFirstChoose)
    if self.PlayerData[InKey] ~= nil then
        self.PlayerData[InKey].bIsFirstChoose = InbIsFirstChoose
    end
end
function BPGameState_ProtectAthena:UpDateTotal(InKey,TotalGold)
   
end

function BPGameState_ProtectAthena:GetPlayerData()
    return self.PlayerData
end
function BPGameState_ProtectAthena:SetPlayerData(InPlayerKey,InKey,InValue)
    if self.PlayerData[InPlayerKey] ~= nil then
        self.PlayerData[InPlayerKey][InKey] = InValue
    end
end

function BPGameState_ProtectAthena:AddRespawnPlayer(PlayerController)
    table.insert(self.RespawnPlayer,PlayerController)
end
function BPGameState_ProtectAthena:GetRespawnPlayer()
    local Playercontroller = self.RespawnPlayer[1]
    return Playercontroller 
end
function BPGameState_ProtectAthena:PopRespawnPlayer()
    table.remove(self.RespawnPlayer, 1)
    return true
end
function BPGameState_ProtectAthena:EnterSpectater(InPlayerController)
    UGCLog.Log("EnterSpectater")
    local PlayerController3 = self:GetRespawnPlayer()
    UnrealNetwork.CallUnrealRPC(InPlayerController, InPlayerController, "ServerRPC_ShowRespawnUI")
    InPlayerController:RespawnEndCountDownStart()
    local function EnterSpectater()
        ugcprint("Player EnterSpectater！")
        local gamestate = UGCGameSystem.GetGameState()
        local PlayerController2 = gamestate:GetRespawnPlayer()
        gamestate:PopRespawnPlayer()
        local OBPlayerKeys = {}
        local PlayerControllerList = UGCGameSystem.GetAllPlayerController()
            for _, PlayerController in ipairs(PlayerControllerList) do
                if PlayerController and PlayerController ~= PlayerController2 then
                    ugcprint("Key is" ..PlayerController.PlayerKey)
                    table.insert(OBPlayerKeys, PlayerController.PlayerKey)
                end
            end
        UGCGameSystem.ChangeAllowOBPlayerKeys(PlayerController2, OBPlayerKeys)  
        UGCGameSystem.EnterSpectating(PlayerController2)   --进入观战
    end
    UGCGameSystem.SetTimer(self,EnterSpectater,1,false)

    return true
end


function BPGameState_ProtectAthena:GetRegionCount()
    return self.RegionCount
end
function BPGameState_ProtectAthena:GetRegion()
    return self.Region
end


function BPGameState_ProtectAthena:GetDifficulty()
    return self.Difficulty
end

function BPGameState_ProtectAthena:LuaModifyDamage(Damage,DamageType,InstigatorPlayerState,VictimPlayerState)
    ugcprint("Damage is " ..Damage)
    ugcprint("Type is " ..DamageType)
    -- local NewDamage = Damage
    -- if DamageType == 100 then
    --     NewDamage = NewDamage*2
    -- end
    -- return NewDamage
end

--TuYangFunction
function BPGameState_ProtectAthena:InitializeTuYangData()
    self.iID1KillNum = 0
    self.iID2KillNum = 0
    self.iID1MonsterLevel = 1
    self.iID2MonsterLevel = 1
    self.iID1MonsterNum = 0
    self.iID2MonsterNum = 0
    self.CurrentMonsterNumStage_ID1 = 1
    self.CurrentMonsterNumStage_ID2 = 1
    self.PlayStageTwoBGMOnce = true
    self.bIsInRound = false
    self.fRoundTime = 0
    self.bIsOpenShovelAbility = false
end

function BPGameState_ProtectAthena:InitializeTacticalShop()

    local VehicleActorClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Emeny/TacticalBuffs/TuYang_TacticalBuffsVehicle.TuYang_TacticalBuffsVehicle_C'))
    local VehicleActors = GameplayStatics.GetAllActorsOfClass(self, VehicleActorClass, {})

    self.Team1TacticalBuffIsUsingMap["skill_2"] = false
    self.Team2TacticalBuffIsUsingMap["skill_2"] = false
    self.TacticalSkillProjectileTarget = nil
        -- 遍历所有VehicleActors并初始化
    for _, VehicleActor in ipairs(VehicleActors) do
        if UE.IsValid(VehicleActor) then
            VehicleActor:SetActorHiddenInGame(true)
            local PlayerPawn = UGCVehicleSystem.GetOccupierBySeatIndex(VehicleActor, 1)
            if PlayerPawn then
                UGCVehicleSystem.ExitVehicle(PlayerPawn)
            end
            local WeaponActor =  UGCVehicleSystem.GetVehicleWeapon(VehicleActor,1,1)
            WeaponActor:LocalSetBulletNumInClip(self.VehicleWeaponBulletNum)
        else
            UGCLog.Log("[maoyu Warning] Skipping invalid VehicleActor.")
        end
    end
end

function BPGameState_ProtectAthena:GetCurrentRound()
    return self.CurrentRound
end


function BPGameState_ProtectAthena:SetCurrentRound(NewRound)
    if self:HasAuthority() and self.CurrentRound ~= NewRound then
        self.CurrentRound = NewRound
        -- 商店跟随回合数变化
        UGCLog.Log("BPGameState_ProtectAthenaSetCurrentRound",self.CurrentRound,self.BuffSkillShopLandList)
       
        for _, shop in pairs(self.BuffSkillShopLandList) do
            
            shop:SetShopID(self.CurrentRound)
        end
        local tShopID
        for _, shop in pairs(self.WeaponShopLandList) do
            -- UGCLog.Log("Instance metatable:", shop._isBP_ShopLandBase )
            -- UGCLog.Log("SetShopID exists:", shop.SetShopID ~= nil)
            tShopID = shop.DefaultShopID + 4 *(self.CurrentRound - 1)
            UGCLog.Log("WeaponShopLandListSetShopID exists:", tShopID)
            shop:SetShopID(tShopID)
        end
    end
end
function BPGameState_ProtectAthena:RoundStart()
    self.bIsInRound = true
    self.bIsOpenShovelAbility = true
    self.ReadyToFightSeconds = 0
end

function BPGameState_ProtectAthena:SetWinRound(InID)
    UGCLog.Log("BPGameState_ProtectAthenaSetWinRound",InID)
    self.iRoundWinTeamID = InID
    UGCLog.Log("BPGameState_ProtectAthenaSetWinRound",self.iRoundWinTeamID)
    if InID == 1 then
        self.iWinRound_ID1 = self.iWinRound_ID1 + 1
    else
        self.iWinRound_ID2 = self.iWinRound_ID2 + 1
    end
    if self.iWinRound_ID1 > self.iWinRound_ID2 then
        self.iWinTeamID = 1
    else
        self.iWinTeamID = 2
    end
    self.iWinRoundCount = math.max(self.iWinRound_ID1,self.iWinRound_ID2)
    self:SetCurrentRound(self.CurrentRound + 1)
    UGCLog.Log("BPGameState_ProtectAthenaSetWinRound",self.iWinRound_ID1,self.iWinRound_ID2,self.iWinRoundCount)
    -- BUG - 属性同步需要4s  所以通过RPC来通知客户端
    self:ForceNetUpdate()
    local AllController = UGCGameSystem.GetAllPlayerController()
    for _,Controller in pairs(AllController) do
        Controller:ClientRPC_SetRoundWinTeam(InID)
    end
end

function BPGameState_ProtectAthena:AddMonsterLevel(InCampID)
    print("AddMonsterLevel"..InCampID)
    if InCampID == 1 then
        self.iID2MonsterLevel = self.iID2MonsterLevel + 1
    elseif InCampID == 2 then
        self.iID1MonsterLevel = self.iID1MonsterLevel + 1
    end
   --全队播报
    local AllController = UGCGameSystem.GetAllPlayerController()
    for _,Controller in pairs(AllController) do
        Controller:ClientRPC_PlayTeamAnnouncerUI(1,InCampID)
    end
end

function BPGameState_ProtectAthena:CheckMonsterNumber(InID)
    if InID == 1 then
        return self.iID1MonsterNum >= self.MaxID1MonsterNum
    elseif InID == 2 then
        return self.iID2MonsterNum >= self.MaxID2MonsterNum
    end
end

function BPGameState_ProtectAthena:GetMonsterNum(InID)
    if InID == 1 then
        return self.iID1MonsterNum
    elseif InID == 2 then
        return self.iID2MonsterNum
    end
end
function BPGameState_ProtectAthena:SetMonsterNum(InID, InNum)
    ugcprint("BPGameState_ProtectAthenasSetMonsterNum "..InID.." "..InNum)
    if InNum < 0 then
        InNum = 0
    end
    if InID == 1 then
        self.iID1MonsterNum = InNum
    elseif InID == 2 then
        self.iID2MonsterNum = InNum
    end
    self.MonsterNumberChangedDelegate:Broadcast(InID)
    self:SetCurrentMonsterNumStage(InID)
end
function BPGameState_ProtectAthena:SetMonsterNumStage(InNum)
    if InNum == 1 then
        self.MonsterNumStage = 1
    elseif InNum == 2 then
        self.MonsterNumStage = 2
    end
    --PlayTaskStage
end

function BPGameState_ProtectAthena:SetKillNum(InID)
    if InID == 1 then
        self.iID1KillNum = self.iID1KillNum + 1
    elseif InID == 2 then
        self.iID2KillNum = self.iID2KillNum + 1
    end
    
end

function BPGameState_ProtectAthena:GetFailCountDownTime(InID)
    if InID == 1 then
        return self.fID1CurrentFailCountDown
    elseif InID == 2 then
        return self.fID2CurrentFailCountDown
    end
    return 0
end

function BPGameState_ProtectAthena:GetCurrentMonsterNumStage_ID1()
    return self.CurrentMonsterNumStage_ID1
end
function BPGameState_ProtectAthena:SetCurrentMonsterNumStage_ID1(InNum)
    if self.CurrentMonsterNumStage_ID1 ~= InNum then
        self.CurrentMonsterNumStage_ID1 = InNum
        local AllController = UGCGameSystem.GetAllPlayerController()
        for _,Controller in pairs(AllController) do
            Controller:HandleStageDiscountChange(1,self.CurrentMonsterNumStage_ID1)
        end
    end
    
end

function BPGameState_ProtectAthena:GetCurrentMonsterNumStage_ID2()
    return self.CurrentMonsterNumStage_ID2
end
function BPGameState_ProtectAthena:SetCurrentMonsterNumStage_ID2(InNum)
     if self.CurrentMonsterNumStage_ID2 ~= InNum then
        self.CurrentMonsterNumStage_ID2 = InNum
        local AllController = UGCGameSystem.GetAllPlayerController()
        for _,Controller in pairs(AllController) do
            Controller:HandleStageDiscountChange(2,self.CurrentMonsterNumStage_ID2)
        end
    end
end

function BPGameState_ProtectAthena:SetCurrentMonsterNumStage(InID)
    if self:HasAuthority() then
        local tCurrentMonsterNumStage  = 1
        if self:GetMonsterNum(InID) > 0 and self:GetMonsterNum(InID) < self.MonsterNumStage2 then
            tCurrentMonsterNumStage = 1
        elseif self:GetMonsterNum(InID) >= self.MonsterNumStage2 and self:GetMonsterNum(InID) < self.MonsterNumStage3 then
            tCurrentMonsterNumStage = 2
            self:PlayStageTwoBGM(InID)
        elseif self:GetMonsterNum(InID) >= self.MonsterNumStage3 then
            tCurrentMonsterNumStage = 3
        end
        if InID == 1 then
            self:SetCurrentMonsterNumStage_ID1(tCurrentMonsterNumStage)
            --self.CurrentMonsterNumStage_ID1 = tCurrentMonsterNumStage
        elseif InID == 2 then
            self:SetCurrentMonsterNumStage_ID2(tCurrentMonsterNumStage)
            --self.CurrentMonsterNumStage_ID2 = tCurrentMonsterNumStage
        end
    end
    ugcprint("BPPlayerState_ProtectAthenaOn_self_SetCurrentMonsterNumStage")
end
function BPGameState_ProtectAthena:PlayStageTwoBGM(InID)
    -- if self.PlayStageTwoBGMOnce then
    --     local AllController = UGCGameSystem.GetAllPlayerController()
    --     for _,Controller in pairs(AllController) do
    --         if Controller.PlayerState.TeamID == InID then
    --             Controller:ClientRPC_PlaySound(2)
    --         end
            
    --     end
    --     self.PlayStageTwoBGMOnce = not self.PlayStageTwoBGMOnce
    -- end
    local AllController = UGCGameSystem.GetAllPlayerController()
    for _,Controller in pairs(AllController) do
        if Controller.PlayerState.TeamID == InID then
            Controller:ClientRPC_PlaySound(2)
        end
        
    end
end

function BPGameState_ProtectAthena:AddCurrentPlayerData(InUID,InPlayerKey,InName)
    local PlayerController = UGCGameSystem.GetPlayerControllerByPlayerKey(InPlayerKey) 
    local PlayerState = PlayerController.PlayerState
    local tPlayerData = 
    {
        -- UID = 0,
        -- PlayerKey = 1, 
        -- Name = "Playername",
        -- EnemyCount = 0,
        -- Damage = 0,
        -- Gold = 0,
        -- DefaultRespawnCount = 0,
        -- DefaultRefreshPoint = 0,
    }
    -- tPlayerData.UID = InUID
    -- tPlayerData.PlayerKey = InPlayerKey
    -- tPlayerData.Name = InName
    if self.PlayerData[InPlayerKey] == nil then
        self.PlayerData[InPlayerKey] = {}
        --该玩家第一次进入当局游戏
        self.PlayerData[InPlayerKey] = PlayerState.ReconnectData
        --(UID,PlayerKey 在playerstate的beginplay中拿不到,放到这来拿)
        self.PlayerData[InPlayerKey]["UID"] = InUID
        self.PlayerData[InPlayerKey]["PlayerKey"] = InPlayerKey
        self.PlayerData[InPlayerKey]["Name"] = InName
        self.PlayerData[InPlayerKey].bIsFirstChoose = true
    else
        --重连
        PlayerState.Gold = self.PlayerData[InPlayerKey].Gold
        PlayerState.EnemyCount = self.PlayerData[InPlayerKey].EnemyCount
        PlayerState.bIsFirstChoose = self.PlayerData[InPlayerKey].bIsFirstChoose
        PlayerState.DefaultRespawnCount = self.PlayerData[InPlayerKey].DefaultRespawnCount
        PlayerState.DefaultRefreshPoint = self.PlayerData[InPlayerKey].DefaultRefreshPoint
        PlayerState.ReconnectData = self.PlayerData[InPlayerKey]
        PlayerState:InitializeReconnectData()
    end
    

    UGCLog.Log("AddCurrentPlayerData",self.PlayerData)
end

-- 获取另一个队伍的玩家
-- @param InTeamID: 当前队伍ID
function BPGameState_ProtectAthena:FindAnotherTeamPlayer(InTeamID)
    -- 获取所有玩家控制器
    local PlayerControllers = UGCGameSystem.GetAllPlayerController(false)

    -- 遍历玩家控制器列表
    while #PlayerControllers > 0 do
        -- 随机选择一个玩家控制器
        local Random = math.random(1, #PlayerControllers);
        local controller = PlayerControllers[Random]

        -- 检查是否为不同队伍且玩家存活
        if controller.PlayerState.TeamID ~= InTeamID and controller:GetPlayerCharacterSafety().Health>0 then
            --UGCLog.Log("[maoyu] player队伍不同=" ,controller:GetPlayerCharacterSafety(),"TeamID = ",controller.PlayerState.TeamID,"InTeamID = ",InTeamID)
            return controller:GetPlayerCharacterSafety()
        end

        -- 移除已检查的玩家控制器
        table.remove(PlayerControllers,Random)
    end

    -- 如果没有找到符合条件的玩家，返回 nil
    return nil
end

-- 获取另一个队伍的所有存活玩家
-- @param InTeamID: 当前队伍ID
function BPGameState_ProtectAthena:GetAllTheSurvivingPlayersOfTheOtherTeam(InTeamID)
    local PlayerPawnList = {}
    -- 获取所有玩家控制器
    local AllController = UGCGameSystem.GetAllPlayerController()
    for _,Controller in pairs(AllController) do
        if Controller.PlayerState.TeamID ~= InTeamID and UGCPlayerStateSystem.IsAlive(Controller.PlayerKey) then
            table.insert(PlayerPawnList,Controller:GetPlayerCharacterSafety())
        end
    end
    return PlayerPawnList
end

-- 商业化相关
function BPGameState_ProtectAthena:OnBuyUGCCommodityResult(bSucceeded, PlayerKey, CommodityID, Count, UID, ProductID)
    UGCLog.Log("购买结果委托",bSucceeded, PlayerKey, CommodityID, Count, UID, ProductID)
    local PlayerController = UGCGameSystem.GetPlayerControllerByPlayerKey(PlayerKey)
    if UE.IsValid(PlayerController) then
        if CommodityID == 1002 then --复活币
            PlayerController:RevivalCoinCommodityResult(bSucceeded,Count)
        elseif CommodityID == 1006 then -- 刷新点
            PlayerController:BuyRefreshPointCommodityResult(bSucceeded,Count)
        end 
        
    end
    self:CorrectionOfCommodityQuantity(PlayerKey,CommodityID)
end
-- 购买矫正
function BPGameState_ProtectAthena:CorrectionOfCommodityQuantity(PlayerKey,CommodityID)
    UGCLog.Log("商品数量矫正")
    local PlayerController = UGCGameSystem.GetPlayerControllerByPlayerKey(PlayerKey)
    local cond = UGCGameSystem.IsServer()
    if cond then
        -- 解决商品数量 1 -> 0 的问题
        local bIsFind = false
        local Result = UGCCommoditySystem.GetAllPlayerUGCCommodityList()
        for i, tData in pairs(Result[PlayerController:GetInt64UID()]) do
            if tData.CommodityID == CommodityID then
                bIsFind = true
                PlayerController:UpDataCommodityNumber(tData.CommodityID,tData.Count)
                break
            end 
        end
        if not bIsFind then
            PlayerController:UpDataCommodityNumber(CommodityID,0)
        end 
        ugcprint(ToTreeString(Result[PlayerController:GetInt64UID()]))
    else
        local Result = UGCCommoditySystem.GetUGCCommodityList()
        PlayerController:UpDataCommodityNumber(Result.CommodityID,Result.Count)
        ugcprint(ToTreeString(Result))
    end
end

function BPGameState_ProtectAthena:OnUseUGCCommodityResult(bSucceeded, PlayerKey, CommodityID, Count,UID)
    UGCLog.Log("使用结果委托",bSucceeded, PlayerKey, CommodityID, Count,UID)
    local PlayerController = UGCGameSystem.GetPlayerControllerByPlayerKey(PlayerKey)
    if UE.IsValid(PlayerController) then
        if CommodityID == 1002 then --复活币
            PlayerController:UseRevivalCoin(bSucceeded)
        elseif CommodityID == 1006 then
            PlayerController:UseRefreshPoint(bSucceeded)
        end 
        
    end
    self:CorrectionOfCommodityQuantity(PlayerKey,CommodityID)
end

-- 计算新技能伤害
function BPGameState_ProtectAthena:CalculateSkillDamage(InKey,InPawn)

    local playerState = UGCGameSystem.GetPlayerStateByPlayerPawn(InPawn)
    if not playerState then
        UGCLog.Log("[maoyu]CalculateSkillDamage playerState is nil")
        return 0
    end

    local modifyDamage = 0
    -- 根据技能前缀自动计算伤害
    if not string.find(InKey, "Skill5") then
        local weapon = UGCWeaponManagerSystem.GetCurrentWeapon(InPawn)
        local weaponDamage = 0
        if not UE.IsValid(weapon) then
            UGCLog.Log("[maoyu]CalculateSkillDamage weapon is nil")
            return 0
        end
        if UE.IsA(weapon,UE.LoadClass'/Script/ShadowTrackerExtra.STExtraShootWeapon') then
            weaponDamage = UGCGunSystem.GetBulletBaseDamage(weapon)
        elseif UE.IsA(weapon,UE.LoadClass'/Script/ShadowTrackerExtra.STExtraWeapon_Throw') then
            local weaponID = weapon:GetItemDefineID().TypeSpecificID
            local throwWeaponDamage = {
                [108003] = 100,
                [108002] = 137, 
                [108001] = 225,
                [108004] = 365
            }
            weaponDamage = throwWeaponDamage[weaponID] or 0
        end
        modifyDamage = weaponDamage
    else
        -- 站立技能skill5 通过最大生命值计算伤害
        modifyDamage = UGCPawnAttrSystem.GetHealthMax(InPawn)
    end

    local skillBaseDamage = playerState.PersistSkillDamagesList[InKey].SkillDamageMultiplier * modifyDamage
    local finallyDamage = skillBaseDamage + skillBaseDamage * playerState.PersistSkillDamagesList[InKey].DamageMultiplier
    return finallyDamage
end

function BPGameState_ProtectAthena:deepCopy(original)
    local copy
    if type(original) == "table" then
        copy = {}
        for origKey, origValue in next, original, nil do
            copy[self:deepCopy(origKey)] = self:deepCopy(origValue)
        end
        setmetatable(copy, self:deepCopy(getmetatable(original)))
    else 
        copy = original
    end
    return copy
end

-- 传送相关
function BPGameState_ProtectAthena:UseTheTelepont(InCampID)
    local AllController = UGCGameSystem.GetAllPlayerController()
    for _,Controller in pairs(AllController) do
        self.TepeportActorList[1]:StartTeleportSecquence(Controller)
        self.TepeportActorList[2]:StartTeleportSecquence(Controller)
        Controller:ClientRPC_PlayTeamAnnouncerUI(3,InCampID)
    end
end
--@field LuaModifyDamage:fun(Damage:float,DamageType:int32,InstigatorPlayerState:ASTExtraPlayerState,VictimPlayerState:ASTExtraPlayerState):float
return BPGameState_ProtectAthena
