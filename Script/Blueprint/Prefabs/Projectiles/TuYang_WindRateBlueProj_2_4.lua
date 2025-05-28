---@class TuYang_WindRateBlueProj_2_4_C:UniversalProjectileBase
---@field Tail UParticleSystemComponent
---@field Sphere UStaticMeshComponent
---@field SphereCollision USphereComponent
---@field PlayerPawn UClass
---@field CameraShakeRange float
---@field CameraShakeTime float
---@field CameraShakeScale float
--Edit Below--
local TuYang_WindRateBlueProj_2_4 = {}

function TuYang_WindRateBlueProj_2_4:ReceiveOnImpact(HitResult)
    TuYang_WindRateBlueProj_2_4.SuperClass.ReceiveOnImpact(self,HitResult)

    ugcprint("[maoyu]TuYang_WindRateBlueProj_2_4: Log:ReceiveOnImpact")
    self.FinallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill2_4",self:GetOwner())

    local Monster = nil
    if UE.IsValid(HitResult.Actor:Get()) then
        Monster = HitResult.Actor:Get()
    end

    local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')

    if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(Monster), BaseClass) then

        if not UE.IsValid(Monster) then
            UGCLog.Log("[maoyu]:TuYang_FireCountPurpleProj_1_2: - No valid FoundTargets found")
            return
        end

        local controller = self:GetInstigatorController()
        local owner = self:GetOwner()

        --- 先造成一次导弹命中伤害
        if UE.IsValid(Monster) then
            UGCGameSystem.ApplyDamage(Monster, self.FinallyDamage, self:GetInstigatorController(), self:GetOwner(), nil)
        end
    end


    -- local HealingBallClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/SkillAoctors/TuYang_WindRateBlueSkillAoctor_A_2_4.TuYang_WindRateBlueSkillAoctor_A_2_4_C'))
    -- local SpawnLoc = self:K2_GetActorLocation()
    -- SpawnLoc.Z = SpawnLoc.Z + 10
    -- UGCGameSystem.SpawnActor(
    --                 self,
    --                 HealingBallClass,
    --                 SpawnLoc,
    --                 {Roll = 0, Pitch = 0, Yaw = 0},
    --                 {X = 1, Y = 1, Z = 1},
    --                 self:GetOwner()
    --             )
end

 --使用ExplosionDamageValueWrapper.Value作为伤害时无法过滤玩家，且会对玩家造成震屏效果，目前没办法解决。在ReceivePlayExplosionEffectToAllTarget对需要造成效果的目标进行处理
function TuYang_WindRateBlueProj_2_4:ReceivePlayExplosionEffectToAllTarget(FoundTargets)
    TuYang_WindRateBlueProj_2_4.SuperClass:ReceivePlayExplosionEffectToAllTarget(FoundTargets)
    -- ugcprint("[maoyu]TuYang_WindRateBlueProj_2_4: Log:ReceivePlayExplosionEffectToAllTarget")

    --     -- 遍历所有目标并处理
    -- for k, v in pairs(FoundTargets) do
    --     if UE.IsValid(v.Actor:Get()) then
    --         local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')
            
    --         ugcprint("[maoyu]TuYang_FireCDRedSkillProjNew_A_3_2: Log:ClassIsChildOf")
    --         if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(v.Actor:Get()), BaseClass) then
    --             local monster = v.Actor:Get()

    --             -- UGCLog.Log("[maoyu]:v.Actor:Get()" ,monster)

    --             local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill2_4",self:GetOwner())
                
    --             UGCGameSystem.ApplyDamage(monster, self.FinallyDamage, self:GetInstigatorController(), self:GetOwner())

    --             --UGCPersistEffectSystem.AddBuffByClass(monster, BurningBuffClass)


    --             print("[maoyu]TuYang_WindRateBlueProj_2_4: Log:爆炸")
    --             -- UGCGameSystem.ClientPlayCameraShake(PlayerController, EPESkillCameraShakeType.E_PESKILL_CameraShake_Random, 1, 1)
    --         end
    --     end
    -- end
end


return TuYang_WindRateBlueProj_2_4