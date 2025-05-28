---@class TuYang_WoodStandRedSkill_P_5_9_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_WoodStandRedSkill_P_5_9 = {}
 
function TuYang_WoodStandRedSkill_P_5_9:OnEnableSkill_BP()
    TuYang_WoodStandRedSkill_P_5_9.SuperClass.OnEnableSkill_BP(self)
    return true
end

function TuYang_WoodStandRedSkill_P_5_9:OnDisableSkill_BP()
    TuYang_WoodStandRedSkill_P_5_9.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_WoodStandRedSkill_P_5_9:OnActivateSkill_BP()
    TuYang_WoodStandRedSkill_P_5_9.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_WoodStandRedSkill_P_5_9:OnDeActivateSkill_BP()
    TuYang_WoodStandRedSkill_P_5_9.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_WoodStandRedSkill_P_5_9:CanActivateSkill_BP()
    return TuYang_WoodStandRedSkill_P_5_9.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_WoodStandRedSkill_P_5_9