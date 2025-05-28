---@class BPGameMode_ProtectAthena_C:BP_UGCGameBase_C
--Edit Below--
local Delegate = require("common.Delegate")
local DependencyProperty = require("common.DependencyProperty")

local BPGameMode_ProtectAthena = BPGameMode_ProtectAthena or {}



BPGameMode_ProtectAthena.BP_SummonSpawnedDelegate = Delegate.New()

function BPGameMode_ProtectAthena:ReceiveBeginPlay()
    sandbox.LogNormalDev(StringFormat_Dev("[BPGameMode_ProtectAthena:ReceiveBeginPlay] self=%s", GetObjectFullName_Dev(self)))
    self.bIsOpenShovelAbility = true
    BPGameMode_ProtectAthena.SuperClass.ReceiveBeginPlay(self)

    local GameState = GameplayStatics.GetGameState(self)
    GameState.CurrentRoundChangedDelegate:Add(self.On_BPGameState_ProtectAthena_CurrentRoundChanged, self)
    GameState.CurrentSummonCountChangedDelegate:Add(self.On_BPGameState_CurrentSummonCountChanged, self)
    
    
    -- TuYnag
    local tBgmMangerPath = UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/BP_BGMManger.BP_BGMManger_C')
    local tbgmmangercalss = UE.LoadClass(tBgmMangerPath)
    self.BGMManger =  ScriptGameplayStatics.SpawnActor(self,tbgmmangercalss,{X=290.000000,Y=-3690.000000,Z=1630.000000},{Pitch=0.000000,Yaw=0.000000,Roll=0.000000},{X = 1, Y = 1, Z = 1},self);
    ugcprint("BPGameMode_ProtectAthena:ReceiveBeginPlay")
   
    
end

function BPGameMode_ProtectAthena:ReceiveEndPlay()
    sandbox.LogNormalDev(StringFormat_Dev("[BPGameMode_ProtectAthena:ReceiveEndPlay] self=%s", GetObjectFullName_Dev(self)))

    local GameState = GameplayStatics.GetGameState(self)
    if UE.IsValid(GameState) then
        GameState.CurrentRoundChangedDelegate:Remove(self.On_BPGameState_ProtectAthena_CurrentRoundChanged, self)
        GameState.CurrentSummonCountChangedDelegate:Remove(self.On_BPGameState_CurrentSummonCountChanged, self)
        
    end

    BPGameMode_ProtectAthena.SuperClass.ReceiveEndPlay(self)
end

function BPGameMode_ProtectAthena:On_BPGameState_ProtectAthena_CurrentRoundChanged(BPGameState_ProtectAthena)
    sandbox.LogNormalDev(
        StringFormat_Dev(
            "[BPGameMode_ProtectAthena:On_BPGameState_ProtectAthena_CurrentRoundChanged] BPGameState_ProtectAthena=%s CurrentRound=%s MaxRound=%s", 
            GetObjectFullName_Dev(BPGameState_ProtectAthena), 
            ToString_Dev(BPGameState_ProtectAthena.CurrentRound), 
            ToString_Dev(BPGameState_ProtectAthena.MaxRound)
        )
    )

    if 
        BPGameState_ProtectAthena.CurrentRound > BPGameState_ProtectAthena.MaxRound and 
        BPGameState_ProtectAthena.GameStatus == "GameFight"
    then
        
    end
end

function BPGameMode_ProtectAthena:On_BPGameState_CurrentSummonCountChanged(GameState)
    sandbox.LogNormalDev(
        StringFormat_Dev(
            "[BPGameMode_ProtectAthena:On_BPGameState_CurrentSummonCountChanged] self=%s GameState=%s CurrentSummonCount=%s GameStatus=%s CurrentRound=%s MaxRound=%s", 
            GetObjectFullName_Dev(self), 
            GetObjectFullName_Dev(GameState), 
            ToString_Dev(GameState.CurrentSummonCount), 
            ToString_Dev(GameState.GameStatus), 
            ToString_Dev(GameState.CurrentRound), 
            ToString_Dev(GameState.MaxRound)
        )
    )

    if GameState.CurrentSummonCount <= 0 and GameState.GameStatus == "GameFight" and GameState.CurrentRound >= GameState.MaxRound then
        
    end
end

-- 伤害覆写函数
--@param Damage 伤害值
--@param DamageType 伤害类型，参考EDamageType
--@param InstigatorPlayerState 造成伤害的玩家状态
--@param VictimPlayerState 受到伤害的玩家状态
function BPGameMode_ProtectAthena:LuaModifyDamage(Damage,DamageType,InstigatorPlayerState,VictimPlayerState)
    -- 调试输出
    ugcprint("[Damage] Type: "..tostring(DamageType)..", Value: "..Damage)

    -- 1. 友军伤害检查
    if InstigatorPlayerState ~= VictimPlayerState then
        if InstigatorPlayerState and VictimPlayerState then
            local instigatorTeam = InstigatorPlayerState.TeamID
            local victimTeam = VictimPlayerState.TeamID
            ugcprint("Attacker Team: "..tostring(instigatorTeam)..", Victim Team: "..tostring(victimTeam))
    
            if instigatorTeam == victimTeam then
                ugcprint("Block friendly fire")
                return 0 -- 友军伤害归零
            end
        end
    end

    -- 2. 爆炸伤害增幅
    -- if DamageType == 100 then
    --     local multipliedDamage = Damage * 2.8
    --     ugcprint("Explosive damage boosted: "..multipliedDamage)
    --     return multipliedDamage
    -- end

    -- 3. 近战伤害修改
    if DamageType == 16 and InstigatorPlayerState then
        local player = UGCGameSystem.GetPlayerPawnByPlayerState(InstigatorPlayerState)
        if not player then
            ugcprint("[maoyu] 近战伤害修改 player 为空")
            return Damage
        end
        local weapon = UGCWeaponManagerSystem.GetCurrentWeapon(player)
        if not weapon then
            ugcprint("[maoyu] 近战伤害修改 weapon 为空")
            return Damage
        end
        
        local tItemID = weapon:GetItemDefineID().TypeSpecificID
        local multipliedDamage = 0
        local MeleeWeaponDamage = {
                [108003] = 50,
                [108002] = 68.5, 
                [108001] = 112.5,
                [108004] = 182.5
        }
        multipliedDamage = MeleeWeaponDamage[tItemID] or 0
        if multipliedDamage > 0 then
            ugcprint("[maoyu] 近战伤害修改为 ： "..multipliedDamage)
            return multipliedDamage
        end
    end
    -- 默认返回原伤害
    return Damage
end

return BPGameMode_ProtectAthena