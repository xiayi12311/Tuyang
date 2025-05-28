---@class Zombie_C:STExtraSimpleCharacter
---@field Sphere USphereComponent
---@field UAESkillManager UUAESkillManagerComponent
---@field UAEMonsterAnimListComponentBase UUAEMonsterAnimListComponentBase
--Edit Below--
local Scorpion = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
local EventSystem =  require('Script.common.UGCEventSystem')
DropItemConfig = require("Script.DropItemConfig")
UGCDropItemMgr = require("Script.UGCDropItemMgr")
Scorpion.gold = 30 
Scorpion.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Scorpion/Respawn/Scorpion_Respawn.Scorpion_Respawn_C'))
Scorpion.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
local DeathSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/bugdie_1.bugdie_1'))
local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle1.DropParticle1_C'))
--UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/bugdie_1.bugdie_1')
local IsRespawn = true
function Scorpion:ReceiveBeginPlay()
    Scorpion.SuperClass.ReceiveBeginPlay(self)
    ugcprint("Scorpion begin")
    self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
    local Gamestate = UGCGameSystem.GetGameState() 
    local Region =Gamestate:GetRegion()
	local RegionCount =Gamestate:GetRegionCount()
	-- local RegionCount =self.LoadMonster:GetRegionCount()
    -- local Region =self.LoadMonster:GetRegion()
    local Location = self:K2_GetActorLocation().X
    
    for i =2 ,RegionCount do
   
		if  Location >= Region[i] and Location <= Region[i-1] then
            local j =i+1
			local text = ("Spawn" ..j)
        ugcprint(text)
        EventSystem:AddListener(text,self.ReceiveEnd,self)
    end
end
end

function Scorpion:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end

function Scorpion:ReceiveTick(DeltaTime)
    Scorpion.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
        UGCSoundManagerSystem.PlaySoundAttachActor(DeathSound,self,true)
		--local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
	end
end



function Scorpion:ReceiveEndPlay()
    Scorpion.SuperClass.ReceiveEndPlay(self) 
    local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
    if self:HasAuthority() and IsRespawn then 
		local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        
        local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 2)

        local location = self:K2_GetActorLocation()
        if location.Z < 0 then
			location.Z = 0
		end
        UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
        local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
    end
end


--[[
function Scorpion:GetReplicatedProperties()
    return
end
--]]

--[[
function Scorpion:GetAvailableServerRPCs()
    return
end
--]]
function Scorpion:ReceiveEnd()
    IsRespawn =false
    --UGCGameSystem.ApplyDamage(self,1000)
	--self:K2_DestroyActor()
end
return Scorpion