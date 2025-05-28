---@class Level_4_C:UGC_Machete_BP_C
--Edit Below--
local Level_4 = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}
local IsElimated = false
local EventSystem = require("Script.Common.UGCEventSystem")
--DropItemConfig = require("Script.DropItemConfig")
--UGCDropItemMgr = require("Script.UGCDropItemMgr")
--Level_4.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/KanDaoGuai/Respawn/KanDao_Respawn.KanDao_Respawn_C'))
Level_4.gold = 100
Level_4.MonsterDiedAddHotNum = 10
Level_4.HasPlay = false
local IsRespawn = true
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
--local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle1.DropParticle1_C'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))

Level_4.CampID = 0
function Level_4:ReceiveBeginPlay()
    Level_4.SuperClass.ReceiveBeginPlay(self)
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
ugcprint("Level_4:ReceiveBeginPlay"..self.CampID)
    ugcprint("砍刀怪开始监听")
end

function Level_4:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 and EventInstigator and EventInstigator.PlayerState then
        local DropSkillEmementClss = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/SkillAoctors/TuYang_DropSkillElementActor1.TuYang_DropSkillElementActor1_C'))

        
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        EventInstigator.PlayerState:AddDamageCount(Damage)

        local rate = UGCGameSystem.GameState.DropSkillElementRate
        -- 7.75%概率掉落技能碎片
        if math.random(1, 10000) <= rate then  -- 万分位精度判断
            UGCLog.Log("[maoyu]:Level_4:OnSelfDeath - SpawnAnything")
            UGCGameSystem.SpawnActor(self,DropSkillEmementClss,self:K2_GetActorLocation())
        end
    end
end

function Level_4:ReceiveTick(DeltaTime)
    Level_4.SuperClass.ReceiveTick(self, DeltaTime)
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

function Level_4:ReceiveEndPlay()
    Level_4.SuperClass.ReceiveEndPlay(self)
    
    print("TuYangMonsterBase:ReceiveEndPlay"..self.CampID)
    
    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID, GameState:GetMonsterNum(self.CampID) - 1)
    end
end

function Level_4:OnSelfDeath(BP_Summon, KillerController, DamageCauseActor, HitResult, HitImpulseDirection, DamageTypeID, bHeadShotDamage)
    
end


--[[
function Level_4:GetReplicatedProperties()
    return
end
--]]

--[[
function Level_4:GetAvailableServerRPCs()
    return
end
--]]
function Level_4:ReceiveEnd()
    --ugcprint("kdg Received ENd")
    IsRespawn = false
    --IsElimated = true
   -- UGCGameSystem.ApplyDamage(self,1000)
	--self:K2_DestroyActor() --客户端会崩溃
end
return Level_4