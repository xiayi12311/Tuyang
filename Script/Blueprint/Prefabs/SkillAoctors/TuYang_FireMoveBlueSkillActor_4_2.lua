---@class TuYang_FireMoveBlueSkillActor_4_2_C:AActor
---@field Sphere USphereComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local TuYang_FireMoveBlueSkillActor_4_2 = {}
 

function TuYang_FireMoveBlueSkillActor_4_2:ReceiveBeginPlay()
    TuYang_FireMoveBlueSkillActor_4_2.SuperClass.ReceiveBeginPlay(self)

    if self:HasAuthority() then

        self.IgnoredActorList = UGCGameSystem.GetAllPlayerPawn()

        local BurningBuffClass = UGCObjectUtility.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_Burning.TuYang_Burning_C'))

        
        -- ugcprint("[maoyu]FireMoveBlueSkillActor:",self:GetOwner(),self:GetInstigatorController())

        local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill4_2",self:GetInstigator())

        --UGCLog.Log("[maoyu]TuYang_FireMoveBlueSkillActor_4_2:finallyDamage = ,SpeedValue =  " ,finallyDamage  ,self:GetInstigator().ActualSpeedValue)
        --UGCLog.LogVector("[maoyu]TuYang_FireMoveBlueSkillActor_4_2:Location = ",self:K2_GetActorLocation())

        local Damage = finallyDamage + self:GetInstigator().ActualSpeedValue * 0.025

        local monsters = {}


        -- local startLoc = self:K2_GetActorLocation()
        -- local endLoc = startLoc
        -- endLoc.Z = endLoc.Z - 1000
        -- local HitResult = nil
        -- local IsHitEdge = false

        -- IsHitEdge, HitResult = KismetSystemLibrary.LineTraceSingleByProfile(self,startLoc,endLoc,"BlockAll", false, {})

        -- UGCLog.LogVector("[maoyu]TuYang_FireMoveBlueSkillActor_4_2:HitResult = " ,HitResult.Location)
        --UGCGameSystem.ApplyRadialDamage(Damage,Damage,self:K2_GetActorLocation(),300,300,0,EDamageType.UGCCustomDamageType + 1,self.IgnoredActorList,self:GetInstigator(),self:GetInstigatorController(),ECollisionChannel.ECC_Visibility, 0)

        Timer.InsertTimer(0.2,function()

            self.OverlappingActors = {}
            self.Sphere:GetOverlappingActors(self.OverlappingActors,UE.LoadClass'/Script/ShadowTrackerExtra.STExtraSimpleCharacter')

            -- 遍历怪物列表
            if self.OverlappingActors and #self.OverlappingActors > 0 then
                for k, monster in pairs(self.OverlappingActors) do
                    if UE.IsValid(monster) then
                        -- 应用buff
                        UGCPersistEffectSystem.AddBuffByClass(monster, BurningBuffClass,nil,6.0,1)
                    end
                end
            end
            monsters = self.OverlappingActors
        end,false)

        local owner = self:GetOwner()
        local controller = self:GetInstigatorController()

        local DamageTimer = Timer.InsertTimer(1.0,function()

            -- 添加有效性验证
            -- if not UE.IsValid(self) then
            --     UGCLog.Log("[maoyu] TuYang_FireMoveBlueSkillActor_4_2 已被销毁")
            --     return
            -- end

            -- 遍历怪物列表
            if monsters and #monsters > 0 then
                for k, monster in pairs(monsters) do
                    if UE.IsValid(monster) then
                        -- 应用伤害
                        UGCGameSystem.ApplyDamage(monster, Damage, controller,owner, nil)
                    end
                end
            end
        end,true)

        Timer.InsertTimer(5.5,function()
            Timer.RemoveTimer(DamageTimer)
        end,false)
    end
end


--[[
function TuYang_FireMoveBlueSkillActor_4_2:ReceiveTick(DeltaTime)
    TuYang_FireMoveBlueSkillActor_4_2.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function TuYang_FireMoveBlueSkillActor_4_2:ReceiveEndPlay()
    TuYang_FireMoveBlueSkillActor_4_2.SuperClass.ReceiveEndPlay(self) 
    self.OverlappingActors = nil
end


--[[
function TuYang_FireMoveBlueSkillActor_4_2:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_FireMoveBlueSkillActor_4_2:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_FireMoveBlueSkillActor_4_2