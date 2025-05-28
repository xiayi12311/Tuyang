---@class Level_16_C:BP_YXMonsterBase_C
---@field UAESkillManager UUAESkillManagerComponent
---@field UAEMonsterAnimList_Base UAEMonsterAnimList_Base_C
--Edit Below--
local Level_16 = {}

Level_16.gold = 120
Level_16.HasPlay = false

local ParticleSystem = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))

local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
Level_16.CampID = 0

function Level_16:ReceiveBeginPlay()
    Level_16.SuperClass.ReceiveBeginPlay(self)
    self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
end

function Level_16:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 and EventInstigator and EventInstigator.PlayerState then
        local DropSkillEmementClss = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/SkillAoctors/TuYang_DropSkillElementActor1.TuYang_DropSkillElementActor1_C'))

        
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        EventInstigator.PlayerState:AddDamageCount(Damage)

        local rate = UGCGameSystem.GameState.DropSkillElementRate
        -- 7.75%概率掉落技能碎片
        if math.random(1, 10000) <= rate then  -- 万分位精度判断
            UGCLog.Log("[maoyu]:KuangZhan:OnSelfDeath - SpawnAnything")
            UGCGameSystem.SpawnActor(self,DropSkillEmementClss,self:K2_GetActorLocation())
        end
    end
end

function Level_16:ReceiveEndPlay()
    Level_16.SuperClass.ReceiveEndPlay(self) 
    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID,GameState:GetMonsterNum(self.CampID) - 1)
    end
end

function Level_16:ReceiveTick(DeltaTime)
    Level_16.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;

        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end

--[[
function Level_16:GetReplicatedProperties()
    return
end
--]]

--[[
function Level_16:GetAvailableServerRPCs()
    return
end
--]]

return Level_16