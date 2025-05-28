---@class Dogmonster_C:BPPawn_Zombie_Dog_C
--Edit Below--
local Dogmonster = {}
Dogmonster.gold =40


local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Insect/effect/P_Repository_EFX_Bullet_Hit_Skill07.P_Repository_EFX_Bullet_Hit_Skill07'))
 local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
 local DeathSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/bugdie3d_1.bugdie3d_1'))
 --local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle1.DropParticle1_C'))
Dogmonster.CampID = 0

function Dogmonster:ReceiveBeginPlay()
    Dogmonster.SuperClass.ReceiveBeginPlay(self)
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
end


--[[
function Dogmonster:ReceiveTick(DeltaTime)
    Dogmonster.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function Dogmonster:ReceiveEndPlay()
    Dogmonster.SuperClass.ReceiveEndPlay(self) 
    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID, GameState:GetMonsterNum(self.CampID) - 1)
    end
end

function Dogmonster:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        EventInstigator.PlayerState:AddDamageCount(Damage)
        
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
        UGCSoundManagerSystem.PlaySoundAttachActor(DeathSound,self,true)
    end
end
--[[
function Dogmonster:GetReplicatedProperties()
    return
end
--]]

--[[
function Dogmonster:GetAvailableServerRPCs()
    return
end
--]]

return Dogmonster