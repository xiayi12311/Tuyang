---@class TuYang_IceStandRedSkill_P_5_1_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_IceStandRedSkill_P_5_1 = {}
 
function TuYang_IceStandRedSkill_P_5_1:OnEnableSkill_BP()
    TuYang_IceStandRedSkill_P_5_1.SuperClass.OnEnableSkill_BP(self)
    return true
end

function TuYang_IceStandRedSkill_P_5_1:OnDisableSkill_BP()
    TuYang_IceStandRedSkill_P_5_1.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_IceStandRedSkill_P_5_1:OnActivateSkill_BP()
    TuYang_IceStandRedSkill_P_5_1.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_IceStandRedSkill_P_5_1:OnDeActivateSkill_BP()
    TuYang_IceStandRedSkill_P_5_1.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_IceStandRedSkill_P_5_1:CanActivateSkill_BP()
    return TuYang_IceStandRedSkill_P_5_1.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_IceStandRedSkill_P_5_1