---@class Level_10_C:UGC_Snipe_BP_C
--Edit Below--
local Level_10 = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}

--DropItemConfig = require("Script.DropItemConfig")
--UGCDropItemMgr = require("Script.UGCDropItemMgr")
Level_10.gold = 105
--Level_10.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Level_10/Respawn/Sniper_Respawn.Sniper_Respawn_C'))
Level_10.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))

local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/bluedrop.bluedrop'))
    --UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/greendrop.greendrop')
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
--local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle2.DropParticle2_C'))
local EventSystem =  require('Script.common.UGCEventSystem')
local IsRespawn = true

function Level_10:ReceiveBeginPlay()
    Level_10.SuperClass.ReceiveBeginPlay(self)
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

function Level_10:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end

function Level_10:ReceiveEndPlay()
    Level_10.SuperClass.ReceiveEndPlay(self) 
    --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
    if self:HasAuthority()  and IsRespawn then 
		--local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
      --  local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 3)

        local location = self:K2_GetActorLocation()
        if location.Z < 0 then
			location.Z = 0
		end
      --  UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
    end
    if self:HasAuthority() then
        local GameState = UGCGameSystem.GetGameState()
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID,GameState:GetMonsterNum(self.CampID) - 1)
    end
end

--[[
function Level_10:ReceiveBeginPlay()
    Level_10.SuperClass.ReceiveBeginPlay(self)
end
--]]


function Level_10:ReceiveTick(DeltaTime)
    Level_10.SuperClass.ReceiveTick(self, DeltaTime)
    if IsRespawn ==false then
        --self:K2_DestroyActor()
    end
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end
function Level_10:ReceiveEnd()
    --if self:HasAuthority() then
    if self then
        ugcprint("Level_10 ReceiveENd!")
	IsRespawn =false
    --UGCGameSystem.ApplyDamage(self,1000)
	--self:K2_DestroyActor()
    end
--end
end

return Level_10