---@class TuYang_WPRateBlueSkill_P_2_6_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_WPRateBlueSkill_P_2_6 = {}
 
function TuYang_WPRateBlueSkill_P_2_6:OnEnableSkill_BP()
    TuYang_WPRateBlueSkill_P_2_6.SuperClass.OnEnableSkill_BP(self)
    return true
end

function TuYang_WPRateBlueSkill_P_2_6:OnDisableSkill_BP()
    TuYang_WPRateBlueSkill_P_2_6.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_WPRateBlueSkill_P_2_6:OnActivateSkill_BP()
    TuYang_WPRateBlueSkill_P_2_6.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_WPRateBlueSkill_P_2_6:OnDeActivateSkill_BP()
    TuYang_WPRateBlueSkill_P_2_6.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_WPRateBlueSkill_P_2_6:CanActivateSkill_BP()
    return TuYang_WPRateBlueSkill_P_2_6.SuperClass.CanActivateSkill_BP(self)
end

function TuYang_WPRateBlueSkill_P_2_6:UrgencyReload()
    local playerController = self:GetNetOwnerActor():GetInstigatorController()
    if UE.IsValid(playerController) then
        playerController:UrgencyReload()
    end
end

return TuYang_WPRateBlueSkill_P_2_6