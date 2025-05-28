---@class BP_Scorpion_C:BP_YXMonsterBase_C
---@field UAEMonsterAnimListComponentBase UUAEMonsterAnimListComponentBase
---@field UAESkillManager UUAESkillManagerComponent
--Edit Below--
local BP_Scorpion = {}
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
local EventSystem =  require('Script.common.UGCEventSystem')
DropItemConfig = require("Script.DropItemConfig")
UGCDropItemMgr = require("Script.UGCDropItemMgr")
BP_Scorpion.gold = 100 
--BP_BP_Scorpion.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/BP_BP_Scorpion/Respawn/BP_BP_Scorpion_Respawn.BP_BP_Scorpion_Respawn_C'))
BP_Scorpion.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
local DeathSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/bugdie_1.bugdie_1'))
--local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle1.DropParticle1_C'))
--UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/bugdie_1.bugdie_1')
local IsRespawn = true
BP_Scorpion.CampID = 0
function BP_Scorpion:ReceiveBeginPlay()
    BP_Scorpion.SuperClass.ReceiveBeginPlay(self)
    ugcprint("BP_Scorpion begin")
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
end

function BP_Scorpion:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 and EventInstigator and EventInstigator.PlayerState then
        local DropSkillEmementClss = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/SkillAoctors/TuYang_DropSkillElementActor1.TuYang_DropSkillElementActor1_C'))


        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        EventInstigator.PlayerState:AddDamageCount(Damage)

        local rate = UGCGameSystem.GameState.DropSkillElementRate
        -- 7.75%概率掉落技能碎片
        if math.random(1, 10000) <= rate then  -- 万分位精度判断
            UGCLog.Log("[maoyu]:BP_Scorpion:OnSelfDeath - SpawnAnything")
            UGCGameSystem.SpawnActor(self,DropSkillEmementClss,self:K2_GetActorLocation())
        end
    end
end

function BP_Scorpion:ReceiveTick(DeltaTime)
    BP_Scorpion.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
        UGCSoundManagerSystem.PlaySoundAttachActor(DeathSound,self,true)
		--local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
	end
end



function BP_Scorpion:ReceiveEndPlay()
    BP_Scorpion.SuperClass.ReceiveEndPlay(self) 

    if self:HasAuthority() and IsRespawn then 

        local location = self:K2_GetActorLocation()
        if location.Z < 0 then
			location.Z = 0
		end

    end
    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID, GameState:GetMonsterNum(self.CampID) - 1)
    end
end

return BP_Scorpion