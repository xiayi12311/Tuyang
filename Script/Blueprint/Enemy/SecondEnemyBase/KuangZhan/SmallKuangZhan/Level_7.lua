---@class Level_7_C:BP_YXMonsterBase_C
---@field Vault_Controller Vault_Controller_C
---@field TurnAroundView UTurnAroundViewComponent
---@field BP_PathInterpSync BP_PathInterpSync_C
---@field UAESkillManager UUAESkillManagerComponent
---@field MonsterAnimList_Zombie_Beserker MonsterAnimList_Zombie_Beserker_C
---@field BP_VaultComponent BP_VaultComponent_C
---@field PVEProjectileMovement UPVEProjectileMovementComponent
--Edit Below--
local Level_7 = {}

Level_7.gold = 105

Level_7.HasPlay = false

local ParticleSystem = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
  --  local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle2.DropParticle2_C'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))

Level_7.CampID = 0

function Level_7:ReceiveBeginPlay()
    Level_7.SuperClass.ReceiveBeginPlay(self)
    self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
end

function Level_7:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end

function Level_7:ReceiveEndPlay()
    Level_7.SuperClass.ReceiveEndPlay(self) 
    local Location = self:K2_GetActorLocation()
    Location.Z = Location.Z+50

    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID, GameState:GetMonsterNum(self.CampID) - 1)
    end
end



function Level_7:ReceiveTick(DeltaTime)
    Level_7.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        local SkillManager = self:GetSkillManagerComponent()
		if SkillManager ~= nil then
			--释放120号技能
			SkillManager:TriggerEvent(2, UTSkillEventType.SET_KEY_DOWN)
		end
       STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end


--[[
function Level_7:GetReplicatedProperties()
    return
end
--]]

--[[
function Level_7:GetAvailableServerRPCs()
    return
end
--]]

return Level_7