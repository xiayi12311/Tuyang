---@class WereWolf2_2_C:BPPawn_Escape_WereWolf_Tank_C
--Edit Below--
local WereWolf2 = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}
WereWolf2.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/WereWolf/Werewolf2/Respawn/Werewolf2_Respawn.Werewolf2_Respawn_C'))

DropItemConfig = require("Script.DropItemConfig")
UGCDropItemMgr = require("Script.UGCDropItemMgr")
WereWolf2.gold = 50
 
WereWolf2.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
    local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
function WereWolf2:ReceiveBeginPlay()
    WereWolf2.SuperClass.ReceiveBeginPlay(self)
    self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
end

function WereWolf2:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end




function WereWolf2:ReceiveEndPlay()
    WereWolf2.SuperClass.ReceiveEndPlay(self) 
    if self:HasAuthority() then 
		local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 3)

        local location = self:K2_GetActorLocation()
        if location.Z < 0 then
			location.Z = 0
		end
        UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
    end
end
--]]
function WereWolf2:ReceiveTick(DeltaTime)
    WereWolf2.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end
--[[
function WereWolf2:GetReplicatedProperties()
    return
end
--]]

--[[
function WereWolf2:GetAvailableServerRPCs()
    return
end
--]]

return WereWolf2