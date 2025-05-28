---@class Insect1_C:STExtraSimpleCharacter
---@field UAESkillManager UUAESkillManagerComponent
---@field Sphere2 USphereComponent
---@field StaticMesh3 UStaticMeshComponent
---@field Sphere1 USphereComponent
---@field StaticMesh2 UStaticMeshComponent
---@field Sphere USphereComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local Insect1 = {}
Insect1.gold = 10
Insect1.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Insect/effect/P_Repository_EFX_Bullet_Hit_Skill07.P_Repository_EFX_Bullet_Hit_Skill07'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
local DeathSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/bugdie3d_1.bugdie3d_1'))

function Insect1:ReceiveBeginPlay()
    Insect1.SuperClass.ReceiveBeginPlay(self)
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)

    self.VerticalBox_47 = self:GetWidgetFromName("VerticalBox_47")
 
end



function Insect1:ReceiveTick(DeltaTime)
    Insect1.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
        UGCSoundManagerSystem.PlaySoundAttachActor(DeathSound,self,true)
	end
end



function Insect1:ReceiveEndPlay()
    Insect1.SuperClass.ReceiveEndPlay(self) 


end


--[[
function Insect:GetReplicatedProperties()
    return
end
--]]

--[[
function Insect:GetAvailableServerRPCs()
    return
end
--]]

function Insect1:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
   ugcprint("insect ON take Damage")
    if self.Health <= 0 then
        ugcprint("Insect Die")
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        
       --GameState.
        
        --STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end
return Insect1