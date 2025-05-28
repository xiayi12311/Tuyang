---@class Scientist_C:BPPawn_Zombie_Base_C
---@field MonsterAnimList_Scientist MonsterAnimList_Scientist_C
--Edit Below--
local Scientist = {}
--DropItemConfig = require("Script.DropItemConfig")
--UGCDropItemMgr = require("Script.UGCDropItemMgr")
Scientist.gold = 120

--Scientist.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Scientist/Respawn/Scientist_Respawn.Scientist_Respawn_C'))
Scientist.HasPlay = false
local axis ={1 ,2,4}
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
--local DropParticle = UE.LoadClass(UGCGsameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle3.DropParticle3_C'))
    local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
Scientist.CampID = 0
function Scientist:ReceiveBeginPlay()
    Scientist.SuperClass.ReceiveBeginPlay(self)
    local gamestate = UGCGameSystem.GetGameState()
    local difficulty = gamestate:GetDifficulty()
    -- self.MH = 10000 * axis[difficulty] --math.pow好像用不了
    local MH = 720 * axis[difficulty]
    UGCSimpleCharacterSystem.SetHealthMax(self,MH)
    UGCSimpleCharacterSystem.SetHealth(self,MH)
    self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
end


function Scientist:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
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

function Scientist:ReceiveEndPlay()
    Scientist.SuperClass.ReceiveEndPlay(self) 
    --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
    if self:HasAuthority() then 
		--local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
       -- local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 4)

        local location = self:K2_GetActorLocation()
        if location.Z < 0 then
			location.Z = 0
		end
       -- UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
    end
    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID, GameState:GetMonsterNum(self.CampID) - 1)
    end
end

function Scientist:ReceiveTick(DeltaTime)
    Scientist.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        --STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
       -- local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end


--[[
function Scientist:ReceiveEndPlay()
    Scientist.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Scientist:GetReplicatedProperties()
    return
end
--]]

--[[
function Scientist:GetAvailableServerRPCs()
    return
end
--]]

return Scientist