---@class TuYang_WindMoveGreenSkill_P_4_4_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_WindMoveGreenSkill_P_4_4 = {}
 
function TuYang_WindMoveGreenSkill_P_4_4:OnEnableSkill_BP()
    TuYang_WindMoveGreenSkill_P_4_4.SuperClass.OnEnableSkill_BP(self)
    return true
end

function TuYang_WindMoveGreenSkill_P_4_4:OnDisableSkill_BP()
    TuYang_WindMoveGreenSkill_P_4_4.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_WindMoveGreenSkill_P_4_4:OnActivateSkill_BP()
    TuYang_WindMoveGreenSkill_P_4_4.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_WindMoveGreenSkill_P_4_4:OnDeActivateSkill_BP()
    TuYang_WindMoveGreenSkill_P_4_4.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_WindMoveGreenSkill_P_4_4:CanActivateSkill_BP()
    return TuYang_WindMoveGreenSkill_P_4_4.SuperClass.CanActivateSkill_BP(self)
end



function TuYang_WindMoveGreenSkill_P_4_4:OnTakeDamageTarget()

    local Monsters = self:GetSelectTargetActor(EPESkillSelectTarget.E_PESKILL_PickerType_AllTarget)
    if not Monsters or #Monsters == 0 then
        UGCLog.Log("[maoyu]:TuYang_WindMoveGreenSkill_A_4_4:OnTakeDamageTarget - No valid targets found")
        return
    end

    local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill4_4",self:GetNetOwnerActor())

    --UGCLog.Log("[maoyu]TuYang_WindMoveGreenSkill_P_4_4:finallyDamage = ,SpeedValue =  " ,finallyDamage  ,self:GetNetOwnerActor().ActualSpeedValue)

    local Damage = finallyDamage + self:GetNetOwnerActor().ActualSpeedValue * 0.012
    

    local EmitterTemplate1 = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/SkillEffectTD/WindBlade.WindBlade'))

    local EmitterTemplate2 = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/SkillEffectTD/p_chick_qiliu_01.p_chick_qiliu_01'))

    local AttackSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/TuYang_WindMoveGreenSkillSound_A_4_4.TuYang_WindMoveGreenSkillSound_A_4_4'))

    GameplayStatics.SpawnEmitterAttached(EmitterTemplate1, self:GetNetOwnerActor():GetMeshComponent() , "Root", {X = 0, Y = 0, Z = 0}, {Pitch=90,Yaw=0,Roll=0}, {X = 1, Y = 1, Z = 1}, EAttachLocation.KeepRelativeOffset, true)

    GameplayStatics.SpawnEmitterAttached(EmitterTemplate2, self:GetNetOwnerActor():GetMeshComponent() , "Root", {X = 0, Y = 0, Z = 0}, {Pitch=0,Yaw=0,Roll=0}, {X = 1, Y = 1, Z = 1}, EAttachLocation.KeepRelativeOffset, true)

    --UGCLog.Log("[maoyu]::OnTakeDamageTarget")
    -- 遍历所有目标并处理
    --for _, Monster in ipairs(Monsters) do
    local Monster = Monsters[1]
    if UE.IsValid(Monster) then
        UGCSoundManagerSystem.PlaySoundAttachActor(AttackSound, Monster, true)
        UGCGameSystem.ApplyDamage(Monster, Damage, self:GetNetOwnerActor():GetInstigatorController(), self:GetNetOwnerActor(), EDamageType.STPointDamage)
        --UGCLog.Log("[maoyu]::OnTakeDamageTarget" ,self:GetNetOwnerActor():GetInstigatorController(),self:GetNetOwnerActor())
    end
    --end
end

return TuYang_WindMoveGreenSkill_P_4_4