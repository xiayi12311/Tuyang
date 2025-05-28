---@class TuYang_LightMovePurpleSkill_A_4_3_C:PESkillTemplate_Active_C
--Edit Below--
local TuYang_LightMovePurpleSkill_A_4_3 = {}
 
function TuYang_LightMovePurpleSkill_A_4_3:OnEnableSkill_BP()
    TuYang_LightMovePurpleSkill_A_4_3.SuperClass.OnEnableSkill_BP(self)
    
    return true
end

function TuYang_LightMovePurpleSkill_A_4_3:OnDisableSkill_BP()
    TuYang_LightMovePurpleSkill_A_4_3.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_LightMovePurpleSkill_A_4_3:OnActivateSkill_BP()
    TuYang_LightMovePurpleSkill_A_4_3.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_LightMovePurpleSkill_A_4_3:OnDeActivateSkill_BP()
    TuYang_LightMovePurpleSkill_A_4_3.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_LightMovePurpleSkill_A_4_3:CanActivateSkill_BP()
    return TuYang_LightMovePurpleSkill_A_4_3.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_LightMovePurpleSkill_A_4_3