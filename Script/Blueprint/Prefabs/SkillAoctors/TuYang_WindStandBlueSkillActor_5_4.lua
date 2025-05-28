---@class TuYang_WindStandBlueSkillActor_5_4_C:AActor
---@field P_Repository_CG30_PassiveSkills_Curing_01 UParticleSystemComponent
---@field ParticleSystem UParticleSystemComponent
---@field Sphere USphereComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local TuYang_WindStandBlueSkillActor_5_4 = {}
 

TuYang_WindStandBlueSkillActor_5_4.OverlappingPlayers = {}


function TuYang_WindStandBlueSkillActor_5_4:ReceiveBeginPlay()
    TuYang_WindStandBlueSkillActor_5_4.SuperClass.ReceiveBeginPlay(self)

    -- 新增创建者记录
    self.OwnerPlayer = self:GetInstigator()
    
    self.Sphere.OnComponentBeginOverlap:Add(self.OnBeginOverlap, self)
    self.Sphere.OnComponentEndOverlap:Add(self.OnEndOverlap, self)

    if self:HasAuthority() then

        local defaultAddHP = 1
        local playerState = UGCGameSystem.GetPlayerStateByPlayerKey(UGCGameSystem.GetPlayerKeyByPlayerPawn(self:GetOwner()))
        local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill5_4",self:GetInstigator())

        local HealingBuffClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_HealingBuff.TuYang_HealingBuff_C'))

        self.WindStandBlueSkillActorTimer = Timer.InsertTimer(1, function()

            -- 新增拥有者存活检测
            if self.OwnerPlayer.Health <= 0 then
                self:DestroyActor()
                UGCLog.Log("[maoyu] OwnerPlayer死亡")
                return
            end

            if not UE.IsValid(self) then
                UGCLog.Log("[maoyu] SkillActor已被销毁")
                return
            end

            local overlappingActors = {}
            self.Sphere:GetOverlappingActors(overlappingActors,UE.LoadClass'/Script/ShadowTrackerExtra.STExtraSimpleCharacter')
            -- 遍历怪物列表
            if overlappingActors and #overlappingActors > 0 then
                for k, monster in pairs(overlappingActors) do
                    -- 检查是随机选择的怪物是否存活并在怪物位置造成范围伤害
                    if monster then
                        UGCGameSystem.ApplyDamage(monster, finallyDamage, self:GetInstigatorController(), self:GetInstigator(), EDamageType.STPointDamage)
                    end
                end
            end
            if #totable(self.OverlappingPlayers) > 0 then
                for k, OverlappingPlayer in pairs(self.OverlappingPlayers) do
                    if UE.IsValid(OverlappingPlayer) then
                        -- 治疗
                        UGCPersistEffectSystem.AddBuffByClass(OverlappingPlayer,HealingBuffClass,nil,1.0,1)

                        local currentHP = UGCPawnAttrSystem.GetHealth(OverlappingPlayer)
                        local maxHP = UGCPawnAttrSystem.GetHealthMax(OverlappingPlayer)
                        UGCPawnAttrSystem.SetHealth(OverlappingPlayer,currentHP + (0.01 * maxHP))

                    end
                end
            end
        end,true)

        ugcprint("TuYang_WindStandBlueSkillActor_5_4:ReceiveBeginPlay")
        -- 新增创建者记录
        self.OwnerPlayer = self:GetOwner()
        UGCLog.Log("TuYang_WindStandBlueSkillActor_5_4:OwnerPlayer" ,self.OwnerPlayer)
        
        -- 新增存活检测定时器
        self.AliveCheckTimer = Timer.InsertTimer(1, function()
            if #self.OverlappingPlayers == 0 then
                self:DestroyActor()
            end
        end, true)

    end

    -- Timer.InsertTimer(3.5, function()
    --     Timer.RemoveTimer(self.WindCountRedSkillActorTimer)
    --     self.OverlappingMonsters = nil
    --     self.OverlappingPlayers = nil
    -- end,false)
    
end

function TuYang_WindStandBlueSkillActor_5_4:OnBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    if self:HasAuthority() then
        UGCLog.Log("TuYang_WindStandBlueSkillActor_5_4:OnBeginOverlap" ,OtherActor)

        local PlayerClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/BPCharacter_ProtectAthena.BPCharacter_ProtectAthena_C'))
        if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(OtherActor), PlayerClass) then
            table.insert(self.OverlappingPlayers,OtherActor)
        end
    end
end

function TuYang_WindStandBlueSkillActor_5_4:OnEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
    if self:HasAuthority() then

        UGCLog.Log("TuYang_WindStandBlueSkillActor_5_4:OnEndOverlap" ,OtherActor)

        -- 创建者离开时立即销毁
        if OtherActor == self.OwnerPlayer then
            UGCLog.Log("TuYang_WindStandBlueSkillActor_5_4:DestroyActor")


            self:DestroyActor()
            return
        end


        if #totable(self.OverlappingPlayers) > 0 then
            for k, v in pairs(self.OverlappingPlayers) do
                if(OtherActor == v) then
                    table.remove(self.OverlappingPlayers,k)
                    return
                end
            end
        end
    end
end

-- 新增统一销毁方法
function TuYang_WindStandBlueSkillActor_5_4:DestroyActor()
    if UE.IsValid(self) then
        self.OwnerPlayer:OnSkillActorDestroyed("Skill5_4")
        Timer.RemoveTimer(self.WindStandBlueSkillActorTimer)
        Timer.RemoveTimer(self.AliveCheckTimer)
        self.OverlappingMonsters = nil
        self.OverlappingPlayers = nil
        self:K2_DestroyActor()
    end
end


--[[
function TuYang_WindStandBlueSkillActor_5_4:ReceiveTick(DeltaTime)
    TuYang_WindStandBlueSkillActor_5_4.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function TuYang_WindStandBlueSkillActor_5_4:ReceiveEndPlay()

    if self:HasAuthority() then

        Timer.RemoveTimer(self.WindStandBlueSkillActorTimer)
        Timer.RemoveTimer(self.AliveCheckTimer)
        self.OverlappingMonsters = nil
        self.OverlappingPlayers = nil
    end
    TuYang_WindStandBlueSkillActor_5_4.SuperClass.ReceiveEndPlay(self) 
end


--[[
function TuYang_WindStandBlueSkillActor_5_4:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_WindStandBlueSkillActor_5_4:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_WindStandBlueSkillActor_5_4