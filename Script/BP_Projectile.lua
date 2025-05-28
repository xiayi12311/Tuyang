---@class BP_Projectile_C:UGC_Projectile_C
---@field ProjParticleSystem UParticleSystemComponent
---@field InterestedHitBlockActorClasses TArray<UClass*>
--Edit Below--
local BP_Projectile = {}

BP_Projectile.ImpactActor = nil

function BP_Projectile:ReceiveBeginPlay()
    sandbox.LogNormalDev(StringFormat_Dev("[BP_Projectile:ReceiveBeginPlay] self=%s", GetObjectFullName_Dev(self)))
end

function BP_Projectile:UGC_ImpactEvent(ImpactHitResult)
    BP_Projectile.SuperClass.UGC_ImpactEvent(self, ImpactHitResult)

    if self.InterestedHitBlockActorClasses:Num() > 0 then
        local ImpactActorWeak = ImpactHitResult.Actor
        local ImpactActor = ImpactActorWeak:Get()
        if UE.IsValid(ImpactActor) then
            local ImpactActorClass = GameplayStatics.GetObjectClass(ImpactActor)
            for K, V in pairs(self.InterestedHitBlockActorClasses) do
                if KismetMathLibrary.ClassIsChildOf(ImpactActorClass, V) then
                    self.ImpactActor = ImpactActor

                    UGCProjectileSystem.SetDestroyAfterHit(self, true)

                    return
                end
            end
            
            UGCProjectileSystem.SetDestroyAfterHit(self, false)
            
            UGCProjectileSystem.SetMoveAfterImpactWithNoLost(self, false)

            local LastUpdateCompBeforeStop = UGCProjectileSystem.GetLastUpdateCompBeforeStop(self)
            if not LastUpdateCompBeforeStop.MoveIgnoreActors:Contains(ImpactActor) then
                LastUpdateCompBeforeStop.MoveIgnoreActors:Add(ImpactActor)
            end
        end
    end
end

function BP_Projectile:UGC_TakeDamageEvent()
    sandbox.LogNormalDev(StringFormat_Dev("[BP_Projectile:UGC_TakeDamageEvent] self=%s", GetObjectFullName_Dev(self)))

    UGCGameSystem.ApplyRadialDamageWhiteList(
        self.RealHealthDamageInner, 
        self.RealHealthDamageOuter, 
        --self.Momentum, 
        self:K2_GetActorLocation(), 
        self.RealDamageRadiusInner, 
        self.RealDamageRadiusOuter, 
        self.DamageFallOffParam, 
        EDamageType.UGCCustomDamageType + 1, 
        --self.MyDamageType, 
        { self.ImpactActor, }, 
        self, 
        self:GetInstigatorController()
    )
end

return BP_Projectile