---@class BOOMRobot_C:UGC_BallRobot_BP_C
--Edit Below--
local BOOMRobot = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}
--DropItemConfig = require("Script.DropItemConfig")
--UGCDropItemMgr = require("Script.UGCDropItemMgr")
BOOMRobot.gold = 105

--BOOMRobot.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/BOOMRobot/Respawn/BOOMRobot_Respawn.BOOMRobot_Respawn_C'))
BOOMRobot.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
local EventSystem =  require('Script.common.UGCEventSystem')
local IsRespawn = true

BOOMRobot.CampID = 0
function BOOMRobot:ReceiveBeginPlay()
    BOOMRobot.SuperClass.ReceiveBeginPlay(self)
    self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)

    -- local Gamestate = UGCGameSystem.GetGameState() 
    -- local Region =Gamestate:GetRegion()
	-- local RegionCount =Gamestate:GetRegionCount()
	-- -- local RegionCount =self.LoadMonster:GetRegionCount()
    -- -- local Region =self.LoadMonster:GetRegion()
    -- local Location = self:K2_GetActorLocation().X
    
    -- for i =2 ,RegionCount do
   
	-- 	if  Location >= Region[i] and Location <= Region[i-1] then
	-- 		local j =i+1
	-- 		local text = ("Spawn" ..j)
    --     ugcprint(text)
    --     EventSystem:AddListener(text,self.ReceiveEnd,self)
    -- end
-- end

end


function BOOMRobot:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        EventInstigator.PlayerState:AddDamageCount(Damage)
    end
end

function BOOMRobot:ReceiveEndPlay()
    BOOMRobot.SuperClass.ReceiveEndPlay(self) 
    if self:HasAuthority() and IsRespawn  then 
		--local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
       -- local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 2)

        local location = self:K2_GetActorLocation()
        if location.Z < 0 then
			location.Z = 0
		end
      --  UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
    end
    -- if not self:HasAuthority() then
    --     return
    -- end

    -- local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 1)

    -- UGCDropItemMgr.SpawnItems(ItemList, self:K2_GetActorLocation(), self:K2_GetActorRotation(), 0)
    print("TuYangMonsterBase:ReceiveEndPlay"..self.CampID)
    
    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID, GameState:GetMonsterNum(self.CampID) - 1)
    end
end


function BOOMRobot:ReceiveTick(DeltaTime)
    BOOMRobot.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
        local SkillManager = self:GetSkillManagerComponent()
		if SkillManager ~= nil then
			--释放0号技能
			SkillManager:TriggerEvent(0, UTSkillEventType.SET_KEY_DOWN)
		end
		self.HasPlay = true;
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end


--[[
function BOOMRobot:ReceiveEndPlay()
    BOOMRobot.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BOOMRobot:GetReplicatedProperties()
    return
end
--]]

--[[
function BOOMRobot:GetAvailableServerRPCs()
    return
end
--]]
function BOOMRobot:ReceiveEnd()
	IsRespawn =false
	--UGCGameSystem.ApplyDamage(self,1000)
end
return BOOMRobot