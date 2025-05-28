---@class TuYang_FireCountPurpleSkill_P_1_2_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_FireCountPurpleSkill_P_1_2 = {}
 
function TuYang_FireCountPurpleSkill_P_1_2:OnEnableSkill_BP()
    TuYang_FireCountPurpleSkill_P_1_2.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_FireCountPurpleSkill_P_1_2:OnDisableSkill_BP()
    TuYang_FireCountPurpleSkill_P_1_2.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_FireCountPurpleSkill_P_1_2:OnActivateSkill_BP()
    TuYang_FireCountPurpleSkill_P_1_2.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_FireCountPurpleSkill_P_1_2:OnDeActivateSkill_BP()
    TuYang_FireCountPurpleSkill_P_1_2.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_FireCountPurpleSkill_P_1_2:CanActivateSkill_BP()
    return TuYang_FireCountPurpleSkill_P_1_2.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_FireCountPurpleSkill_P_1_2