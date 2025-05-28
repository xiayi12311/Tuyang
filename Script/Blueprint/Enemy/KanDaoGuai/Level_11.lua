---@class Level_11_C:UGC_Dhield_BP_C
---@field Shield UChildActorComponent
--Edit Below--
local Level_11 = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}
--DropItemConfig = require("Script.DropItemConfig")
--UGCDropItemMgr = require("Script.UGCDropItemMgr")
Level_11.gold = 110
Level_11.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
--Level_11.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/KanDaoGuai/Respawn/Shield_Respawn.Shield_Respawn_C'))
--local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle2.DropParticle2_C'))
--'/Game/Arts_Effect/ParticleSystems/Drop/P_Drop_Light_Green.P_Drop_Light_Green'UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle2.DropParticle2_C')
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
local EventSystem =  require('Script.common.UGCEventSystem')
local IsRespawn = true
Level_11.CampID = 0
function Level_11:ReceiveBeginPlay()
    Level_11.SuperClass.ReceiveBeginPlay(self)
    self.Shield:K2_AttachToComponent(
        self.Mesh,"item_l")
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

function Level_11:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        ugcprint("砍刀怪怪物血量"..self.Health)
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end

function Level_11:ReceiveTick(DeltaTime)
    Level_11.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end

function Level_11:ReceiveEndPlay()
    Level_11.SuperClass.ReceiveEndPlay(self) 
  --  local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
    if self:HasAuthority() and IsRespawn then 
		-- local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        -- local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 2)

        -- local location = self:K2_GetActorLocation()
        -- if location.Z < 0 then
		-- 	location.Z = 0
		-- end
       -- UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)

       
    end 
    
    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID, GameState:GetMonsterNum(self.CampID) - 1)
    end

end



--[[
function Level_11:GetReplicatedProperties()
    return
end
--]]

--[[
function Level_11:GetAvailableServerRPCs()
    return
end
--]]
function Level_11:ReceiveEnd()
	IsRespawn =false
	self:K2_DestroyActor()
end
return Level_11