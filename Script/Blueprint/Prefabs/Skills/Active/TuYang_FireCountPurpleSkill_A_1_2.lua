---@class TuYang_FireCountPurpleSkill_A_1_2_C:PESkillTemplate_Active_C
--Edit Below--
local TuYang_FireCountPurpleSkill_A_1_2 = {}
 
--[[
function TuYang_FireCountPurpleSkill_A_1_2:OnEnableSkill_BP()
end

function TuYang_FireCountPurpleSkill_A_1_2:OnDisableSkill_BP(DeltaTime)
end

function TuYang_FireCountPurpleSkill_A_1_2:OnActivateSkill_BP()
end

function TuYang_FireCountPurpleSkill_A_1_2:OnDeActivateSkill_BP()
end

function TuYang_FireCountPurpleSkill_A_1_2:CanActivateSkill_BP()
end

--]]

function TuYang_FireCountPurpleSkill_A_1_2:OnActivateSkill_BP()
    TuYang_FireCountPurpleSkill_A_1_2.SuperClass.OnActivateSkill_BP(self);
end

function TuYang_FireCountPurpleSkill_A_1_2:OnDeActivateSkill_BP()
    TuYang_FireCountPurpleSkill_A_1_2.SuperClass.OnDeActivateSkill_BP(self);
end

return TuYang_FireCountPurpleSkill_A_1_2