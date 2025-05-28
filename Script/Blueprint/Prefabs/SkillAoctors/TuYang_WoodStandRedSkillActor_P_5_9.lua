---@class TuYang_WoodStandRedSkillActor_P_5_9_C:AActor
---@field ParticleSystem UParticleSystemComponent
---@field Sphere USphereComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local TuYang_WoodStandRedSkillActor_P_5_9 = {}
 
function TuYang_WoodStandRedSkillActor_P_5_9:ReceiveBeginPlay()
    TuYang_WoodStandRedSkillActor_P_5_9.SuperClass.ReceiveBeginPlay(self)

    self.FinallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill5_9",self:GetOwner())

    self.Sphere.OnComponentBeginOverlap:Add(self.Sphere_OnComponentBeginOverlap, self)
    self.Sphere.OnComponentEndOverlap:Add(self.Sphere_OnComponentEndOverlap, self)

    local IgnoredActorList = UGCGameSystem.GetAllPlayerPawn()
    local EmitterTemplate1 = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/SkillEffectTD/P_Repository_EFX_KillSelf_Bomb_Skill08.P_Repository_EFX_KillSelf_Bomb_Skill08'))

    -- 新增创建者记录
    self.OwnerPlayer = self:GetInstigator()
    self.OwnerPlayer.Skill5_9Actor = self
    
    --if self:HasAuthority() then
        self.RadialDamageTimer = Timer.InsertTimer(2.0,function()
            local overlappingActors = {}
            self.Sphere:GetOverlappingActors(overlappingActors,UE.LoadClass'/Script/ShadowTrackerExtra.STExtraSimpleCharacter')
            -- 遍历怪物列表
            if overlappingActors and #overlappingActors > 0 then

                -- 新增拥有者存活检测
                if self.OwnerPlayer.Health <= 0 then
                    self:DestroyActor()
                    UGCLog.Log("[maoyu] OwnerPlayer死亡")
                    return
                end

                -- 随机选择一个怪物
                local Random = math.random(1, #overlappingActors)
                local monster = overlappingActors[Random]

                -- 检查是随机选择的怪物是否存活并在怪物位置造成范围伤害
                if monster then
                    UGCGameSystem.ApplyRadialDamage(self.FinallyDamage, self.FinallyDamage,monster:K2_GetActorLocation(),200,200,0,EDamageType.UGCCustomDamageType + 1,IgnoredActorList, self:GetOwner(), self:GetInstigatorController(), ECollisionChannel.ECC_Visibility,0)
                    UGCLog.Log("TuYang_WoodStandRedSkillActor_P_5_9:ReceiveBeginPlay")
                    

                    STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,EmitterTemplate1,monster:K2_GetActorLocation(),{Roll = 0,Pitch = 0,Yaw = 0},true)
                end
            end
        end,true)
    --end
end

function TuYang_WoodStandRedSkillActor_P_5_9:Sphere_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
	if self:HasAuthority() then


    end
end

function TuYang_WoodStandRedSkillActor_P_5_9:Sphere_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
	--if self:HasAuthority() then
        -- 创建者离开时立即销毁
        if OtherActor == self.OwnerPlayer then
            UGCLog.Log("TuYang_WoodStandRedSkillActor_P_5_9:DestroyActor")
            self:DestroyActor()
            return
        end
    --end
end

-- 新增统一销毁方法
function TuYang_WoodStandRedSkillActor_P_5_9:DestroyActor()
    if UE.IsValid(self) then
        self.OwnerPlayer:OnSkillActorDestroyed("Skill5_9")
        Timer.RemoveTimer(self.RadialDamageTimer)
        self:K2_DestroyActor()
    end
end

--[[
function TuYang_WoodStandRedSkillActor_P_5_9:ReceiveTick(DeltaTime)
    TuYang_WoodStandRedSkillActor_P_5_9.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

function TuYang_WoodStandRedSkillActor_P_5_9:ReceiveEndPlay()
    TuYang_WoodStandRedSkillActor_P_5_9.SuperClass.ReceiveEndPlay(self)
    self:DestroyActor() 
end

--[[
function TuYang_WoodStandRedSkillActor_P_5_9:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_WoodStandRedSkillActor_P_5_9:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_WoodStandRedSkillActor_P_5_9