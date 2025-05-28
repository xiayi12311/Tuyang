---@class TuYang_LightCDGreenProj_3_3_C:UniversalProjectileBase
---@field Goldbrust UParticleSystemComponent
---@field P_laser_02 UParticleSystemComponent
---@field Sphere USphereComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local TuYang_LightCDGreenProj_3_3 = {}


function TuYang_LightCDGreenProj_3_3:ReceiveLaunchBullet()
    TuYang_LightCDGreenProj_3_3.SuperClass.ReceiveLaunchBullet(self)

    self.FinallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill3_3",self:GetOwner())
end



function TuYang_LightCDGreenProj_3_3:ReceiveOnImpact(HitResult)

    UGCLog.Log("[maoyu]:TuYang_LightCDGreenProj_3_3:ReceiveOnImpact")
    local Monster = nil
    if UE.IsValid(HitResult.Actor:Get()) then
        Monster = HitResult.Actor:Get()
    end

    local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')

    if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(Monster), BaseClass) then

        if not UE.IsValid(Monster) then
            UGCLog.Log("[maoyu]:TuYang_LightCDGreenProj_3_3: - No valid FoundTargets found")
            return
        end

        local StunBuffClass = UGCObjectUtility.LoadClass(
            UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_StunBuff.TuYang_StunBuff_C'))

        if UE.IsValid(Monster) then
            -- 造成伤害
            local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill3_3",self:GetOwner())
            
            -- 添加眩晕buff
            UGCPersistEffectSystem.AddBuffByClass(Monster, StunBuffClass)
            -- 眩晕逻辑，停止/重启BehaviorTree
            --self.BPause = true
            local Controlle = Monster:GetControllerSafety()
            local BrainComp = nil
            if Controlle then
                BrainComp = Controlle.BrainComponent
            end
            if BrainComp then
                BrainComp:StopLogic("Stop")
                Timer.InsertTimer(2, function()
                    -- 双重有效性验证
                    if UE.IsValid(Monster) and UE.IsValid(Controlle) and Controlle.BrainComponent then
                        Controlle.BrainComponent:RestartLogic()
                    end
                end,false)
            end

            UGCGameSystem.ApplyDamage(Monster, self.FinallyDamage, self:GetInstigatorController(), self:GetOwner(), nil)

        end
    end

    TuYang_LightCDGreenProj_3_3.SuperClass.ReceiveOnImpact(self,HitResult)
end


--[[
function TuYang_LightCDGreenProj_3_3:ReceiveOnBounce(HitResult, ImpactVelocity)
    TuYang_LightCDGreenProj_3_3.SuperClass.ReceiveOnBounce(self,HitResult, ImpactVelocity)
end
--]]

--[[
function TuYang_LightCDGreenProj_3_3:ReceivePlayExplosionEffect(ExplosionTarget)
    TuYang_LightCDGreenProj_3_3.SuperClass.ReceivePlayExplosionEffect(self,ExplosionTarget)
end
--]]

--[[
function TuYang_LightCDGreenProj_3_3:TickMovementPath(DeltaTime)
    TuYang_LightCDGreenProj_3_3.SuperClass.TickMovementPath(self,DeltaTime)
end
--]]

return TuYang_LightCDGreenProj_3_3