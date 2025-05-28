---@class Tesla_2_1_C:STExtraSimpleCharacter
---@field Taskiconred UParticleSystemComponent
---@field P_Team_Season UParticleSystemComponent
---@field Capsule UCapsuleComponent
---@field UAEMonsterAnimList UUAEMonsterAnimListComponent
---@field UAESkillManager UUAESkillManagerComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local Tesla_2 = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}
--Tesla_2.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_2/Respawn/Tesla_2_Respawn.Tesla_2_Respawn_C'))
local EventSystem =  require('Script.common.UGCEventSystem')
DropItemConfig = require("Script.DropItemConfig")
UGCDropItemMgr = require("Script.UGCDropItemMgr")
Tesla_2.gold = 200
Tesla_2.HasPlay = false
local IsRespawn = true
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
    local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle2.DropParticle2_C'))
    local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
    local EventSystem =  require('Script.common.UGCEventSystem')
function Tesla_2:ReceiveBeginPlay()
    Tesla_2.SuperClass.ReceiveBeginPlay(self)
    self.StaticMesh:K2_AttachToComponent(
		self.Mesh,"item_r")
    self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
    ugcprint("SPawn Enter particle!")
	local EnterParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/P_Team_Season.P_Team_Season'))
	STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,EnterParticle,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
    local Gamestate = UGCGameSystem.GetGameState()
    local Region =Gamestate:GetRegion()
    local Location = self:K2_GetActorLocation().X
    local RegionCount =Gamestate:GetRegionCount()
    for i =2 ,RegionCount do
   
        if  Location >= Region[i] and Location <= Region[i-1] then
            local j =i+1
            local text = ("Spawn" ..j)
        ugcprint(text)
        EventSystem:AddListener(text,self.ReceiveEnd,self)
    end
end
end

function Tesla_2:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
       
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end



function Tesla_2:ReceiveTick(DeltaTime)
    Tesla_2.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play montage")
		self.HasPlay = true;
		-- self.Mesh:PlayAnimation(self.MontageDeath2,false);
		local SkillManager = self:GetSkillManagerComponent()
		if SkillManager ~= nil then
			--释放120号技能
			SkillManager:TriggerEvent(1, UTSkillEventType.SET_KEY_DOWN)
		end
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
      --  local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
    end
end


function Tesla_2:ReceiveEndPlay()
    Tesla_2.SuperClass.ReceiveEndPlay(self) 
    local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
    if self:HasAuthority() and IsRespawn then 
		--local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 2)

        local location = self:K2_GetActorLocation()
        if location.Z<0 then
			location.Z = 0
		end
        UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
    end

end


--[[
function Tesla:GetReplicatedProperties()
    return
end
--]]

--[[
function Tesla:GetAvailableServerRPCs()
    return
end
--]]
function Tesla_2:ReceiveEnd()
    IsRespawn =false
	--UGCGameSystem.ApplyDamage(self,1000)
end
return Tesla_2