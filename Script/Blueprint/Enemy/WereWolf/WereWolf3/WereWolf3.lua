---@class WereWolf3_C:BPPawn_Escape_WereWolf_Venom_C
--Edit Below--
local WereWolf3 = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}
--WereWolf3.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/WereWolf/Werewolf3/Respawn/Werewolf3_Respawn.Werewolf3_Respawn_C'))
local IsRespawn = true
--DropItemConfig = require("Script.DropItemConfig")
--UGCDropItemMgr = require("Script.UGCDropItemMgr")
WereWolf3.gold = 105
local EventSystem =  require('Script.common.UGCEventSystem')
WereWolf3.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
    local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
    local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle2.DropParticle2_C'))
WereWolf3.CampID = 0
function WereWolf3:ReceiveBeginPlay()
    WereWolf3.SuperClass.ReceiveBeginPlay(self)
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

function WereWolf3:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
       
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end

function WereWolf3:ReceiveEndPlay()
    WereWolf3.SuperClass.ReceiveEndPlay(self) 
    if self:HasAuthority() and IsRespawn then 
		--local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
      --  local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 2)

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
        GameState:SetMonsterNum(self.CampID,GameState:GetMonsterNum(self.CampID) - 1)
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
        --STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
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
function WereWolf3:ReceiveEnd()
    IsRespawn = false
	--UGCGameSystem.ApplyDamage(self,1000) 
end
return WereWolf3