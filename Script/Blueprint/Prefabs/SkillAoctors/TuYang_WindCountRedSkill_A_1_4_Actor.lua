---@class TuYang_WindCountRedSkill_A_1_4_Actor_C:AActor
---@field Sphere1 USphereComponent
---@field STCustomMesh USTCustomMeshComponent
---@field Sphere USphereComponent
---@field ActorSequence UActorSequenceComponent
---@field ParticleSystem UParticleSystemComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local TuYang_WindCountRedSkill_A_1_4_Actor = {}
 
TuYang_WindCountRedSkill_A_1_4_Actor.OverlappingMonsters = {}
--TuYang_WindCountRedSkill_A_1_4_Actor.OverlappingPlayers = {}

function TuYang_WindCountRedSkill_A_1_4_Actor:ReceiveBeginPlay()
    TuYang_WindCountRedSkill_A_1_4_Actor.SuperClass.ReceiveBeginPlay(self)

    --UGCLog.Log("[maoyu]TuYang_WindCountRedSkill_A_1_4_Actor:ReceiveBeginPlay",self.Sphere)

    if self:HasAuthority() then

        self.Sphere.OnComponentBeginOverlap:Add(self.OnBeginOverlap, self)
        self.Sphere.OnComponentEndOverlap:Add(self.OnEndOverlap, self)
        self.Sphere1.OnComponentBeginOverlap:Add(self.OnBeginOverlap_Sphere1, self)
        self.Sphere1.OnComponentEndOverlap:Add(self.OnEndOverlap_Sphere1, self)


        self.DamageTimer = Timer.InsertTimer(1.0,function()

            if not UE.IsValid(self) then
                UGCLog.Log("[maoyu] SkillActor已被销毁")
                return
            end

            local overlappingActors = {}
            self.Sphere:GetOverlappingActors(overlappingActors,UE.LoadClass'/Script/ShadowTrackerExtra.STExtraSimpleCharacter')
            UGCLog.Log("[maoyu]:1_4:overlappingActors = ",overlappingActors)
            -- 遍历怪物列表
            if overlappingActors and #overlappingActors > 0 then
                for k, monster in pairs(overlappingActors) do
                    local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill1_4",self:GetInstigator())

                    UGCGameSystem.ApplyDamage(monster, finallyDamage, self:GetInstigatorController(), self:GetInstigator(),EDamageType.STPointDamage)
                end
            end
        end,true)
        


        -- self.WindCountRedSkillActorTimer = Timer.InsertTimer(1, function()

        --     if not UE.IsValid(self) then
        --         UGCLog.Log("[maoyu] SkillActor已被销毁")
        --         return
        --     end

        --     if #totable(self.OverlappingMonsters) > 0 then
        --         for k, OverlappingMonster in pairs(self.OverlappingMonsters) do
        --             --UGCLog.Log("[maoyu]TuYang_WindCountRedSkill_A_1_4_Actor:Character:", self:GetInstigator(),"OverlappingActor",OverlappingMonster)
    
        --             if UE.IsValid(OverlappingMonster) then
        --                 --UGCLog.Log("[maoyu]TuYang_WindCountRedSkill_A_1_4_Actor:OverlappingActor:",OverlappingMonster)
        --                 local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill1_4",self:GetInstigator())

        --                 UGCGameSystem.ApplyDamage(OverlappingMonster, finallyDamage, self:GetInstigatorController(), self:GetInstigator(),EDamageType.STPointDamage)
        --             end
        --             --if OverlappingActor ~= self:GetInstigator() then
        --         end
        --     end
        -- end,true)

        Timer.InsertTimer(3.5, function()
            Timer.RemoveTimer(self.DamageTimer)
            self.DamageTimer = nil
            --self.OverlappingPlayers = nil
        end,false)
    end
end

