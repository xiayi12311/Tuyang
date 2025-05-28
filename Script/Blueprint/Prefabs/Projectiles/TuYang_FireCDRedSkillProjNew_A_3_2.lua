---@class TuYang_FireCDRedSkillProjNew_A_3_2_C:UniversalProjectileBase
---@field Tail UParticleSystemComponent
---@field Sphere UStaticMeshComponent
---@field SphereCollision USphereComponent
---@field PlayerPawn UClass
---@field CameraShakeRange float
---@field CameraShakeTime float
---@field CameraShakeScale float
--Edit Below--
local TuYang_FireCDRedSkillProjNew_A_3_2 = {}

function TuYang_FireCDRedSkillProjNew_A_3_2:ReceiveLaunchBullet()
    TuYang_FireCDRedSkillProjNew_A_3_2.SuperClass.ReceiveLaunchBullet(self)

    self.FinallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill3_2",self:GetOwner())
end

--使用ExplosionDamageValueWrapper.Value作为伤害时无法过滤玩家，且会对玩家造成震屏效果，目前没办法解决。在ReceivePlayExplosionEffectToAllTarget对需要造成效果的目标进行处理
function TuYang_FireCDRedSkillProjNew_A_3_2:ReceivePlayExplosionEffectToAllTarget(FoundTargets)
 

    self.IgnoredActorList = UGCGameSystem.GetAllPlayerPawn()

    local BurningBuffClass = UGCObjectUtility.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_Burning.TuYang_Burning_C'))

    -- 遍历所有目标并处理
    for k, v in pairs(FoundTargets) do
        if UE.IsValid(v.Actor:Get()) then
            local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')
            
            ugcprint("[maoyu]TuYang_FireCDRedSkillProjNew_A_3_2: Log:ClassIsChildOf")
            if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(v.Actor:Get()), BaseClass) then
                local monster = v.Actor:Get()

                --UGCLog.Log("[maoyu]:v.Actor:Get()" ,monster)

                local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill3_2",self:GetOwner())
                
                UGCGameSystem.ApplyDamage(monster, self.FinallyDamage, self:GetInstigatorController(), self:GetOwner())
                
                UGCPersistEffectSystem.AddBuffByClass(monster, BurningBuffClass)

                -- 每秒dot伤害系数
                local burningDamage = self.FinallyDamage * 0.15
                local controller = self:GetInstigatorController()
                local owner = self:GetOwner()

                --- 每秒后对怪物造成伤害
                local DamageTimer = Timer.InsertTimer(1.0, function()
                    if UE.IsValid(monster) then
                        UGCGameSystem.ApplyDamage(monster, burningDamage, controller, owner, nil)
                    end
                end, true)

                --- 5秒后移除定时器
                Timer.InsertTimer(5.5, function()
                    if DamageTimer ~= nil then
                        Timer.RemoveTimer(DamageTimer)
                        DamageTimer = nil
                    end
                end, false)



                print("[maoyu]TuYang_FireCDRedSkillProjNew_A_3_2: Log:爆炸")
                -- UGCGameSystem.ClientPlayCameraShake(PlayerController, EPESkillCameraShakeType.E_PESKILL_CameraShake_Random, 1, 1)
            end
        end
    end


    -- for k, v in pairs(ExplosionTarget) do
    --     if UE.IsValid(v.Actor:Get()) then
    --         if UE.IsA(v.Actor:Get(),self.PlayerPawn) then
    --             local PlayerController = v.Actor:Get():GetPlayerControllerSafety()
    --             print("TuYang_FireCDRedSkillProjNew_A_3_2: Log:震屏")
    --             UGCGameSystem.ClientPlayCameraShake(PlayerController, EPESkillCameraShakeType.E_PESKILL_CameraShake_Random, 1, 1)
    --         end
    --     end
    -- end

    TuYang_FireCDRedSkillProjNew_A_3_2.SuperClass.ReceivePlayExplosionEffectToAllTarget(self,FoundTargets)
end


return TuYang_FireCDRedSkillProjNew_A_3_2