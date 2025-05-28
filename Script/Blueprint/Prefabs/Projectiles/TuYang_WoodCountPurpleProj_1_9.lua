---@class TuYang_WoodCountPurpleProj_1_9_C:UniversalProjectileBase
---@field ParticleSystem UParticleSystemComponent
---@field Sphere USphereComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local TuYang_WoodCountPurpleProj_1_9 = {}

--使用ExplosionDamageValueWrapper.Value作为伤害时无法过滤玩家，且会对玩家造成震屏效果，目前没办法解决。在ReceivePlayExplosionEffectToAllTarget对需要造成效果的目标进行处理

function TuYang_WoodCountPurpleProj_1_9:ReceiveLaunchBullet()
    TuYang_WoodCountPurpleProj_1_9.SuperClass.ReceiveLaunchBullet(self)
    -- local Wrapper = totable(UE.CreateStruct("FGameMagnitudeWrapper"))
    -- Wrapper.CalculatorType = EPESkillValueCalculatorType.EPESkillValueCalculatorType_Constant
    -- Wrapper.Value = 200
    self.FinallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill1_9",self:GetOwner())
    
    --使用ExplosionDamageValueWrapper.Value作为伤害时无法过滤玩家，且会对玩家造成震屏效果，目前没办法解决。在ReceivePlayExplosionEffectToAllTarget对需要造成效果的目标进行处理
    --self.ExplosionDamageValueWrapper.Value = finallyDamage
end



function TuYang_WoodCountPurpleProj_1_9:ReceiveOnImpact(HitResult)
    TuYang_WoodCountPurpleProj_1_9.SuperClass.ReceiveOnImpact(self,HitResult)
    -- local treeActorClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/SkillAoctors/TuYang_WoodCountPurpleSkillAoctor_P_1_9.TuYang_WoodCountPurpleSkillAoctor_P_1_9_C'))
    -- ugcprint("[maoyu] TuYang_WoodCountPurpleProj_1_9:ReceiveOnImpact ")
    -- local StartLoc = HitResult.Location
    -- local EndLoc = HitResult.Location
    -- EndLoc.Z = EndLoc.Z - 1000

    -- local bFind,result = UGCSceneQueryUtility.QueryByLineSingle(self,StartLoc,EndLoc,nil)

    -- UGCGameSystem.SpawnActor(self,treeActorClass,result.Location,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1},self:GetOwner())

    ugcprint("[maoyu] TuYang_WoodCountPurpleProj_1_9:ReceiveOnImpact ")
    local IgnoredActorList = UGCGameSystem.GetAllPlayerPawn()

    UGCGameSystem.ApplyRadialDamage(self.FinallyDamage, self.FinallyDamage,self:K2_GetActorLocation(),400,400,0,EDamageType.UGCCustomDamageType + 1,IgnoredActorList, self:GetOwner(), self:GetInstigatorController(), ECollisionChannel.ECC_Visibility,0)

    --local damage = UGCGameSystem.ApplyRadialDamage(finallyDamage,finallyDamage,self:K2_GetActorLocation(),300,300,0,EDamageType.UGCCustomDamageType + 1,self.IgnoredActorList,self:GetOwner(),self:GetInstigatorController(),ECollisionChannel.ECC_Visibility, 0)
end


--[[
function TuYang_WoodCountPurpleProj_1_9:ReceiveOnBounce(HitResult, ImpactVelocity)
    TuYang_WoodCountPurpleProj_1_9.SuperClass.ReceiveOnBounce(self,HitResult, ImpactVelocity)
end
--]]


function TuYang_WoodCountPurpleProj_1_9:ReceivePlayExplosionEffect(ExplosionTarget)
    TuYang_WoodCountPurpleProj_1_9.SuperClass.ReceivePlayExplosionEffect(self,ExplosionTarget)
end

function TuYang_WoodCountPurpleProj_1_9:ReceivePlayExplosionEffectToAllTarget(FoundTargets)

    -- if not FoundTargets or #FoundTargets == 0 then
    --     UGCLog.Log("[maoyu]:TuYang_WoodCountPurpleProj_1_9:ReceivePlayExplosionEffectToAllTarget - No valid FoundTargets found")
    --     return
    -- end

    -- -- 遍历所有目标并处理
    -- for _, Target in ipairs(FoundTargets) do
    --     if UE.IsValid(Target.Actor:Get()) then
    --         local Monster = Target.Actor:Get()
    --         local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')
    --         if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(Monster), BaseClass) then
    --             -- 应用伤害
    --             UGCGameSystem.ApplyDamage(Monster, self.FinallyDamage, self:GetInstigatorController(), self:GetOwner(), nil)
    --         end
    --     end
    -- end

    TuYang_WoodCountPurpleProj_1_9.SuperClass.ReceivePlayExplosionEffectToAllTarget(self,FoundTargets)
end


--[[
function TuYang_WoodCountPurpleProj_1_9:TickMovementPath(DeltaTime)
    TuYang_WoodCountPurpleProj_1_9.SuperClass.TickMovementPath(self,DeltaTime)
end
--]]

return TuYang_WoodCountPurpleProj_1_9