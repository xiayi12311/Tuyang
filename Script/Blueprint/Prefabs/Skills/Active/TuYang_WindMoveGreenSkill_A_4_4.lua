---@class TuYang_WindMoveGreenSkill_A_4_4_C:PESkillTemplate_Active_C
--Edit Below--
local TuYang_WindMoveGreenSkill_A_4_4 = {}
 
function TuYang_WindMoveGreenSkill_A_4_4:OnEnableSkill_BP()
    TuYang_WindMoveGreenSkill_A_4_4.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_WindMoveGreenSkill_A_4_4:OnDisableSkill_BP()
    TuYang_WindMoveGreenSkill_A_4_4.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_WindMoveGreenSkill_A_4_4:OnActivateSkill_BP()
    TuYang_WindMoveGreenSkill_A_4_4.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_WindMoveGreenSkill_A_4_4:OnDeActivateSkill_BP()
    TuYang_WindMoveGreenSkill_A_4_4.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_WindMoveGreenSkill_A_4_4:CanActivateSkill_BP()
    return TuYang_WindMoveGreenSkill_A_4_4.SuperClass.CanActivateSkill_BP(self)
end

function TuYang_WindMoveGreenSkill_A_4_4:OnTakeDamageTarget()

    local Monsters = self:GetSelectTargetActor(EPESkillSelectTarget.E_PESKILL_PickerType_AllTarget)
    if not Monsters or #Monsters == 0 then
        UGCLog.Log("[maoyu]:TuYang_WindMoveGreenSkill_A_4_4:OnTakeDamageTarget - No valid targets found")
        return
    end

    local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill4_4",self:GetNetOwnerActor())

    -- 遍历所有目标并处理
    for _, Monster in ipairs(Monsters) do
        if UE.IsValid(Monster) then
            UGCGameSystem.ApplyDamage(Monster, finallyDamage, self:GetNetOwnerActor():GetInstigatorController(), self:GetNetOwnerActor(), EDamageType.STPointDamage)
            --UGCLog.Log("[maoyu]::OnTakeDamageTarget" ,self:GetNetOwnerActor():GetInstigatorController(),self:GetNetOwnerActor())
        end
    end
end

return TuYang_WindMoveGreenSkill_A_4_4