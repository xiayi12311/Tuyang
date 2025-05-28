---@class BPPlayerState_ProtectAthena_C:BP_UGCPlayerState_C
---@field BP_CameraShakeBaseComponent BP_CameraShakeBaseComponent_C
--Edit Below--
local Delegate = require("common.Delegate")

local EventSystem = require("Script.Common.UGCEventSystem")

local BPPlayerState_ProtectAthena = BPPlayerState_ProtectAthena or {}

--玩家金钱
BPPlayerState_ProtectAthena.Gold = 1500
-- 怪物死亡时获取金币系数
BPPlayerState_ProtectAthena.MonsterDiedGoldScale = 1
-- 怪物死亡时额外获取金钱
BPPlayerState_ProtectAthena.MonsterDiedExtraGold = 0

BPPlayerState_ProtectAthena.Hot = 100
BPPlayerState_ProtectAthena.InsectCount = 0 --击杀蟑螂计数
BPPlayerState_ProtectAthena.TaskStage_Insect = 0
BPPlayerState_ProtectAthena.TaskStage_XiaoQi = 0
BPPlayerState_ProtectAthena.GoldChangedDelegate = Delegate.New()

BPPlayerState_ProtectAthena.InIce = false

BPPlayerState_ProtectAthena.AkEvent = 0
BPPlayerState_ProtectAthena.BGMID = 0;
BPPlayerState_ProtectAthena.EnemyCount = 0
BPPlayerState_ProtectAthena.DamageCount = 0
BPPlayerState_ProtectAthena.TotalGold = 0

function BPPlayerState_ProtectAthena:GetPlayerBornPoint()
    return self.PlayerBornPoint
end

-- function BPPlayerState_ProtectAthena:BeginShake()
--     self.BP_CameraShakeBaseComponent:SetActive(true)  
-- end

-- function BPPlayerState_ProtectAthena:StopShake()
--     self.BP_CameraShakeBaseComponent:SetActive(false)
-- end


-- TuYang
-- 断线重连相关数据
BPPlayerState_ProtectAthena.ReconnectData = 
{
    EnemyCount = 0,
    DefaultRespawnCount = 1,
    DefaultRefreshPoint = 3,
    iBeenRespawnNums = 0,
    iBuffSkillElement = 0, --技能碎片（粽子）
    BuffSkillList = {}, --技能列表
    
}


-- 复活倒计时
BPPlayerState_ProtectAthena.PlayerRespawnTime = {10,20,30,60,}
BPPlayerState_ProtectAthena.iRespawnTime = 1
-- 已复活次数（新增）
BPPlayerState_ProtectAthena.iBeenRespawnNums = 0
-- 无怪物时加钱数量
BPPlayerState_ProtectAthena.ZeroMonsterGold = 100

