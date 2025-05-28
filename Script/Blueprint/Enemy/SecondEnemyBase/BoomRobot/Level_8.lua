---@class Level_8_C:BP_YXMonsterBase_C
---@field UAEMonsterAnimList UUAEMonsterAnimListComponent
---@field UAESkillManager UUAESkillManagerComponent
--Edit Below--

local Level_8 = {}
Level_8.gold = 105
Level_8.CampID = 0

local ParticleSystem = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))

function Level_8:ReceiveBeginPlay()
    Level_8.SuperClass.ReceiveBeginPlay(self)

    self.OnDeath:AddInstance(self.OnSelfDeath, self)
end

function Level_8:ReceiveTick(DeltaTime)
    Level_8.SuperClass.ReceiveTick(self, DeltaTime)
end

function Level_8:ReceiveEndPlay()
    Level_8.SuperClass.ReceiveEndPlay(self) 

    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID, GameState:GetMonsterNum(self.CampID) - 1)
    end
end

function Level_8:OnSelfDeath(Level_8, KillerController, DamageCauseActor, HitResult, HitImpulseDirection, DamageTypeID, bHeadShotDamage)
    UGCLog.Log("[maoyu]:Level_8:OnSelfDeath")
    if KillerController then
        if UE.IsA(KillerController,UE.LoadClass('/Game/UGC/UGCGame/GameMode/BP_UGCPlayerController.BP_UGCPlayerController_C')) then
            if KillerController.PlayerState then
                if KillerController.PlayerState then
                    KillerController.PlayerState:MonsterDiedAddGoldHandle(self.gold)
                    KillerController.PlayerState:AddEnemyCount() 
                    STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
                    UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
                end
            end
        end
    end

    local SkillManager = self:GetSkillManagerComponent()
    if SkillManager ~= nil then
        --释放0号技能
        SkillManager:TriggerEvent(0, UTSkillEventType.SET_KEY_DOWN)
    end
end


--[[
function Level_8:GetReplicatedProperties()
    return
end
--]]

--[[
function Level_8:GetAvailableServerRPCs()
    return
end
--]]

return Level_8