---@class WereWolf4_C:BPPawn_Escape_WereWolf_Venom_C
--Edit Below--
local WereWolf3 = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}
WereWolf3.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/WereWolf/Werewolf3/Respawn/Werewolf3_Respawn.Werewolf3_Respawn_C'))

DropItemConfig = require("Script.DropItemConfig")
UGCDropItemMgr = require("Script.UGCDropItemMgr")
WereWolf3.gold = 50
 
WereWolf3.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
    local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
function WereWolf3:ReceiveBeginPlay()
    WereWolf3.SuperClass.ReceiveBeginPlay(self)
    self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
end

function WereWolf3:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end




function WereWolf3:ReceiveEndPlay()
    WereWolf3.SuperClass.ReceiveEndPlay(self) 
    if self:HasAuthority() then 
		local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 2)

        local location = self:K2_GetActorLocation()
        if location.Z < 0 then
			location.Z = 0
		end
        UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
    end
end
 
--[[
function WereWolf3:ReceiveBeginPlay()
    WereWolf3.SuperClass.ReceiveBeginPlay(self)
end
--]]

function WereWolf3:ReceiveTick(DeltaTime)
    WereWolf3.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end
--[[
function WereWolf3:ReceiveEndPlay()
    WereWolf3.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function WereWolf3:GetReplicatedProperties()
    return
end
--]]

--[[
function WereWolf3:GetAvailableServerRPCs()
    return
end
--]]

return WereWolf3