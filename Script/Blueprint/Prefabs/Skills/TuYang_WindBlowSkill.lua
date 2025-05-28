---@class TuYang_WindBlowSkill_C:PESkillTemplate_Indicate_C
--Edit Below--
local TuYang_WindBlowSkill = {}
 
function TuYang_WindBlowSkill:OnEnableSkill_BP()
    TuYang_WindBlowSkill.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_WindBlowSkill:OnDisableSkill_BP()
    TuYang_WindBlowSkill.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_WindBlowSkill:OnActivateSkill_BP()
    TuYang_WindBlowSkill.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_WindBlowSkill:OnDeActivateSkill_BP()
    TuYang_WindBlowSkill.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_WindBlowSkill:CanActivateSkill_BP()
    return TuYang_WindBlowSkill.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_WindBlowSkill