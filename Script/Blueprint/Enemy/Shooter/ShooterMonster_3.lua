---@class ShooterMonster_2_C:UGC_Pistol_BP_C
---@field Taskiconred UParticleSystemComponent
--Edit Below--
local shooter = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}

DropItemConfig = require("Script.DropItemConfig")
UGCDropItemMgr = require("Script.UGCDropItemMgr")
shooter.gold = 50
shooter.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/BulletHit_Impact_Glass.BulletHit_Impact_Glass'))
--shooter.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Shooter/Respawn/Shooter_Respawn.Shooter_Respawn_C'))
function shooter:ReceiveBeginPlay()
    shooter.SuperClass.ReceiveBeginPlay(self)
    self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
end

function shooter:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    ugcprint("shooter怪物血量"..self.Health)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end

--[[
function shooter:ReceiveBeginPlay()
    shooter.SuperClass.ReceiveBeginPlay(self)
end
--]]


function shooter:ReceiveTick(DeltaTime)
    shooter.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end



function shooter:ReceiveEndPlay()
    shooter.SuperClass.ReceiveEndPlay(self) 
    local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
    if self:HasAuthority() then 
		--local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 4)

        local location = self:K2_GetActorLocation()
        if location.Z < 0 then
			location.Z = 0
		end
        UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
    end
    -- if not self:HasAuthority() then
    --     return
    -- end

    -- local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 4)

    -- UGCDropItemMgr.SpawnItems(ItemList, self:K2_GetActorLocation(), self:K2_GetActorRotation(), 0)
end


--[[
function shooter:GetReplicatedProperties()
    return
end
--]]

--[[
function shooter:GetAvailableServerRPCs()
    return
end
--]]

return shooter