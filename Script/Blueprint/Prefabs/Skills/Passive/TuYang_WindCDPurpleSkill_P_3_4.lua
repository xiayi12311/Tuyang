---@class TuYang_WindCDPurpleSkill_P_3_4_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_WindCDPurpleSkill_P_3_4 = {}
 
function TuYang_WindCDPurpleSkill_P_3_4:OnEnableSkill_BP()
    TuYang_WindCDPurpleSkill_P_3_4.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_WindCDPurpleSkill_P_3_4:OnDisableSkill_BP()
    TuYang_WindCDPurpleSkill_P_3_4.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_WindCDPurpleSkill_P_3_4:OnActivateSkill_BP()
    TuYang_WindCDPurpleSkill_P_3_4.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_WindCDPurpleSkill_P_3_4:OnDeActivateSkill_BP()
    TuYang_WindCDPurpleSkill_P_3_4.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_WindCDPurpleSkill_P_3_4:CanActivateSkill_BP()
    return TuYang_WindCDPurpleSkill_P_3_4.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_WindCDPurpleSkill_P_3_4