---@class Level_1_C:BP_YXMonsterBase_C
---@field UAESkillManager UUAESkillManagerComponent
---@field MonsterAnimList_Zombie_Dog MonsterAnimList_Zombie_Dog_C
---@field BP_PathInterpSync BP_PathInterpSync_C
---@field TurnAroundView UTurnAroundViewComponent
---@field PVEProjectileMovement UPVEProjectileMovementComponent
---@field BP_ProduceDropItemComponent BP_ProduceDropItemComponent_C
--Edit Below--
local BP_YXMonsterBase = require("Script.Blueprint.Enemy.SecondEnemyBase.BP_YXMonsterBase") -- 确保正确路径
-- local Level_1 = setmetatable({}, {__index = BP_YXMonsterBase})
local Level_1 = Level_1 or {}

Level_1.gold =100

local ParticleSystem = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold')) 

local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))

local DropSkillEmementClss = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/SkillAoctors/TuYang_DropSkillElementActor1.TuYang_DropSkillElementActor1_C'))

Level_1.CampID = 0

function Level_1:ReceiveBeginPlay()
    Level_1.SuperClass.ReceiveBeginPlay(self)
    self.UGC_OnTakeDamageDelegate:Add(self.OnTakeDamageDelegate, self)
    self.OnDeath:AddInstance(self.OnSelfDeath, self)
end



function Level_1:ReceiveTick(DeltaTime)
    Level_1.SuperClass.ReceiveTick(self, DeltaTime)
    if self.health <=0 then
    --     STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
    --     UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
    --     UGCSoundManagerSystem.PlaySoundAttachActor(DeathSound,self,true)
    end
end
--]]


function Level_1:ReceiveEndPlay()
    Level_1.SuperClass.ReceiveEndPlay(self) 
    local GameState = GameplayStatics.GetGameState(self)
    if self:HasAuthority() then
        if self.Health <= 0 then
            GameState:SetKillNum(self.CampID)
        end
        GameState:SetMonsterNum(self.CampID, GameState:GetMonsterNum(self.CampID) - 1)
    end
end
--]]

--[[
function Level_1:GetReplicatedProperties()
    return
end
--]]

--[[
function Level_1:GetAvailableServerRPCs()
    return
end
--]]
function Level_1:OnTakeDamageDelegate(Damage,EventInstigator,DamageEvent,DamageCauser)
    if self.Health <= 0 then
        if EventInstigator then
            --EventInstigator.PlayerState:MonsterDiedAddGoldHandle(self.gold)
            --EventInstigator.PlayerState:AddEnemyCount() 
            EventInstigator.PlayerState:AddDamageCount(Damage)
            
        end
      
    end
end

function Level_1:OnSelfDeath(Level_1, KillerController, DamageCauseActor, HitResult, HitImpulseDirection, DamageTypeID, bHeadShotDamage)
    UGCLog.Log("[maoyu]:Level_1:OnSelfDeath")
    if KillerController then
        if UE.IsA(KillerController,UE.LoadClass('/Game/UGC/UGCGame/GameMode/BP_UGCPlayerController.BP_UGCPlayerController_C')) then
            if KillerController.PlayerState then
                if KillerController.PlayerState then
                    KillerController.PlayerState:MonsterDiedAddGoldHandle(self.gold)
                    KillerController.PlayerState:AddEnemyCount() 
                    STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true)
                    UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,true)
                end
            end
        end
    end

    if self:HasAuthority() then
        local DropSkillEmementClss = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/SkillAoctors/TuYang_DropSkillElementActor1.TuYang_DropSkillElementActor1_C'))
        local rate = UGCGameSystem.GameState.DropSkillElementRate
        -- 7.75%概率掉落技能碎片
        if math.random(1, 10000) <= rate then  -- 万分位精度判断
            UGCLog.Log("[maoyu]:Level_1:OnSelfDeath - SpawnAnything")
            BP_YXMonsterBase:SpawnAnything(self,DropSkillEmementClss,self:K2_GetActorLocation())
        end
    end
end
return Level_1