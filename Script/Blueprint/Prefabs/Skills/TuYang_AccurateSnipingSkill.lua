---@class TuYang_AccurateSnipingSkill_C:PESkillTemplate_Indicate_C
--Edit Below--
local TuYang_AccurateSnipingSkill = {}
 
function TuYang_AccurateSnipingSkill:OnEnableSkill_BP()
    TuYang_AccurateSnipingSkill.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_AccurateSnipingSkill:OnDisableSkill_BP()
    TuYang_AccurateSnipingSkill.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_AccurateSnipingSkill:OnActivateSkill_BP()
    TuYang_AccurateSnipingSkill.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_AccurateSnipingSkill:OnDeActivateSkill_BP()
    TuYang_AccurateSnipingSkill.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_AccurateSnipingSkill:CanActivateSkill_BP()
    return TuYang_AccurateSnipingSkill.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_AccurateSnipingSkill