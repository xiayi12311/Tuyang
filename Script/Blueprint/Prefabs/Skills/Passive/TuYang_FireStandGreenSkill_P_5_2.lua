---@class TuYang_FireStandGreenSkill_P_5_2_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_FireStandGreenSkill_P_5_2 = {}
 
function TuYang_FireStandGreenSkill_P_5_2:OnEnableSkill_BP()
    TuYang_FireStandGreenSkill_P_5_2.SuperClass.OnEnableSkill_BP(self)
    return true
end

function TuYang_FireStandGreenSkill_P_5_2:OnDisableSkill_BP()
    TuYang_FireStandGreenSkill_P_5_2.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_FireStandGreenSkill_P_5_2:OnActivateSkill_BP()
    TuYang_FireStandGreenSkill_P_5_2.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_FireStandGreenSkill_P_5_2:OnDeActivateSkill_BP()
    TuYang_FireStandGreenSkill_P_5_2.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_FireStandGreenSkill_P_5_2:CanActivateSkill_BP()
    return TuYang_FireStandGreenSkill_P_5_2.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_FireStandGreenSkill_P_5_2