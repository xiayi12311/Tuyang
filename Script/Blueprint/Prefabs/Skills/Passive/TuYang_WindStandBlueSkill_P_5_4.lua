---@class TuYang_WindStandBlueSkill_P_5_4_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_WindStandBlueSkill_P_5_4 = {}
 
function TuYang_WindStandBlueSkill_P_5_4:OnEnableSkill_BP()
    TuYang_WindStandBlueSkill_P_5_4.SuperClass.OnEnableSkill_BP(self)
    return true
end

function TuYang_WindStandBlueSkill_P_5_4:OnDisableSkill_BP()
    TuYang_WindStandBlueSkill_P_5_4.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_WindStandBlueSkill_P_5_4:OnActivateSkill_BP()
    TuYang_WindStandBlueSkill_P_5_4.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_WindStandBlueSkill_P_5_4:OnDeActivateSkill_BP()
    TuYang_WindStandBlueSkill_P_5_4.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_WindStandBlueSkill_P_5_4:CanActivateSkill_BP()
    return TuYang_WindStandBlueSkill_P_5_4.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_WindStandBlueSkill_P_5_4