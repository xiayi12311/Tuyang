---@class WereWolf1_C:BPPawn_Escape_WereWolf1_C
--Edit Below--
local WereWolf1 = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}
--WereWolf1.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/WereWolf/Werewolf1/Respawn/Werewolf1_Respawn.Werewolf1_Respawn_C'))
local EventSystem =  require('Script.common.UGCEventSystem')
--DropItemConfig = require("Script.DropItemConfig")
--UGCDropItemMgr = require("Script.UGCDropItemMgr")
WereWolf1.gold = 100
 
WereWolf1.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
--local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle2.DropParticle2_C'))
    local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
    local IsRespawn = true
WereWolf1.CampID = 0
function WereWolf1:ReceiveBeginPlay()
    WereWolf1.SuperClass.ReceiveBeginPlay(self)
  --  self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
    -- local Gamestate = UGCGameSystem.GetGameState() 
    -- local Region =Gamestate:GetRegion()
	-- local RegionCount =Gamestate:GetRegionCount()
	-- -- local RegionCount =self.LoadMonster:GetRegionCount()
    -- -- local Region =self.LoadMonster:GetRegion()
    -- local Location = self:K2_GetActorLocation().X
    
    -- for i =2 ,RegionCount do
   
	-- 	if  Location >= Region[i] and Location <= Region[i-1] then
    --         local j =i+1
    --         local text = ("Spawn" ..j)
    --     ugcprint(text)
    --     EventSystem:AddListener(text,self.ReceiveEnd,self)
    --     end
    -- end

    -- Timer.InsertTimer(1.5,function()
    --     self.bActorLabelEditable = true
    --     self.ActorLabel = "狼人1"
    -- end,false)

end

function WereWolf1:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount()         
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end




function WereWolf1:ReceiveEndPlay()
    WereWolf1.SuperClass.ReceiveEndPlay(self) 
   -- local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
    if self:HasAuthority()  and IsRespawn  then 
		--local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
      --  local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 2)

        local location = self:K2_GetActorLocation()
        if location.Z < 0 then
			location.Z = 0
		end
      --  UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
    end
    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID,GameState:GetMonsterNum(self.CampID) - 1)
    end
end


function WereWolf1:ReceiveTick(DeltaTime)
    WereWolf1.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
       STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end

--[[
function WereWolf1:GetReplicatedProperties()
    return
end
--]]

--[[
function WereWolf1:GetAvailableServerRPCs()
    return
end
--]]
function WereWolf1:ReceiveEnd()
    IsRespawn = false
	UGCGameSystem.ApplyDamage(self,1000) 
end
return WereWolf1


-- local wolf = {}
-- DropItemConfig = require("Script.DropItemConfig")
-- UGCDropItemMgr = require("Script.UGCDropItemMgr")
-- wolf.gold = 50
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

-- function wolf:ReceiveEndPlay()
--     if not self:HasAuthority() then
--         return
--     end
--     local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 4)
--     UGCDropItemMgr.SpawnItems(ItemList, self:K2_GetActorLocation(), self:K2_GetActorRotation(), 0)
-- end

-- return wolf