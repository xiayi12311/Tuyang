---@class TuYang_WoodMoveBlueSkillActor_4_9_C:AActor
---@field ParticleSystem UParticleSystemComponent
---@field Sphere USphereComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local TuYang_WoodMoveBlueSkillActor_4_9 = {}
 

function TuYang_WoodMoveBlueSkillActor_4_9:ReceiveBeginPlay()
    TuYang_WoodMoveBlueSkillActor_4_9.SuperClass.ReceiveBeginPlay(self)

    self.FinallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill4_9",self:GetInstigator())

    self.Sphere.OnComponentBeginOverlap:Add(self.Sphere_OnComponentBeginOverlap, self)
    self.Sphere.OnComponentEndOverlap:Add(self.Sphere_OnComponentEndOverlap, self)
    if self:HasAuthority() then
        local overlappingActors = {}
        self.Sphere:GetOverlappingActors(overlappingActors,UE.LoadClass'/Script/ShadowTrackerExtra.STExtraSimpleCharacter')
        for _, actor in ipairs(overlappingActors) do
            -- UGCLog.Log("[maoyu]TuYang_WoodMoveBlueSkillActor_4_9 actor = ",actor)
            self:Sphere_OnComponentBeginOverlap(self.Sphere,actor,nil)
        end
    end
end

function TuYang_WoodMoveBlueSkillActor_4_9:Sphere_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
	if self:HasAuthority() then
        local MonsterClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')

        --UGCLog.Log("[maoyu]TuYang_WoodMoveBlueSkillActor_4_9:finallyDamage = ,SpeedValue =  " ,self.FinallyDamage  ,self:GetInstigator().ActualSpeedValue)


        local Damage = self.FinallyDamage + self:GetInstigator().ActualSpeedValue * 0.005

        if UE.IsA(OtherActor,MonsterClass) then
            -- 新增怪物追踪列表和计时器
            if not self.OverlappingMonsters then
                self.OverlappingMonsters = {}
                self.DamageTimers = {}
            end

            -- 如果怪物不在列表中则添加
            if not self.OverlappingMonsters[OtherActor] then
                self.OverlappingMonsters[OtherActor] = true

                -- 创建循环伤害计时器
                self.DamageTimers[OtherActor] = Timer.InsertTimer(0.5, function()
                    if UE.IsValid(OtherActor) then
                        UGCGameSystem.ApplyDamage(OtherActor, Damage, self:GetInstigatorController(), self:GetInstigator(),EDamageType.STPointDamage)
                    else
                        Timer.RemoveTimer(self.DamageTimers[OtherActor])
                        self.OverlappingMonsters[OtherActor] = nil
                    end
                end, true)
            end
        end
    end
end

function TuYang_WoodMoveBlueSkillActor_4_9:Sphere_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
	if self:HasAuthority() then
        -- 玩家离开时移除计时器
        if self.OverlappingMonsters and self.OverlappingMonsters[OtherActor] then
            Timer.RemoveTimer(self.DamageTimers[OtherActor])
            self.OverlappingMonsters[OtherActor] = nil
            self.DamageTimers[OtherActor] = nil
        end
    end
end

--[[
function TuYang_WoodMoveBlueSkillActor_4_9:ReceiveTick(DeltaTime)
    TuYang_WoodMoveBlueSkillActor_4_9.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

function TuYang_WoodMoveBlueSkillActor_4_9:ReceiveEndPlay()
    TuYang_WoodMoveBlueSkillActor_4_9.SuperClass.ReceiveEndPlay(self) 
    if self.OverlappingMonsters and self.DamageTimers then
        for k, v in pairs(self.DamageTimers) do
            Timer.RemoveTimer(v)
        end
        self.OverlappingMonsters = nil
        self.DamageTimers = nil
    end
end

--[[
function TuYang_WoodMoveBlueSkillActor_4_9:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_WoodMoveBlueSkillActor_4_9:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_WoodMoveBlueSkillActor_4_9