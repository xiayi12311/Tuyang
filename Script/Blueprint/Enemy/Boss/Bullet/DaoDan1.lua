---@class DaoDan1_C:UGC_BulletBall_C
---@field ParticleSystem UParticleSystemComponent
--Edit Below--
local DaoDan = {}
local ParticleSystem 
DaoDan.IsThroughVloume = false
function DaoDan:ReceiveBeginPlay()
    DaoDan.SuperClass.ReceiveBeginPlay(self)
    ugcprint("LoadEmmitStart")

    self.BlockingVolumes = GameplayStatics.GetAllActorsWithTag(self, "NeedIgnoreProj")

    ParticleSystem = UE.LoadObject(
        UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Boss/Effect/P_PlaneEX2.P_PlaneEX2'))
        
    ugcprint("LoadEmmitEnd")
    --UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Boss/Effect/P_PlaneEX2.P_PlaneEX2')
end

function DaoDan:OnImpactBP(ImpactResult)
    DaoDan.SuperClass.OnImpactBP(self,ImpactResult)
    UGCLog.Log("[maoyu]:DaoDan:OnImpactBP")
    local ImpactActor = ImpactResult.Actor:Get()
    if UE.IsValid(ImpactActor) then
        if ImpactActor == self.BlockingVolumes[1] then
            UGCLog.Log("[maoyu]:DaoDan:OnImpactBP - ImpactActor == self.BlockVolumes[1]")
            self.bDestroyAfterHit = false
            self.PMComp:ResumeMoveAfterImpactWithNoLost(true)
            self.IsThroughVloume = true
            Timer.InsertTimer(0.2,function()
                self.bDestroyAfterHit = true
            end,false)
        end
    end
end

function DaoDan:CanTargetReallyBlockProjectile(HitResult)
    
    DaoDan.SuperClass.CanTargetReallyBlockProjectile(self,HitResult)
    local ImpactActor = HitResult.Actor:Get()
    if UE.IsValid(ImpactActor) then
        if ImpactActor == self.BlockingVolumes[1] then
            UGCLog.Log("[maoyu]:DaoDan:CanTargetReallyBlockProjectile - ImpactActor == self.BlockVolumes[1]")
            return false
        end
    end
end

--[[
function ZiDan:ReceiveTick(DeltaTime)
    ZiDan.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function DaoDan:ReceiveEndPlay()
    DaoDan.SuperClass.ReceiveEndPlay(self) 
    ugcprint("EmmitStart")
    if self.IsThroughVloume then
        local DmgActorClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/TuYnag/Emeny/TacticalSkillProjectile/TuYang_DaoDanDmgActor.TuYang_DaoDanDmgActor_C'))

        local Loc = self:K2_GetActorLocation()
        Loc.Z = 400
        UGCLog.Log("[maoyu]:DaoDan:ReceiveEndPlay - IsThroughVloume")

        UGCGameSystem.SpawnActor(self,DmgActorClass,Loc,{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1},self:GetInstigator())
    else
        local BoolKey = UGCGameSystem.ApplyRadialDamage(7,7,self:K2_GetActorLocation(),850,850,0, EDamageType.RadialDamage,nil,self:GetInstigator(),self:GetInstigatorController(),ECollisionChannel.ECC_Visibility, 0)

        if BoolKey then
            ugcprint("EmmitSpawn" )
        else
            ugcprint("EmmitEnd" )
        end
    end
    local ExplodeLocation =self:K2_GetActorLocation()
    ExplodeLocation.X = ExplodeLocation.X+50
    STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,ExplodeLocation,self:K2_GetActorRotation(),true)
end


--[[
function ZiDan:GetReplicatedProperties()
    return
end
--]]

--[[
function ZiDan:GetAvailableServerRPCs()
    return
end
--]]

return DaoDan