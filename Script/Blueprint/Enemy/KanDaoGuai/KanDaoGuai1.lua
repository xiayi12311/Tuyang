---@class KanDaoGuai1_C:UGC_Machete_BP_C
--Edit Below--
local kandaoguai = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}
local IsElimated = false
local EventSystem = require("Script.Common.UGCEventSystem")
--DropItemConfig = require("Script.DropItemConfig")
--UGCDropItemMgr = require("Script.UGCDropItemMgr")
--kandaoguai.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/KanDaoGuai/Respawn/KanDao_Respawn.KanDao_Respawn_C'))
kandaoguai.gold = 120
kandaoguai.MonsterDiedAddHotNum = 10
kandaoguai.HasPlay = false
local IsRespawn = true
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
--local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle1.DropParticle1_C'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))

kandaoguai.CampID = 0
function kandaoguai:ReceiveBeginPlay()
    kandaoguai.SuperClass.ReceiveBeginPlay(self)
    self.OnDeath:AddInstance(self.OnSelfDeath, self)

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
ugcprint("kandaoguai:ReceiveBeginPlay"..self.CampID)
    ugcprint("砍刀怪开始监听")
end

function kandaoguai:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        ugcprint("砍刀怪怪物血量"..self.Health)
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        
    end
    EventInstigator.PlayerState:AddDamageCount(Damage)
end

function kandaoguai:ReceiveTick(DeltaTime)
    kandaoguai.SuperClass.ReceiveTick(self, DeltaTime)
    -- if IsElimated  ==true then 
    --     IsElimated  =false
    --     self:K2_DestroyActor()
    -- end
    -- if IsRespawn ==false then
    --     self:K2_DestroyActor()
    -- end
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
	end
end

function kandaoguai:ReceiveEndPlay()
    kandaoguai.SuperClass.ReceiveEndPlay(self)
    
    ugcprint("SPawn Drop!")
    --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
    if self:HasAuthority() and IsRespawn then 
	--	local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        --local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 1)

        local location = self:K2_GetActorLocation()
        if location.Z < 0 then
			location.Z = 0
		end
        --UGCDropItemMgr.SpawnItems(ItemList, location, self:K2_GetActorRotation(), 0)
    --else
        
        
    end 
    print("TuYangMonsterBase:ReceiveEndPlay"..self.CampID)
    
    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID, GameState:GetMonsterNum(self.CampID) - 1)
    end
end

function kandaoguai:OnSelfDeath(BP_Summon, KillerController, DamageCauseActor, HitResult, HitImpulseDirection, DamageTypeID, bHeadShotDamage)
    
end


--[[
function kandaoguai:GetReplicatedProperties()
    return
end
--]]

--[[
function kandaoguai:GetAvailableServerRPCs()
    return
end
--]]
function kandaoguai:ReceiveEnd()
    --ugcprint("kdg Received ENd")
    IsRespawn = false
    --IsElimated = true
   -- UGCGameSystem.ApplyDamage(self,1000)
	--self:K2_DestroyActor() --客户端会崩溃
end
return kandaoguai