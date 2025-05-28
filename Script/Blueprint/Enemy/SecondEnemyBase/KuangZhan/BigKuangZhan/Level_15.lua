---@class Level_15_C:BP_YXMonsterBase_C
---@field Vault_Controller Vault_Controller_C
---@field BP_VaultComponent BP_VaultComponent_C
---@field MonsterAnimList_Zombie_Beserker MonsterAnimList_Zombie_Beserker_C
---@field UAESkillManager UUAESkillManagerComponent
---@field BP_PathInterpSync BP_PathInterpSync_C
--Edit Below--
local Level_15 = {}

Level_15.gold = 110
Level_15.HasPlay = false

local ParticleSystem = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
Level_15.CampID = 0
function Level_15:ReceiveBeginPlay()
    Level_15.SuperClass.ReceiveBeginPlay(self)
    self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
end

function Level_15:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 and EventInstigator and EventInstigator.PlayerState then
        local DropSkillEmementClss = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/SkillAoctors/TuYang_DropSkillElementActor1.TuYang_DropSkillElementActor1_C'))

        
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        EventInstigator.PlayerState:AddDamageCount(Damage)

        local rate = UGCGameSystem.GameState.DropSkillElementRate
        -- 7.75%概率掉落技能碎片
        if math.random(1, 10000) <= rate then  -- 万分位精度判断
            UGCLog.Log("[maoyu]:Level_15:OnSelfDeath - SpawnAnything")
            UGCGameSystem.SpawnActor(self,DropSkillEmementClss,self:K2_GetActorLocation())
        end
    end
end

function Level_15:ReceiveEndPlay()
    Level_15.SuperClass.ReceiveEndPlay(self) 

    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID, GameState:GetMonsterNum(self.CampID) - 1)
    end

end



function Level_15:ReceiveTick(DeltaTime)
    Level_15.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        local SkillManager = self:GetSkillManagerComponent()
		if SkillManager ~= nil then
			--释放120号技能
			SkillManager:TriggerEvent(2, UTSkillEventType.SET_KEY_DOWN)
		end
        local Location = self:K2_GetActorLocation()
        Location.Z = Location.Z+50
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,Location,self:K2_GetActorRotation(),true);
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
        
	end
end

--[[
function Level_15:GetReplicatedProperties()
    return
end
--]]

--[[
function Level_15:GetAvailableServerRPCs()
    return
end
--]]

return Level_15