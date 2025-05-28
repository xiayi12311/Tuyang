---@class TuYang_WindCDPurpleSkillProj_A_3_4_C:UniversalProjectileBase
---@field P_smoke_vehicle_Water_01 UParticleSystemComponent
---@field ParticleSystem UParticleSystemComponent
---@field Sphere USphereComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local TuYang_WindCDPurpleSkillProj_A_3_4 = {}


function TuYang_WindCDPurpleSkillProj_A_3_4:ReceiveBeginPlay()
    TuYang_WindCDPurpleSkillProj_A_3_4.SuperClass.ReceiveBeginPlay(self)
    ugcprint("[maoyu] TuYang_WindCDPurpleSkillProj_A_3_4:ReceiveBeginPlay")
    --self.ParticleSystem:K2_SetWorldRotation({Pitch=0,Yaw=0,Roll=0},false,{},false)
    --UGCLog.Log("[maoyu]:TuYang_WindCDPurpleSkillProj_A_3_4 Rotation = ",self:K2_GetActorRotation().Pitch,self:K2_GetActorRotation().Yaw,self:K2_GetActorRotation().Roll)
end

function TuYang_WindCDPurpleSkillProj_A_3_4:ReceiveLaunchBullet()
    TuYang_WindCDPurpleSkillProj_A_3_4.SuperClass.ReceiveLaunchBullet(self)

    self.FinallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill3_4",self:GetOwner())
end



function TuYang_WindCDPurpleSkillProj_A_3_4:ReceiveOnImpact(HitResult)

    UGCLog.Log("[maoyu]:TuYang_WindCDPurpleSkillProj_A_3_4:ReceiveOnImpact")

    local BlockingVolumeClass = UE.LoadClass('/Script/Engine.BlockingVolume')

    -- 新增 BlockingVolume 检测
    if HitResult.Actor:IsValid() and UE.IsA(HitResult.Actor:Get() , BlockingVolumeClass) then
        self:OnProjectileDestroyed()
        return
    end


    local Monster = nil
    if UE.IsValid(HitResult.Actor:Get()) then
        Monster = HitResult.Actor:Get()
    end

    local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')

    if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(Monster), BaseClass) then

        if not UE.IsValid(Monster) then
            UGCLog.Log("[maoyu]:TuYang_WindCDPurpleSkillProj_A_3_4: - No valid FoundTargets found")
            return
        end

        --local BurningBuffClass = UGCObjectUtility.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_Burning.TuYang_Burning_C'))


        --- 先造成一次导弹命中伤害
        if UE.IsValid(Monster) then
            local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill3_4",self:GetOwner())
            
            UGCGameSystem.ApplyDamage(Monster, self.FinallyDamage, self:GetInstigatorController(), self:GetOwner(), nil)
            --UGCPersistEffectSystem.AddBuffByClass(Monster, BurningBuffClass)
        end

        --- 每秒后对怪物造成50点伤害
        -- self.DamageTimer = Timer.InsertTimer(1.0, function()
        --     if UE.IsValid(Monster) then
        --         UGCGameSystem.ApplyDamage(Monster, 50, self:GetInstigatorController(), self:GetOwner(), nil)
        --         UGCLog.Log("[maoyu]:TuYang_FireCountPurpleProj_1_2:ApplyDamage")
        --     end
        -- end, true)
        -- --- 3秒后移除定时器
        -- Timer.InsertTimer(3.0, function()
        --     if self.DamageTimer ~= nil then
        --         Timer.RemoveTimer(self.DamageTimer)
        --         self.DamageTimer = nil
        --     end
        -- end, false)
    end
    TuYang_WindCDPurpleSkillProj_A_3_4.SuperClass.ReceiveOnImpact(self,HitResult)
end


--[[
function TuYang_WindCDPurpleSkillProj_A_3_4:ReceiveOnBounce(HitResult, ImpactVelocity)
    TuYang_WindCDPurpleSkillProj_A_3_4.SuperClass.ReceiveOnBounce(self,HitResult, ImpactVelocity)
end
--]]

--[[
function TuYang_WindCDPurpleSkillProj_A_3_4:ReceivePlayExplosionEffect(ExplosionTarget)
    TuYang_WindCDPurpleSkillProj_A_3_4.SuperClass.ReceivePlayExplosionEffect(self,ExplosionTarget)
end
--]]

--[[
function TuYang_WindCDPurpleSkillProj_A_3_4:TickMovementPath(DeltaTime)
    TuYang_WindCDPurpleSkillProj_A_3_4.SuperClass.TickMovementPath(self,DeltaTime)
end
--]]

return TuYang_WindCDPurpleSkillProj_A_3_4