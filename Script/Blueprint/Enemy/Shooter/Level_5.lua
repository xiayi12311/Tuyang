---@class Level_5_C:UGC_Pistol_BP_C
--Edit Below--
local Level_5 = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
local EventSystem =  require('Script.common.UGCEventSystem')
--DropItemConfig = require("Script.DropItemConfig")
--UGCDropItemMgr = require("Script.UGCDropItemMgr")
Level_5.gold = 100
--Level_5.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Level_5/Respawn/ShooterMonster_Respawn.ShooterMonster_Respawn_C'))
Level_5.HasPlay = false
Level_5.CampID = 0
local IsRespawn = true
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
    --UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/greendrop.greendrop')
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
--local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle1.DropParticle1_C'))

function Level_5:ReceiveBeginPlay()
    Level_5.SuperClass.ReceiveBeginPlay(self)
--     self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
--     local Gamestate = UGCGameSystem.GetGameState() 
--     local Region =Gamestate:GetRegion()
-- 	local RegionCount =Gamestate:GetRegionCount()
-- 	-- local RegionCount =self.LoadMonster:GetRegionCount()
--     -- local Region =self.LoadMonster:GetRegion()
--     local Location = self:K2_GetActorLocation().X
    
--     for i =2 ,RegionCount do
   
-- 		if  Location >= Region[i] and Location <= Region[i-1] then
--             local j =i+1
--         local text = ("Spawn" ..j)
--         ugcprint(text)
--         EventSystem:AddListener(text,self.ReceiveEnd,self)
--     end
-- end
end

function Level_5:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    ugcprint("Level_5怪物血量"..self.Health)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end

--[[
function Level_5:ReceiveBeginPlay()
    Level_5.SuperClass.ReceiveBeginPlay(self)
end
--]]


function Level_5:ReceiveTick(DeltaTime)
    Level_5.SuperClass.ReceiveTick(self, DeltaTime)
    if IsRespawn ==false then
        self:K2_DestroyActor()
    end
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
       -- local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end



function Level_5:ReceiveEndPlay()
    Level_5.SuperClass.ReceiveEndPlay(self) 
   -- local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
     if self:HasAuthority() and IsRespawn then 
	 	--local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
         --local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 1)

         local location = self:K2_GetActorLocation()
         if location.Z < 0 then
			location.Z = 0
	 	end
         --UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
     end

    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID, GameState:GetMonsterNum(self.CampID) - 1)
    end
    if not self:HasAuthority() then
         return
     end

end


--[[
function Level_5:GetReplicatedProperties()
    return
end
--]]

--[[
function Level_5:GetAvailableServerRPCs()
    return
end
--]]
function Level_5:ReceiveEnd()
    if self then
    ugcprint("Received! Level_5")
    IsRespawn =false
    --UGCGameSystem.ApplyDamage(self,1000)
	--self:K2_DestroyActor()
    end
end
return Level_5