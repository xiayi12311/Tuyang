---@class Jstk_C:BP_JSTK_Character_C
---@field Taskiconred UParticleSystemComponent
---@field Shield UChildActorComponent
---@field ParticleSystem UParticleSystemComponent
--Edit Below--
local Boss_Level_4 = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}
local EventSystem = require("Script.Common.UGCEventSystem")
--DropItemConfig = require("Script.DropItemConfig")
--UGCDropItemMgr = require("Script.UGCDropItemMgr")
--Boss_Level_4.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/elite/JSTKrespawn.JSTKrespawn_C'))
--UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/elite/JSTKrespawn.JSTKrespawn_C')
local axis ={1 ,2,4}
Boss_Level_4.gold = 1000
Boss_Level_4.MonsterDiedAddHotNum = 10
Boss_Level_4.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
--local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle4.DropParticle4_C'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
function Boss_Level_4:ReceiveBeginPlay()
    Boss_Level_4.SuperClass.ReceiveBeginPlay(self)
     self.Shield:K2_AttachToComponent(
	 	self.Mesh,"item_l")
    local gamestate = UGCGameSystem.GetGameState()
    local difficulty = gamestate:GetDifficulty()
    -- self.MH = 10000 * axis[difficulty] --math.pow好像用不了
    local MH = 4500 * axis[difficulty]
    UGCSimpleCharacterSystem.SetHealthMax(self,MH)
    UGCSimpleCharacterSystem.SetHealth(self,MH)
    self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
    ugcprint("砍刀怪开始监听")
end


function Boss_Level_4:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        ugcprint("砍刀怪怪物血量"..self.Health)
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
    end
end




function Boss_Level_4:ReceiveTick(DeltaTime)
    Boss_Level_4.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
       -- local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end



function Boss_Level_4:ReceiveEndPlay()
    Boss_Level_4.SuperClass.ReceiveEndPlay(self)
    --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
    if self:HasAuthority() then 
		---local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
       -- local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 4)

        local location = self:K2_GetActorLocation()
        if location.Z < 0 then
			location.Z = 0
		end
     --   UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
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


return Boss_Level_4