function TuYang_WindCountRedSkill_A_1_4_Actor:OnBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    -- if self:HasAuthority() then
    --     local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')
    --     local PlayerClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/BPCharacter_ProtectAthena.BPCharacter_ProtectAthena_C'))
    --     if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(OtherActor), BaseClass) then
    --         table.insert(self.OverlappingMonsters,OtherActor)
    --         --UGCLog.Log("[maoyu]:1_4:OnBeginOverlap:",OtherActor)
            

    --         --table.insert(self.Test,OtherActor)

    --         --UGCLog.Log("[maoyu]:1_4:OnBeginOverlap:",self.OverlappingMonsters,self.Test)
    --     end

    --     -- if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(OtherActor), PlayerClass) then
    --     --     table.insert(self.OverlappingPlayers,OtherActor)
    --     --     local origSpeedScale = UGCPawnAttrSystem.GetSpeedScale(OtherActor)
    --     --     UGCPawnAttrSystem.SetSpeedScale(OtherActor,origSpeedScale*1.15)
    --     --     --UGCLog.Log("[maoyu]:1_4:OnBeginOverlap:",OtherActor,"SpeedScale",UGCPawnAttrSystem.GetSpeedScale(OtherActor))
    --     -- end
    -- end
end

function TuYang_WindCountRedSkill_A_1_4_Actor:OnEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
    -- if self:HasAuthority() then
    --     if #totable(self.OverlappingMonsters) > 0 then
    --         for k, v in pairs(self.OverlappingMonsters) do
    --             if(OtherActor == v) then
    --                 table.remove(self.OverlappingMonsters,k)
    --                 --UGCLog.Log("[maoyu]:1_4:OnBeginOverlap:",OtherActor)

    --                 --table.remove(self.Test,k)

    --                 --UGCLog.Log("[maoyu]:1_4:OnBeginOverlap:",self.OverlappingMonsters,self.Test)
            

    --                 return
    --             end
    --         end
    --     end

        -- if #totable(self.OverlappingPlayers) > 0 then
        --     for k, v in pairs(self.OverlappingPlayers) do
        --         if(OtherActor == v) then
        --             local origSpeedScale = UGCPawnAttrSystem.GetSpeedScale(OtherActor)

        --             UGCPawnAttrSystem.SetSpeedScale(OtherActor,origSpeedScale/1.15)
        --             table.remove(self.OverlappingPlayers,k)
        --             --UGCLog.Log("[maoyu]:1_4:OnBeginOverlap:",OtherActor,"SpeedScale",UGCPawnAttrSystem.GetSpeedScale(OtherActor))
        --             return
        --         end
        --     end
        -- end

    --end
end


function TuYang_WindCountRedSkill_A_1_4_Actor:OnBeginOverlap_Sphere1(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
	if self:HasAuthority() then
        if OtherActor == self:GetInstigator() then
            return
        end
        local PlayPawnClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/BPCharacter_ProtectAthena.BPCharacter_ProtectAthena_C'))

        if UE.IsA(OtherActor,PlayPawnClass) then
            local PlayPawn = OtherActor
            local weapon = UGCWeaponManagerSystem.GetCurrentWeapon(PlayPawn)
            local weaponClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraShootWeapon')

            if UE.IsA(weapon, weaponClass) then 
                local weaponShootIntervalTime = UGCGunSystem.GetShootIntervalTime(weapon)
                UGCGunSystem.SetShootIntervalTime(weapon, weaponShootIntervalTime * (1.0 - 0.17 ))
            end
        end
    end
end

function TuYang_WindCountRedSkill_A_1_4_Actor:OnEndOverlap_Sphere1(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
    if self:HasAuthority() then
        if OtherActor == self:GetInstigator() then
            return
        end
        local PlayPawnClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/BPCharacter_ProtectAthena.BPCharacter_ProtectAthena_C'))

        if UE.IsA(OtherActor,PlayPawnClass) then
            local PlayPawn = OtherActor
            local weapon = UGCWeaponManagerSystem.GetCurrentWeapon(PlayPawn)
            local weaponClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraShootWeapon')

            if UE.IsA(weapon, weaponClass) then 
                local weaponShootIntervalTime = UGCGunSystem.GetShootIntervalTime(weapon)
                UGCGunSystem.SetShootIntervalTime(weapon, weaponShootIntervalTime / (1.0 - 0.17 ))
            end
        end
    end
end


--[[
function TuYang_WindCountRedSkill_A_1_4_Actor:ReceiveTick(DeltaTime)
    TuYang_WindCountRedSkill_A_1_4_Actor.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function TuYang_WindCountRedSkill_A_1_4_Actor:ReceiveEndPlay()
    TuYang_WindCountRedSkill_A_1_4_Actor.SuperClass.ReceiveEndPlay(self) 
end


--[[
function TuYang_WindCountRedSkill_A_1_4_Actor:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_WindCountRedSkill_A_1_4_Actor:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_WindCountRedSkill_A_1_4_Actor