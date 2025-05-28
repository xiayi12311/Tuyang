---@class Boss_Level_1_C:UGC_Snipe_BP_C
---@field Taskiconred UParticleSystemComponent
---@field ParticleSystem UParticleSystemComponent
---@field Scene USceneComponent
--Edit Below--
local Boss_Level_1 = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}
local axis ={1 ,2,4}
--DropItemConfig = require("Script.DropItemConfig")
--UGCDropItemMgr = require("Script.UGCDropItemMgr")
Boss_Level_1.gold = 200
--00SNIPER.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Boss_Level_1/Respawn/Sniper_Respawn.Sniper_Respawn_C'))
Boss_Level_1.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))

local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/bluedrop.bluedrop')
    )
    --UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/greendrop.greendrop')
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
--local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle4.DropParticle4_C')

function Boss_Level_1:ReceiveBeginPlay()
    Boss_Level_1.SuperClass.ReceiveBeginPlay(self)
    local gamestate = UGCGameSystem.GetGameState()
    local difficulty = gamestate:GetDifficulty()
    -- self.MH = 10000 * axis[difficulty] --math.pow好像用不了
    local MH = 575 * axis[difficulty]
    UGCSimpleCharacterSystem.SetHealthMax(self,MH)
    UGCSimpleCharacterSystem.SetHealth(self,MH)
    self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)

     
    self.Scene:K2_AttachToComponent(self.Mesh,"neck_01")



end

function Boss_Level_1:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end

function Boss_Level_1:ReceiveEndPlay()
    Boss_Level_1.SuperClass.ReceiveEndPlay(self)
   -- local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1}); 
    if self:HasAuthority() then 
		--local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
      --  local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 4)

        local location = self:K2_GetActorLocation()
        if location.Z < 0 then
			location.Z = 0
		end
      --  UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
    end

end

--[[
function Boss_Level_1:ReceiveBeginPlay()
    Boss_Level_1.SuperClass.ReceiveBeginPlay(self)
end
--]]


function Boss_Level_1:ReceiveTick(DeltaTime)
    Boss_Level_1.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        --STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        -- local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end


--[[
function Boss_Level_1:ReceiveEndPlay()
    Boss_Level_1.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Boss_Level_1:GetReplicatedProperties()
    return
end
--]]

--[[
function Boss_Level_1:GetAvailableServerRPCs()
    return
end
--]]

return Boss_Level_1