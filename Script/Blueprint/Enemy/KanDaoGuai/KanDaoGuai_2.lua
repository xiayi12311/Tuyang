---@class KanDaoGuai_2_C:UGC_Machete_BP_C
---@field ParticleSystem UParticleSystemComponent
--Edit Below--
local kandaoguai = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}
local EventSystem = require("Script.Common.UGCEventSystem")
DropItemConfig = require("Script.DropItemConfig")
UGCDropItemMgr = require("Script.UGCDropItemMgr")
--kandaoguai.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/KanDaoGuai/Respawn/KanDao_Respawn.KanDao_Respawn_C'))
kandaoguai.gold = 50
kandaoguai.MonsterDiedAddHotNum = 10
kandaoguai.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle1.DropParticle1_C'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
function kandaoguai:ReceiveBeginPlay()
    kandaoguai.SuperClass.ReceiveBeginPlay(self)
    self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
    ugcprint("砍刀怪开始监听")
end


function kandaoguai:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        ugcprint("砍刀怪怪物血量"..self.Health)
        EventSystem:SendEvent("OpenWarm");
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end




function kandaoguai:ReceiveTick(DeltaTime)
    kandaoguai.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end



function kandaoguai:ReceiveEndPlay()
    kandaoguai.SuperClass.ReceiveEndPlay(self)
    ugcprint("OpenWarm Sent")
    local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
    if self:HasAuthority() then 
        
		--local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 1)

        local location = self:K2_GetActorLocation()
        if location.Z < 0 then
			location.Z = 0
		end
        UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
    end 
    -- if not self:HasAuthority() then
    --     return 
    -- end

    -- local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 1)

    -- UGCDropItemMgr.SpawnItems(ItemList, self:K2_GetActorLocation(), self:K2_GetActorRotation(), 0)

end




--[[
function kandaoguai:GetReplicatedProperties()
    return
end
--]]

--[[
function kandaoguai:GetAvailableServerRPCs()
    return
end
--]]

return kandaoguai