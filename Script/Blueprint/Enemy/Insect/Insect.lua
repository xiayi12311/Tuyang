---@class Insect_C:STExtraSimpleCharacter
---@field UAESkillManager UUAESkillManagerComponent
---@field Sphere4 USphereComponent
---@field StaticMesh5 UStaticMeshComponent
---@field Sphere3 USphereComponent
---@field StaticMesh4 UStaticMeshComponent
---@field Sphere2 USphereComponent
---@field StaticMesh3 UStaticMeshComponent
---@field Sphere1 USphereComponent
---@field StaticMesh2 UStaticMeshComponent
---@field Sphere USphereComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local Insect = {
    RespawnLocation ={X=0,Y=0,Z=0}
}
local IsRespawn = true
Insect.HasPlay = false
DropItemConfig = require("Script.DropItemConfig")
UGCDropItemMgr = require("Script.UGCDropItemMgr")
local EventSystem =  require('Script.common.UGCEventSystem')
Insect.gold = 105
--Insect.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Insect/effect/P_Repository_EFX_Bullet_Hit_Skill07.P_Repository_EFX_Bullet_Hit_Skill07'))
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Insect/effect/P_Repository_EFX_Bullet_Hit_Skill07.P_Repository_EFX_Bullet_Hit_Skill07'))
 local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
 local DeathSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/bugdie3d_1.bugdie3d_1'))
 --local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle1.DropParticle1_C'))
Insect.CampID = 0
 function Insect:ReceiveBeginPlay()
    Insect.SuperClass.ReceiveBeginPlay(self)
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



function Insect:ReceiveTick(DeltaTime)
    Insect.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
        UGCSoundManagerSystem.PlaySoundAttachActor(DeathSound,self,true)
        --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
	end
    -- if self:HasAuthority() then 
	-- 	local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
    --     local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 1)

    --     UGCDropItemMgr.SpawnItems(ItemList, self:K2_GetActorLocation(), self:K2_GetActorRotation(), 0)
    -- end
end


function Insect:ReceiveEndPlay()
    Insect.SuperClass.ReceiveEndPlay(self) 
    --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID, GameState:GetMonsterNum(self.CampID) - 1)
    end
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

function Insect:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        EventInstigator.PlayerState:AddDamageCount(Damage)
        
    end
end
function Insect:ReceiveEnd()
    ugcprint("Received! Insect")
    IsRespawn =false

	--UGCGameSystem.ApplyDamage(self,1000)
   
end
-- function Insect:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
--     if self.Health <= 0 then
--         EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
--         
--     end
-- end
return Insect

-- function wolf:ReceiveBeginPlay()
--     kandaoguai.SuperClass.ReceiveBeginPlay(self)
--     self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
--     ugcprint("砍刀怪开始监听")
-- end

-- function wolf:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
--     if self.Health <= 0 then
--         EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
--         
--     end
-- end