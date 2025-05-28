---@class TuYang_IceRateBlueSkill_A_2_1_C:PESkillTemplate_Active_C
--Edit Below--
local TuYang_IceRateBlueSkill_A_2_1 = {}
 
--[[
function TuYang_IceRateBlueSkill_A_2_1:OnEnableSkill_BP()
end

function TuYang_IceRateBlueSkill_A_2_1:OnDisableSkill_BP(DeltaTime)
end

function TuYang_IceRateBlueSkill_A_2_1:OnActivateSkill_BP()
end

function TuYang_IceRateBlueSkill_A_2_1:OnDeActivateSkill_BP()
end

function TuYang_IceRateBlueSkill_A_2_1:CanActivateSkill_BP()
end

--]]

function TuYang_IceRateBlueSkill_A_2_1:OnActivateSkill_BP()
    TuYang_IceRateBlueSkill_A_2_1.SuperClass.OnActivateSkill_BP(self);
end

function TuYang_IceRateBlueSkill_A_2_1:OnDeActivateSkill_BP()
    TuYang_IceRateBlueSkill_A_2_1.SuperClass.OnDeActivateSkill_BP(self);
end

return TuYang_IceRateBlueSkill_A_2_1