--结束倒计时
BPPlayerState_ProtectAthena.bIsStartCountdown = false
-- 当前阶段
BPPlayerState_ProtectAthena.CurrentMonsterNumStage = 1
-- BGM
BPPlayerState_ProtectAthena.SoundList = {
    {Path =  UGCMapInfoLib.GetRootLongPackagePath().. "Asset/WwiseEvent/DoubleRaiseTheme.DoubleRaiseTheme",bIsBGM = true},
    {Path = UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Attention_1.Attention_1'),bIsBGM = true},
    {Path = UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Warning25_1.Warning25_1'),bIsBGM = false},
    {Path = UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Warning50_1.Warning50_1'),bIsBGM = false},
}
BPPlayerState_ProtectAthena.TeleportCost = 1000
BPPlayerState_ProtectAthena.TeleportCostScale = 1
-- 复活币（跟随玩家存档）
BPPlayerState_ProtectAthena.RespawnCount = 0;
-- 复活币（本局默认）
BPPlayerState_ProtectAthena.DefaultRespawnCount = 1
-- 复活币（显示的复活币）
BPPlayerState_ProtectAthena.RealRespawnCount = 0

-- Buff 刷新点（跟随玩家存档）
BPPlayerState_ProtectAthena.RefreshPoint = 0
-- Buff 刷新点（本局默认）
BPPlayerState_ProtectAthena.DefaultRefreshPoint = 3
-- Buff 刷新点（显示的刷新点）
BPPlayerState_ProtectAthena.RealRefreshPoint = 0
-- 剩余BUFF选择次数
BPPlayerState_ProtectAthena.iRemainingSelectionTimes_Buff = 1
BPPlayerState_ProtectAthena.RemainingSelectionTimesMax_Buff = 1
-- 玩家可选buff卡池
BPPlayerState_ProtectAthena.SelectableBuffsList = {}
-- 回合胜利方
BPPlayerState_ProtectAthena.iRoundWinTeamID = 0

-- 判读玩家处于哪个商店（用于触发的刷新概率）
    --1 -> 绿色武器商店 
    -- 2 -> 蓝色武器商店 
    -- 3 -> 紫色武器商店 
    -- 4 -> 红色武器商店
BPPlayerState_ProtectAthena.iPlayerWhichWeaponStore = 1
    -- 是否第一次选择武器
BPPlayerState_ProtectAthena.bIsFirstChoose = true

BPPlayerState_ProtectAthena.iPlayerWhichBuffSkillStore = 1

BPPlayerState_ProtectAthena.StageBaseDisCountsList = {
    [1] = 1,
    [2] = 0.9,
    [3] = 0.7,
}
-- 商品折扣机制
BPPlayerState_ProtectAthena.Discounts = {
    StageBased = 1.0,  -- 基于阶段的折扣
    TimeBased = 1.0,   -- 基于时间的折扣
    EventBased = 1.0,  -- 基于事件的折扣
    PlayerBased = 1.0  -- 基于玩家状态的折扣
}
BPPlayerState_ProtectAthena.TotalDiscount  = 1.0  -- 总折扣系数
--商品总折扣
BPPlayerState_ProtectAthena.fItemDiscount = 0

-- 初始技能碎片
BPPlayerState_ProtectAthena.EuffSkillElement = 5
BPPlayerState_ProtectAthena.RoundEndEuffSkillElement = 10
BPPlayerState_ProtectAthena.BuffSkillElementNeed = 7
function BPPlayerState_ProtectAthena:GetReplicatedProperties()
    return 
    "Gold",
    "RespawnCount",
    "RealRespawnCount",
    "EnemyCount",
    "DamageCount",
    "TotalGold",
    "InsectCount",
    "TaskStage_Insect",
    "TaskStage_XiaoQi",
    "bIsStartCountdown",
    "CurrentMonsterNumStage",
    "TeleportCost",
    "TeleportCostScale",
    "RefreshPoint",
    "DefaultRefreshPoint",
    "RealRefreshPoint",
    "iRespawnTime",
    "AkEvent",
    "iRoundWinTeamID",
    "iPlayerWhichWeaponStore",
    "iRemainingSelectionTimes_Buff",
    "SelectableBuffsList",
    "bIsFirstChoose",
    "iPlayerWhichBuffSkillStore",
    "TotalDiscount",
    "ReconnectData",
    "BuffSkillElementNeed"

    --,
    --"Hot"
end

function BPPlayerState_ProtectAthena:OnRep_bIsStartCountdown()
    
end

function BPPlayerState_ProtectAthena:OnRep_CurrentMonsterNumStage()
    ugcprint("OnRep_CurrentMonsterNumStage "..self.CurrentMonsterNumStage)
end

function BPPlayerState_ProtectAthena:OnRep_TeleportCost()

end
function BPPlayerState_ProtectAthena:OnRep_TeleportCostScale()

end
function BPPlayerState_ProtectAthena:OnRep_AkEvent()
    
end
function BPPlayerState_ProtectAthena:OnRep_iRoundWinTeamID()
    
end

function BPPlayerState_ProtectAthena:OnRep_Gold()
    self.GoldChangedDelegate(self)
end
function BPPlayerState_ProtectAthena:OnRep_iPlayerWhichWeaponStore()
    
end
function BPPlayerState_ProtectAthena:OnRep_iRemainingSelectionTimes_Buff()
    
end
function BPPlayerState_ProtectAthena:OnRep_SelectableBuffsList()
    
end
function BPPlayerState_ProtectAthena:OnRep_bIsFirstChoose()

end
function BPPlayerState_ProtectAthena:OnRep_iPlayerWhichBuffSkillStore()

end
function BPPlayerState_ProtectAthena:OnRep_TotalDiscount()
    
end
local  TaskButton = nil
local  VoteClass = nil
function BPPlayerState_ProtectAthena:ReceiveBeginPlay()
    ugcprint("PlayerState Begin!")
    sandbox.LogNormalDev(StringFormat_Dev("[BPPlayerState_ProtectAthena:ReceiveBeginPlay] self=%s", GetObjectFullName_Dev(self)))

    BPPlayerState_ProtectAthena.SuperClass.ReceiveBeginPlay(self)
   -- self:s
    local GameMode = GameplayStatics.GetGameMode(self)
    if UE.IsValid(GameMode) then
        GameMode.BP_SummonSpawnedDelegate:Add(
            function (GameMode, BP_Summon)
                print("BPPlayerState_ProtectAthena:SummonSpawnedDelegate")
                BP_Summon.DamageReceivedDelegate:Add(self.OnBP_SummonDamageReceived, self)
                --BP_Summon.OnDeath:AddInstance(self.OnBP_SummonDeath, self)
            end
        )
    end

    --TuYang
    local GameState = UGCGameSystem.GetGameState()
    GameState.MonsterNumberChangedDelegate:Add(self.On_GameState_MonsterNumberChangeDelegate,self)
    --self.OnDeath:AddInstance(self.OnSelfDeath,self)
    
    self:SetReconnectDataValue("iBeenRespawnNums",0)
    self:SetReconnectDataValue("DefaultRespawnCount",1)
    self:SetReconnectDataValue("DefaultRefreshPoint",3)
    self:SetReconnectDataValue("iBuffSkillElement",self.EuffSkillElement)
    

    self:SetRealRefreshPoint(self:GetDefaultRefreshPoint() + self:GetRefreshPoint())
    self:SetRealRespawnCount(self:GetDefaultRespawnCount() + self:GetRespawnCount())
end
function BPPlayerState_ProtectAthena:InitializeReconnectData()
    self:SetRealRefreshPoint(self:GetDefaultRefreshPoint() + self:GetRefreshPoint())
    self:SetRealRespawnCount(self:GetDefaultRespawnCount() + self:GetRespawnCount())

    local PlayerController = UGCGameSystem.GetPlayerControllerByPlayerState(self)
    PlayerController.PlayerBuffComponent.BuffList = self:GeReconnectDataValue("BuffSkillList")
    --UGCLog.Log("InitializeReconnectData",self.ReconnectData,self:GetDefaultRefreshPoint(),self:GetRealRefreshPoint())
end

-- 断线重连数据
function BPPlayerState_ProtectAthena:GeReconnectDataValue(InKey)
    return self.ReconnectData[InKey]
end
function BPPlayerState_ProtectAthena:SetReconnectDataValue(InKey,InNum)
    self.ReconnectData[InKey] = InNum
    local GameState = UGCGameSystem.GetGameState()
    if GameState then
        GameState:SetPlayerData(self.PlayerKey, InKey, self.ReconnectData[InKey])
    end
    
end

function BPPlayerState_ProtectAthena:RPCAddGold(InGold)
    self:SetGold(self.Gold + InGold)
end
function BPPlayerState_ProtectAthena:DecreaseGold(InGold)
    self:SetGold(self.Gold - InGold)
end

function BPPlayerState_ProtectAthena:CheckGoldEnough(InCost)
    return self.Gold >= InCost
end

function BPPlayerState_ProtectAthena:ReceiveEndPlay()
    sandbox.LogNormalDev(StringFormat_Dev("[BPPlayerState_ProtectAthena:ReceiveEndPlay] self=%s", GetObjectFullName_Dev(self)))

    BPPlayerState_ProtectAthena.SuperClass.ReceiveEndPlay(self)

    
end


function BPPlayerState_ProtectAthena:MonsterDiedGoldCompute(InAddGold)
    local tAddGold = InAddGold
    local tGold = InAddGold * BPPlayerState_ProtectAthena.MonsterDiedGoldScale + BPPlayerState_ProtectAthena.MonsterDiedExtraGold
    return tGold
end
function BPPlayerState_ProtectAthena:MonsterDiedAddGoldHandle(gold)
    if self:HasAuthority() then
        local tGold = self:MonsterDiedGoldCompute(gold)
        self.Gold = self.Gold + tGold
        self:AddTotalGold(tGold)
        ugcprint("PlayerSave UID "..self.UID)
        EventSystem:SendEvent("MonsterDied");
    end
end
function BPPlayerState_ProtectAthena:SetMonsterDiedGoldScale(InMonsterDiedGoldScale)
    self.MonsterDiedGoldScale = InMonsterDiedGoldScale
end
function BPPlayerState_ProtectAthena:SetMonsterDiedExtraGold(InMonsterDiedExtraGold)
    self.MonsterDiedExtraGold = InMonsterDiedExtraGold
end


function BPPlayerState_ProtectAthena:OnBP_SummonDamageReceived(BP_Summon, DamageAmount, DamageType, EventInstigator, DamageCauser)
    self.Gold = self.Gold + DamageAmount
    print("BPPlayerState_ProtectAthena:OnBP_SummonDamageReceived , CurrentGold:"..self.Gold)
    self.GoldChangedDelegate(self)
end

function BPPlayerState_ProtectAthena:SetAkEvent(num)
    self.AkEvent = num
end

function BPPlayerState_ProtectAthena:GetAkEvent()
    return self.AkEvent
end

function BPPlayerState_ProtectAthena:SetBGMID(num)
    self.BGMID = num
end

function BPPlayerState_ProtectAthena:GetBGMID()
    return self.BGMID
end


function BPPlayerState_ProtectAthena:AddEnemyCount()
    ugcprint("Enemy add count "..self.EnemyCount)
    if self:HasAuthority() then
        self.EnemyCount = self.EnemyCount + 1    
        --UGCGameSystem.GetGameState():UpDatePlayerEnemyCount(self.PlayerKey,self.EnemyCount)
        UGCGameSystem.GetGameState():SetPlayerData(self.PlayerKey, "EnemyCount", self.EnemyCount)
    end
end

function BPPlayerState_ProtectAthena:GetEnemyCount()
    ugcprint("insect add count "..self.EnemyCount)
    return self.EnemyCount
end

function BPPlayerState_ProtectAthena:AddDamageCount(num)
    ugcprint("Damage add count "..self.DamageCount)
    self.DamageCount = self.DamageCount+num
    --UGCGameSystem.GetGameState():UpDatePlayerDamage(self.PlayerKey,self.DamageCount)
    UGCGameSystem.GetGameState():SetPlayerData(self.PlayerKey, "DamageCount", self.DamageCount)
end

function BPPlayerState_ProtectAthena:GetDamageCount()
    ugcprint("Damage add count "..self.DamageCount)
    return self.DamageCount
end
function BPPlayerState_ProtectAthena:AddTotalGold(num)
    ugcprint("Gold add count "..self.TotalGold)
    self.TotalGold = self.TotalGold+num
    --UGCGameSystem.GetGameState():UpDateTotal(self.PlayerKey,self.TotalGold)
    UGCGameSystem.GetGameState():SetPlayerData(self.PlayerKey, "TotalGold", self.TotalGold)
end

function BPPlayerState_ProtectAthena:GetTotalGold()
    ugcprint("Gold add count "..self.TotalGold)
    return self.TotalGold
end
function BPPlayerState_ProtectAthena:GetGold()
    return self.Gold
end
function BPPlayerState_ProtectAthena:SetGold(InNum)
    self.Gold = InNum
    local GameState = UGCGameSystem.GetGameState()
    if GameState then
        --GameState:UpDatePlayerGold(self.PlayerKey, self.Gold)
        GameState:SetPlayerData(self.PlayerKey, "Gold", self.Gold)
    end
    --UGCLog.Log("[LJH]SetGoldPlayerStateSetGold",GameState:GetPlayerData())
end
function BPPlayerState_ProtectAthena:SetIsFirstChoose(InIsFirstChoose)
    self.bIsFirstChoose = InIsFirstChoose
    local GameState = UGCGameSystem.GetGameState()
    if GameState then
        --GameState:UpDatePlayerIsFirstChoose(self.PlayerKey, self.bIsFirstChoose)
        GameState:SetPlayerData(self.PlayerKey, "bIsFirstChoose", self.bIsFirstChoose)
    end
end
function  BPPlayerState_ProtectAthena:GetPlayerKey()
    return self.PlayerKey 
end


function BPPlayerState_ProtectAthena:GetEnemyCount()
    ugcprint("insect add count "..self.InsectCount )
    return self.EnemyCount
end

function BPPlayerState_ProtectAthena:GetRespawnCount()
    return self.RespawnCount
end
function BPPlayerState_ProtectAthena:SetRespawnCount(InNum)
    self.RespawnCount = InNum
    self:SetRealRespawnCount(self:GetDefaultRespawnCount() + self:GetRespawnCount())
end
function BPPlayerState_ProtectAthena:MinusRespawnCount()
    self.RespawnCount = self.RespawnCount-1
end
function BPPlayerState_ProtectAthena:GetDefaultRespawnCount()
    return self.ReconnectData.DefaultRespawnCount
end

function BPPlayerState_ProtectAthena:SetDefaultRespawnCount(InNum)
    self.ReconnectData.DefaultRespawnCount = InNum
    self:SetRealRespawnCount(self:GetDefaultRespawnCount() + self:GetRespawnCount())
    local GameState = UGCGameSystem.GetGameState()
    if GameState then
        GameState:SetPlayerData(self.PlayerKey, "DefaultRespawnCount", self.ReconnectData.DefaultRespawnCount)
    end
end

function BPPlayerState_ProtectAthena:GetRealRespawnCount()
    return self.RealRespawnCount
end

function BPPlayerState_ProtectAthena:SetRealRespawnCount(InNum)
    self.RealRespawnCount = InNum
end


BPPlayerState_ProtectAthena.GunList = {} 
function BPPlayerState_ProtectAthena:AddGun(list)
    self.GunList =list
end

-- 玩家在游戏中的存档数据
BPPlayerState_ProtectAthena.GameSavePlayerData = 
{
    ["TotalNumberOfEnemiesKilled"] = 0,
    ["WinCount"] = 0,
}

function BPPlayerState_ProtectAthena:UpDataGameSavePlayerData(InKey,InValue)
    self.GameSavePlayerData[InKey] = InValue
end

function  BPPlayerState_ProtectAthena:SaveData()
    UGCLog.Log("PlayerStateSaveData",self.GameSavePlayerData)
    UGCPlayerStateSystem.SavePlayerArchiveData(self.UID, self.GameSavePlayerData)
end

function BPPlayerState_ProtectAthena:GetRespawnTime()
    return self.iRespawnTime
end
function BPPlayerState_ProtectAthena:SetRespawnTime(InNum)
    self.iRespawnTime = InNum
end
-- 新增的复活次数方法
function BPPlayerState_ProtectAthena:GetiBeenRespawnNums()
    return self.ReconnectData.iBeenRespawnNums
end

function BPPlayerState_ProtectAthena:SetiBeenRespawnNums(InNum)
    UGCLog.Log("SetiBeenRespawnNums",InNum)
    self.ReconnectData.iBeenRespawnNums = InNum
    local GameState = UGCGameSystem.GetGameState()
    if GameState then
        GameState:SetPlayerData(self.PlayerKey, "iBeenRespawnNums", self.ReconnectData.iBeenRespawnNums)
    end
end

function BPPlayerState_ProtectAthena:GetRefreshPoint()
    return self.RefreshPoint
end
function BPPlayerState_ProtectAthena:GetDefaultRefreshPoint()
    return self.ReconnectData.DefaultRefreshPoint
end

function BPPlayerState_ProtectAthena:SetRefreshPoint(InNum)
    --local tRefreshPoint = self.DefaultRefreshPoint + InNum
    self.RefreshPoint = InNum
    self:SetRealRefreshPoint(self:GetDefaultRefreshPoint() + self:GetRefreshPoint())
end

function BPPlayerState_ProtectAthena:SetDefaultRefreshPoint(InNum)
    self.ReconnectData.DefaultRefreshPoint = InNum
    self:SetRealRefreshPoint(self:GetDefaultRefreshPoint() + self:GetRefreshPoint())
    local GameState = UGCGameSystem.GetGameState()
    if GameState then
        GameState:SetPlayerData(self.PlayerKey, "DefaultRefreshPoint", self.ReconnectData.DefaultRefreshPoint)
    end
end
function BPPlayerState_ProtectAthena:GetRealRefreshPoint()
    return self.RealRefreshPoint
end
function BPPlayerState_ProtectAthena:SetRealRefreshPoint(InNum)
    self.RealRefreshPoint = InNum
end
function BPPlayerState_ProtectAthena:On_GameState_MonsterNumberChangeDelegate(InID)
    ugcprint("BPPlayerState_ProtectAthenaOn_GameState_MonsterNumberChangeDelegate")
    self:SetCurrentMonsterNumStage(InID)
end
function BPPlayerState_ProtectAthena:SetCurrentMonsterNumStage(InID)
    local GameState = UGCGameSystem.GetGameState()
    if self:HasAuthority() then
        if self.TeamID == InID then
            if GameState:GetMonsterNum(InID) > 0 and GameState:GetMonsterNum(InID) < GameState.MonsterNumStage2 then
            self.CurrentMonsterNumStage = 1
            elseif GameState:GetMonsterNum(InID) >= GameState.MonsterNumStage2 and GameState:GetMonsterNum(InID) < GameState.MonsterNumStage3 then
                self.CurrentMonsterNumStage = 2
                elseif GameState:GetMonsterNum(InID) >= GameState.MonsterNumStage3 then
                    self.CurrentMonsterNumStage = 3
            end
        end
    end
    ugcprint("BPPlayerState_ProtectAthenaOn_GameState_SetCurrentMonsterNumStage"..self.CurrentMonsterNumStage)
end
-- 商品折扣相关
function BPPlayerState_ProtectAthena:SetStageDiscounts(InStage)
    self.Discounts.StageBased = self.StageBaseDisCountsList[InStage] or 1.0
    self:CalculateTotalDiscount()
end
function BPPlayerState_ProtectAthena:CalculateTotalDiscount()
    local tDis = 1
    for k, v in pairs(self.Discounts) do
        tDis = tDis * v
    end
    self.TotalDiscount = tDis
    -- self.TotalDiscount = self.Discounts.StageBased * 
    --                     self.Discounts.TimeBased * 
    --                     self.Discounts.EventBased * 
    --                     self.Discounts.PlayerBased
end

-- 新技能，技能编辑器2.0path
BPPlayerState_ProtectAthena.PersistSkillsList = {
    UGCMapInfoLib.GetRootLongPackagePath() .. 'Asset/Blueprint/Prefabs/Skills/TuYang_AccurateSnipingSkill.TuYang_AccurateSnipingSkill_C',

    Skill1_1 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_IceCountGreenSkill_P_1_1.TuYang_IceCountGreenSkill_P_1_1_C',
    
    Skill2_1 = UGCMapInfoLib.GetRootLongPackagePath() .. 'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_IceRateBlueSkill_P_2_1.TuYang_IceRateBlueSkill_P_2_1_C',

    Skill1_2 = UGCMapInfoLib.GetRootLongPackagePath() .. 'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_FireCountPurpleSkill_P_1_2.TuYang_FireCountPurpleSkill_P_1_2_C',

    Skill2_2 = UGCMapInfoLib.GetRootLongPackagePath() .. 'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_FireRateGreenSkill_P_2_2.TuYang_FireRateGreenSkill_P_2_2_C',

    Skill3_3 = UGCMapInfoLib.GetRootLongPackagePath() .. 'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_LightCDGreenSkill_P_3_3.TuYang_LightCDGreenSkill_P_3_3_C',

    Skill1_4 = UGCMapInfoLib.GetRootLongPackagePath() .. 'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_WindCountRedSkill_P_1_4.TuYang_WindCountRedSkill_P_1_4_C',

    Skill2_3 = UGCMapInfoLib.GetRootLongPackagePath() .. 'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_LightRateRedSkill_P_2_3.TuYang_LightRateRedSkill_P_2_3_C',

    Skill1_3 = UGCMapInfoLib.GetRootLongPackagePath() .. 'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_LightCountBlueSkill_P_1_3.TuYang_LightCountBlueSkill_P_1_3_C',

    Skill2_4 = UGCMapInfoLib.GetRootLongPackagePath() .. 'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_WindRateBlueSkill_P_2_4.TuYang_WindRateBlueSkill_P_2_4_C',

    Skill4_1 = UGCMapInfoLib.GetRootLongPackagePath() .. 'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_IceMoveRedSkill_P_4_1.TuYang_IceMoveRedSkill_P_4_1_C',

    Skill4_3 = UGCMapInfoLib.GetRootLongPackagePath() .. 'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_LightMovePurpleSkill_P_4_3.TuYang_LightMovePurpleSkill_P_4_3_C',

    Skill4_2 = UGCMapInfoLib.GetRootLongPackagePath() .. 'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_FireMoveBlueSkill_P_4_2.TuYang_FireMoveBlueSkill_P_4_2_C',

    Skill5_4 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_WindStandBlueSkill_P_5_4.TuYang_WindStandBlueSkill_P_5_4_C',

    Skill5_1 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_IceStandRedSkill_P_5_1.TuYang_IceStandRedSkill_P_5_1_C',

    Skill5_2 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_FireStandGreenSkill_P_5_2.TuYang_FireStandGreenSkill_P_5_2_C',

    Skill5_3 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_LightStandPurpleSkill_P_5_3.TuYang_LightStandPurpleSkill_P_5_3_C',

    Skill4_4 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_WindMoveGreenSkill_P_4_4.TuYang_WindMoveGreenSkill_P_4_4_C',

    Skill3_2 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_FireCDRedSkill_P_3_2.TuYang_FireCDRedSkill_P_3_2_C',

    Skill3_1 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_IceCDPurpleSkill_P_3_1.TuYang_IceCDPurpleSkill_P_3_1_C',

    Skill3_4 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_WindCDPurpleSkill_P_3_4.TuYang_WindCDPurpleSkill_P_3_4_C',

    Skill3_5 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_DmgIncCDGreenSkill_P_3_5.TuYang_DmgIncCDGreenSkill_P_3_5_C',

    Skill3_6 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_DmgIncCDRedSkill_P_3_6.TuYang_DmgIncCDRedSkill_P_3_6_C',

    Skill4_5 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_SpeedMoveBlueSkill_P_4_5.TuYang_SpeedMoveBlueSkill_P_4_5_C',

    Skill4_6 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_SpeedMovePurpleSkill_P_4_6.TuYang_SpeedMovePurpleSkill_P_4_6_C',

    Skill4_7 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_SpeedMovePurpleSkill_P_4_7.TuYang_SpeedMovePurpleSkill_P_4_7_C',

    Skill1_6 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_WPCountBlueSkill_P_1_6.TuYang_WPCountBlueSkill_P_1_6_C',

    Skill2_5 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_WPRatePurpleSkill_P_2_5.TuYang_WPRatePurpleSkill_P_2_5_C',

    Skill1_5 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_WPCountGreenSkill_P_1_5.TuYang_WPCountGreenSkill_P_1_5_C',

    Skill2_6 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_WPRateBlueSkill_P_2_6.TuYang_WPRateBlueSkill_P_2_6_C',

    Skill1_7 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_WPCountGreenSkill_P_1_7.TuYang_WPCountGreenSkill_P_1_7_C',

    Skill2_8 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_FireRateRedSkill_P_2_8.TuYang_FireRateRedSkill_P_2_8_C',

    Skill1_9 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_WoodCountPurpleSkill_P_1_9.TuYang_WoodCountPurpleSkill_P_1_9_C',

    Skill2_9 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_WoodRateGreenSkill_P_2_9.TuYang_WoodRateGreenSkill_P_2_9_C',

    Skill3_9 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_WoodCDBlueSkill_P_3_9.TuYang_WoodCDBlueSkill_P_3_9_C',

    Skill4_9 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_WoodMoveBlueSkill_P_4_9.TuYang_WoodMoveBlueSkill_P_4_9_C',

    Skill5_9 = UGCMapInfoLib.GetRootLongPackagePath() ..'Asset/Blueprint/Prefabs/Skills/Passive/TuYang_WoodStandRedSkill_P_5_9.TuYang_WoodStandRedSkill_P_5_9_C'

   }

-- 新技能,伤害来源追踪表（存储格式：PersistSkillDamageSources[目标技能] = {来源前缀列表}
BPPlayerState_ProtectAthena.PersistSkillDamageSources = {}
-- 新技能，技能编辑器2.0伤害
--@param SkillDamageMultiplier 技能伤害倍率
--@param DamageMultiplier 属性伤害倍率
--@param WeaponArrtibute 修改的武器属性或玩家属性(弹夹容量、射速、子弹伤害、玩家速度、玩家生命值等等)
--@param Handler 处理函数
BPPlayerState_ProtectAthena.PersistSkillDamagesList = {
        -- Skill1系列
        Skill1_1 = {SkillDamageMultiplier = 1.0,    DamageMultiplier = 0.16,     WeaponArrtibute = 0.1, Handler = "IncShootIntervalTime"},
        Skill1_2 = {SkillDamageMultiplier = 0.15,   DamageMultiplier = 0.18,    WeaponArrtibute = 0.11,Handler = "QuickReloadTime"},
        Skill1_3 = {SkillDamageMultiplier = 0.5,    DamageMultiplier = 0.18,    WeaponArrtibute = 0.11,Handler = "IncBulletNumInOneClip"},
        Skill1_4 = {SkillDamageMultiplier = 0.35,   DamageMultiplier = 0.27,    WeaponArrtibute = 0.17,Handler = "QuickReloadTime"},
        Skill1_9 = {SkillDamageMultiplier = 0.75,   DamageMultiplier = 0.21,    WeaponArrtibute = 0.13,Handler = "QuickReloadTime"},
    
        -- Skill2系列
        Skill2_1 = {SkillDamageMultiplier = 0.7,    DamageMultiplier = 0.18, WeaponArrtibute = 1,   Handler = "IncBulletNumInOneClip"},
        Skill2_2 = {SkillDamageMultiplier = 0.1,    DamageMultiplier = 0.21,  WeaponArrtibute = 1,   Handler = "IncBulletNumInOneClip"},
        Skill2_3 = {SkillDamageMultiplier = 0.2,    DamageMultiplier = 0.27,  WeaponArrtibute = 0.17,Handler = "QuickReloadTime"},
        Skill2_4 = {SkillDamageMultiplier = 2.25  , DamageMultiplier = 0.18,  WeaponArrtibute = 1,   Handler = "IncBulletNumInOneClip"},
        Skill2_8 = {SkillDamageMultiplier = 1.0  ,  DamageMultiplier = 0.27,  WeaponArrtibute = 2  , Handler = "IncBulletNumInOneClip"},
        Skill2_9 = {SkillDamageMultiplier = 2  ,    DamageMultiplier = 0.16,  WeaponArrtibute = 0.1, Handler = "QuickReloadTime"},
    
        -- Skill3系列
        Skill3_1 = {SkillDamageMultiplier = 0.85, DamageMultiplier = 0.18, WeaponArrtibute = 0.11, Handler = "IncWeaponBulletDamage"},
        Skill3_2 = {SkillDamageMultiplier = 1.05, DamageMultiplier = 0.27, WeaponArrtibute = 0.17, Handler = "IncWeaponBulletDamage"},
        Skill3_3 = {SkillDamageMultiplier = 2.55, DamageMultiplier = 0.16, WeaponArrtibute = 0.1,  Handler = "IncWeaponBulletDamage"},
        Skill3_4 = {SkillDamageMultiplier = 1.35, DamageMultiplier = 0.21, WeaponArrtibute = 0.13, Handler = "IncWeaponBulletDamage"},
        Skill3_9 = {SkillDamageMultiplier = 1.3, DamageMultiplier = 0.18, WeaponArrtibute = 0.11, Handler = "IncWeaponBulletDamage"},
    
        -- Skill4系列
        Skill4_1 = {SkillDamageMultiplier = 0.05, DamageMultiplier = 0.27, WeaponArrtibute = 0.17, Handler = "SkillChangePlayerSpeed"},
        Skill4_2 = {SkillDamageMultiplier = 0.2, DamageMultiplier = 0.18, WeaponArrtibute = 0.11, Handler = "SkillChangePlayerSpeed"},
        Skill4_3 = {SkillDamageMultiplier = 0.03, DamageMultiplier = 0.21, WeaponArrtibute = 0.13, Handler = "SkillChangePlayerSpeed"},
        Skill4_4 = {SkillDamageMultiplier = 0.12, DamageMultiplier = 0.16, WeaponArrtibute = 0.1,  Handler = "SkillChangePlayerSpeed"},
        Skill4_9 = {SkillDamageMultiplier = 0.025, DamageMultiplier = 0.18, WeaponArrtibute = 0.11, Handler = "SkillChangePlayerSpeed"},
    
        -- Skill5系列
        Skill5_1 = {SkillDamageMultiplier = 0.025, DamageMultiplier = 0.21, WeaponArrtibute = 0.13, Handler = "SkillChangePlayerHealth"},
        Skill5_2 = {SkillDamageMultiplier = 0.1, DamageMultiplier = 0.16, WeaponArrtibute = 0.1,  Handler = "SkillChangePlayerHealth"},
        Skill5_3 = {SkillDamageMultiplier = 0.06, DamageMultiplier = 0.18, WeaponArrtibute = 0.11, Handler = "SkillChangePlayerHealth"},
        Skill5_4 = {SkillDamageMultiplier = 0.04, DamageMultiplier = 0.18, WeaponArrtibute = 0.11, Handler = "SkillChangePlayerHealth"},
        Skill5_9 = {SkillDamageMultiplier = 0.25, DamageMultiplier = 0.27, WeaponArrtibute = 0.17, Handler = "SkillChangePlayerHealth"}
}

return BPPlayerState_ProtectAthena