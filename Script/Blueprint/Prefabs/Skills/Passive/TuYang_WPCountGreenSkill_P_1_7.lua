---@class TuYang_WPCountGreenSkill_P_1_7_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_WPCountGreenSkill_P_1_7 = {}
 
function TuYang_WPCountGreenSkill_P_1_7:OnEnableSkill_BP()
    TuYang_WPCountGreenSkill_P_1_7.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_WPCountGreenSkill_P_1_7:OnDisableSkill_BP()
    TuYang_WPCountGreenSkill_P_1_7.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_WPCountGreenSkill_P_1_7:OnActivateSkill_BP()
    TuYang_WPCountGreenSkill_P_1_7.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_WPCountGreenSkill_P_1_7:OnDeActivateSkill_BP()
    TuYang_WPCountGreenSkill_P_1_7.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_WPCountGreenSkill_P_1_7:CanActivateSkill_BP()
    return TuYang_WPCountGreenSkill_P_1_7.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_WPCountGreenSkill_P_1_7