---@class TuYang_DaoDanDmgActor_C:AActor
---@field Sphere USphereComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local TuYang_DaoDanDmgActor = {}
 

function TuYang_DaoDanDmgActor:ReceiveBeginPlay()
    TuYang_DaoDanDmgActor.SuperClass.ReceiveBeginPlay(self)

    if self:HasAuthority() then 
        UGCLog.Log("[maoyu]:TuYang_DaoDanDmgActor:ReceiveBeginPlay")

        
        Timer.InsertTimer(0.2,function()
            -- 忽略自身的参数
            local IgnoredActors = {self}
            -- 空值保护
            local Instigator = self:GetOwner()
            local Controller = Instigator and Instigator:GetController() or nil
            UGCLog.Log("[maoyu]:TuYang_DaoDanDmgActor:ReceiveBeginPlay - Instigator:" ,Instigator,"Controller:",Controller)

            
            local overlappingActors = {}
            self.Sphere:GetOverlappingActors(overlappingActors,UE.LoadClass'/Script/ShadowTrackerExtra.STExtraPlayerCharacter')
            
            for _, actor in pairs(overlappingActors) do
                if UE.IsValid(actor) then
                    UGCLog.Log("[maoyu]:TuYang_DaoDanDmgActor:ReceiveBeginPlay - actor:",actor)
                    UGCGameSystem.ApplyDamage(actor, 7, Controller, Instigator,EDamageType.STPointDamage)
                    UGCGameSystem.ClientPlayCameraShake(actor:GetPlayerControllerSafety(), EPESkillCameraShakeType.E_PESKILL_CameraShake_Random, 2.0, 1.0)
                end
            end

            --UGCGameSystem.ApplyRadialDamage(7,7,self:K2_GetActorLocation(),850,850,0, EDamageType.RadialDamage,IgnoredActors,Instigator,Controller,ECollisionChannel.ECC_Visibility, 0)
        end,false)
    end
end


--[[
function TuYang_DaoDanDmgActor:ReceiveTick(DeltaTime)
    TuYang_DaoDanDmgActor.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TuYang_DaoDanDmgActor:ReceiveEndPlay()
    TuYang_DaoDanDmgActor.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TuYang_DaoDanDmgActor:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_DaoDanDmgActor:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_DaoDanDmgActor