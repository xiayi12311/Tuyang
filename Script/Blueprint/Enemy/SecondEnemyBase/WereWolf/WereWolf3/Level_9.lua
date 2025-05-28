---@class Level_9_C:BP_YXMonsterBase_C
---@field UAESkillManager UUAESkillManagerComponent
---@field UAEMonsterAnimList_Base UAEMonsterAnimList_Base_C
--Edit Below--
local Level_9 = {}
 
Level_9.gold = 105

Level_9.HasPlay = false

local ParticleSystem = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle2.DropParticle2_C'))

Level_9.CampID = 0

function Level_9:ReceiveBeginPlay()
    Level_9.SuperClass.ReceiveBeginPlay(self)
    self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
end

function Level_9:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
       
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end

function Level_9:ReceiveEndPlay()
    Level_9.SuperClass.ReceiveEndPlay(self) 
    if self:HasAuthority() then 
        local GameState = GameplayStatics.GetGameState(self)
        if self:HasAuthority() then
            if self.Health <= 0 then
                GameState:SetKillNum(self.CampID)
            end
            GameState:SetMonsterNum(self.CampID,GameState:GetMonsterNum(self.CampID) - 1)
        end
    end
end
 
--[[
function Level_9:ReceiveBeginPlay()
    Level_9.SuperClass.ReceiveBeginPlay(self)
end
--]]

function Level_9:ReceiveTick(DeltaTime)
    Level_9.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end

--[[
function Level_9:GetReplicatedProperties()
    return
end
--]]

--[[
function Level_9:GetAvailableServerRPCs()
    return
end
--]]

return Level_9