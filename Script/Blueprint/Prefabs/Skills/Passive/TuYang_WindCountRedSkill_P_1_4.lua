---@class TuYang_WindCountRedSkill_P_1_4_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_WindCountRedSkill_P_1_4 = {}
 
function TuYang_WindCountRedSkill_P_1_4:OnEnableSkill_BP()
    TuYang_WindCountRedSkill_P_1_4.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_WindCountRedSkill_P_1_4:OnDisableSkill_BP()
    TuYang_WindCountRedSkill_P_1_4.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_WindCountRedSkill_P_1_4:OnActivateSkill_BP()
    TuYang_WindCountRedSkill_P_1_4.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_WindCountRedSkill_P_1_4:OnDeActivateSkill_BP()
    TuYang_WindCountRedSkill_P_1_4.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_WindCountRedSkill_P_1_4:CanActivateSkill_BP()
    return TuYang_WindCountRedSkill_P_1_4.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_WindCountRedSkill_P_1_4