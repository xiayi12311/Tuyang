---@class TuYang_LightCountBlueProj_1_3_C:UniversalProjectileBase
---@field Sphere USphereComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local TuYang_LightCountBlueProj_1_3 = {}


function TuYang_LightCountBlueProj_1_3:ReceiveLaunchBullet()
    TuYang_LightCountBlueProj_1_3.SuperClass.ReceiveLaunchBullet(self)

    self.FinallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill1_3",self:GetOwner())
end



function TuYang_LightCountBlueProj_1_3:ReceiveOnImpact(HitResult)
    TuYang_LightCountBlueProj_1_3.SuperClass.ReceiveOnImpact(self,HitResult)

    UGCLog.Log("[maoyu]:TuYang_LightCountBlueProj_1_3:ReceiveOnImpact")
    local Monster = nil
    if UE.IsValid(HitResult.Actor:Get()) then
        Monster = HitResult.Actor:Get()
    end

    local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')

    if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(Monster), BaseClass) then

        if not UE.IsValid(Monster) then
            UGCLog.Log("[maoyu]:TuYang_LightCountBlueProj_1_3: - No valid FoundTargets found")
            return
        end

        local StunBuffClass = UGCObjectUtility.LoadClass(
            UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_StunBuff.TuYang_StunBuff_C'))


        --- 先造成一次导弹命中伤害
        if UE.IsValid(Monster) then
            -- 造成伤害
            -- local weapon = UGCWeaponManagerSystem.GetCurrentWeapon(self:GetOwner())
            -- local weaponDamage = UGCGunSystem.GetBulletBaseDamage(weapon)


            -- local playerState = UGCGameSystem.GetPlayerStateByPlayerKey(UGCGameSystem.GetPlayerKeyByPlayerPawn(self:GetOwner()))
            -- ugcprint("[maoyu]weaponDamage = "..weaponDamage)
            -- ugcprint("[maoyu]SkillDamageMultiplier = "..playerState.PersistSkillDamagesList["Skill1_3"].SkillDamageMultiplier)

            -- local skillBaseDamage = playerState.PersistSkillDamagesList["Skill1_3"].SkillDamageMultiplier * weaponDamage
            -- ugcprint("[maoyu]skillBaseDamage = " ..skillBaseDamage)

            -- local finallyDamage = skillBaseDamage + skillBaseDamage * playerState.PersistSkillDamagesList["Skill1_3"].DamageMultiplier
            -- ugcprint("[maoyu]finallyDamage = " ..finallyDamage)


            local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill1_3",self:GetOwner())

            -- 添加眩晕buff
            UGCPersistEffectSystem.AddBuffByClass(Monster, StunBuffClass)
            -- 眩晕逻辑，停止/重启BehaviorTree
            --self.BPause = true
            local Controlle = Monster:GetControllerSafety()
            -- local BrainComp = Controlle.BrainComponent
            -- --if self.BPause then
            -- BrainComp:StopLogic("Stop")
            -- --end
            -- Timer.InsertTimer(2, function()BrainComp:RestartLogic()
            -- end,false)

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
end


--[[
function TuYang_LightCountBlueProj_1_3:ReceiveOnBounce(HitResult, ImpactVelocity)
    TuYang_LightCountBlueProj_1_3.SuperClass.ReceiveOnBounce(self,HitResult, ImpactVelocity)
end
--]]

--[[
function TuYang_LightCountBlueProj_1_3:ReceivePlayExplosionEffect(ExplosionTarget)
    TuYang_LightCountBlueProj_1_3.SuperClass.ReceivePlayExplosionEffect(self,ExplosionTarget)
end
--]]

--[[
function TuYang_LightCountBlueProj_1_3:TickMovementPath(DeltaTime)
    TuYang_LightCountBlueProj_1_3.SuperClass.TickMovementPath(self,DeltaTime)
end
--]]

return TuYang_LightCountBlueProj_1_3