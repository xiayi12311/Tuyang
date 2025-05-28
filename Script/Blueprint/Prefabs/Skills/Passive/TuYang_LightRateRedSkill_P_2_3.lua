---@class TuYang_LightRateRedSkill_P_2_3_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_LightRateRedSkill_P_2_3 = {}
 
function TuYang_LightRateRedSkill_P_2_3:OnEnableSkill_BP()
    TuYang_LightRateRedSkill_P_2_3.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_LightRateRedSkill_P_2_3:OnDisableSkill_BP()
    TuYang_LightRateRedSkill_P_2_3.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_LightRateRedSkill_P_2_3:OnActivateSkill_BP()
    TuYang_LightRateRedSkill_P_2_3.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_LightRateRedSkill_P_2_3:OnDeActivateSkill_BP()
    TuYang_LightRateRedSkill_P_2_3.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_LightRateRedSkill_P_2_3:CanActivateSkill_BP()
    return TuYang_LightRateRedSkill_P_2_3.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_LightRateRedSkill_P_2_3