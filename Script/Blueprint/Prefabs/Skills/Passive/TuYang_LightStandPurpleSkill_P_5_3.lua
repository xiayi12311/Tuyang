---@class TuYang_LightStandPurpleSkill_P_5_3_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_LightStandPurpleSkill_P_5_3 = {}
 
function TuYang_LightStandPurpleSkill_P_5_3:OnEnableSkill_BP()
    TuYang_LightStandPurpleSkill_P_5_3.SuperClass.OnEnableSkill_BP(self)
    return true
end

function TuYang_LightStandPurpleSkill_P_5_3:OnDisableSkill_BP()
    TuYang_LightStandPurpleSkill_P_5_3.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_LightStandPurpleSkill_P_5_3:OnActivateSkill_BP()
    TuYang_LightStandPurpleSkill_P_5_3.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_LightStandPurpleSkill_P_5_3:OnDeActivateSkill_BP()
    TuYang_LightStandPurpleSkill_P_5_3.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_LightStandPurpleSkill_P_5_3:CanActivateSkill_BP()
    return TuYang_LightStandPurpleSkill_P_5_3.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_LightStandPurpleSkill_P_5_3