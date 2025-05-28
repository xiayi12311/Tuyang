---@class KuangZhan_C:BPPawn_Zombie_Beserker_C
--Edit Below--
local KuangZhan = 
{
    RespawnLocation ={X=0,Y=0,Z=0}
}

DropItemConfig = require("Script.DropItemConfig")
UGCDropItemMgr = require("Script.UGCDropItemMgr")
KuangZhan.gold = 110
--KuangZhan.RespwanClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/KuangZhan/Respawn/KuangZhan_Respawn.KuangZhan_Respawn_C'))
KuangZhan.HasPlay = false
local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
    --local DropParticle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Particle/DropParticle3.DropParticle3_C'))
    local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))
KuangZhan.CampID = 0
function KuangZhan:ReceiveBeginPlay()
    KuangZhan.SuperClass.ReceiveBeginPlay(self)
    self.RespawnLocation = self:K2_GetActorLocation()
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
end

function KuangZhan:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 and EventInstigator and EventInstigator.PlayerState then
        local DropSkillEmementClss = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/SkillAoctors/TuYang_DropSkillElementActor1.TuYang_DropSkillElementActor1_C'))

        
        EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
        EventInstigator.PlayerState:AddEnemyCount() 
        EventInstigator.PlayerState:AddDamageCount(Damage)

        local rate = UGCGameSystem.GameState.DropSkillElementRate
        -- 7.75%概率掉落技能碎片
        if math.random(1, 10000) <= rate then  -- 万分位精度判断
            UGCLog.Log("[maoyu]:KuangZhan:OnSelfDeath - SpawnAnything")
            UGCGameSystem.SpawnActor(self,DropSkillEmementClss,self:K2_GetActorLocation())
        end
    end
end

function KuangZhan:ReceiveEndPlay()
    KuangZhan.SuperClass.ReceiveEndPlay(self) 
    --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 50});
    if self:HasAuthority() then 
		--local BP_Respawn = ScriptGameplayStatics.SpawnActor(self,self.RespwanClass,self.RespawnLocation,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
       -- local ItemList = DropItemConfig.GetDropItems(DropItemConfig.ItemKey.Monster, 3)

      --  UGCDropItemMgr.SpawnItems(ItemList, self:K2_GetActorLocation(), self:K2_GetActorRotation(), 0)
        
    end
    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID, GameState:GetMonsterNum(self.CampID) - 1)
    end

end



function KuangZhan:ReceiveTick(DeltaTime)
    KuangZhan.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 and self.HasPlay ==false then
		ugcprint("going to play particle")
		self.HasPlay = true;
        local SkillManager = self:GetSkillManagerComponent()
		if SkillManager ~= nil then
			--释放120号技能
			SkillManager:TriggerEvent(2, UTSkillEventType.SET_KEY_DOWN)
		end
        local Location = self:K2_GetActorLocation()
        Location.Z = Location.Z+50
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,Location,self:K2_GetActorRotation(),true);
        --local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
        
	end
end

-- function KuangZhan:ReceiveTick(DeltaTime)
--     KuangZhan.SuperClass.ReceiveTick(self, DeltaTime)
--     if self.health <=0 and self.HasPlay ==false then
-- 		ugcprint("going to play montage")
-- 		self.HasPlay = true;
-- 		-- self.Mesh:PlayAnimation(self.MontageDeath2,false);
-- 		local SkillManager = self:GetSkillManagerComponent()
-- 		if SkillManager ~= nil then
-- 			--释放120号技能
-- 			SkillManager:TriggerEvent(2, UTSkillEventType.SET_KEY_DOWN)
-- 		end
--         STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
--         local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
--         UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
--     end
-- end


-- function KuangZhan:ReceiveEndPlay()
--     KuangZhan.SuperClass.ReceiveEndPlay(self) 
--     local BP_Drop = ScriptGameplayStatics.SpawnActor(self,DropParticle,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
-- end


--[[
function KuangZhan:GetReplicatedProperties()
    return
end
--]]

--[[
function KuangZhan:GetAvailableServerRPCs()
    return
end
--]]

return KuangZhan