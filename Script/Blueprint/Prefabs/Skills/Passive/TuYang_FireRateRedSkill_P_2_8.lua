---@class TuYang_FireRateRedSkill_P_2_8_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_FireRateRedSkill_P_2_8 = {}
 
function TuYang_FireRateRedSkill_P_2_8:OnEnableSkill_BP()
    TuYang_FireRateRedSkill_P_2_8.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_FireRateRedSkill_P_2_8:OnDisableSkill_BP()
    TuYang_FireRateRedSkill_P_2_8.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_FireRateRedSkill_P_2_8:OnActivateSkill_BP()
    TuYang_FireRateRedSkill_P_2_8.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_FireRateRedSkill_P_2_8:OnDeActivateSkill_BP()
    TuYang_FireRateRedSkill_P_2_8.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_FireRateRedSkill_P_2_8:CanActivateSkill_BP()
    return TuYang_FireRateRedSkill_P_2_8.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_FireRateRedSkill_P_2_8