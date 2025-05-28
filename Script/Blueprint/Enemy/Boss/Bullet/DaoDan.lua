---@class DaoDan_C:UGC_BulletBall_C
---@field ParticleSystem UParticleSystemComponent
--Edit Below--
local DaoDan = {}
local ParticleSystem 
function DaoDan:ReceiveBeginPlay()
    DaoDan.SuperClass.ReceiveBeginPlay(self)
    ugcprint("LoadEmmitStart")


    ParticleSystem = UE.LoadObject(
        UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Boss/Effect/P_PlaneEX.P_PlaneEX'))
    ugcprint("LoadEmmitEnd")
    --UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Boss/Effect/P_PlaneEX.P_PlaneEX')
end


--[[
function ZiDan:ReceiveTick(DeltaTime)
    ZiDan.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function DaoDan:ReceiveEndPlay()
    DaoDan.SuperClass.ReceiveEndPlay(self) 
    ugcprint("EmmitStart")
    local BoolKey = UGCGameSystem.ApplyRadialDamage(4,4,self:K2_GetActorLocation(),600,600,0, EDamageType.RadialDamage,nil,self:GetInstigator(),self:GetInstigatorController(),ECollisionChannel.ECC_Visibility, 0);
    local ExplodeLocation =self:K2_GetActorLocation();
    ExplodeLocation.X = ExplodeLocation.X+50
    STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,ExplodeLocation,self:K2_GetActorRotation(),true);
    if BoolKey then
        ugcprint("EmmitSpawn" )
    else
        ugcprint("EmmitEnd" )
    end
    
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