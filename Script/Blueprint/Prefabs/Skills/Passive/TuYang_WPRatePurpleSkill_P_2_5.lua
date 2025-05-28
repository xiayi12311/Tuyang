---@class TuYang_WPRatePurpleSkill_P_2_5_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_WPRatePurpleSkill_P_2_5 = {}
 
function TuYang_WPRatePurpleSkill_P_2_5:OnEnableSkill_BP()
    TuYang_WPRatePurpleSkill_P_2_5.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_WPRatePurpleSkill_P_2_5:OnDisableSkill_BP()
    TuYang_WPRatePurpleSkill_P_2_5.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_WPRatePurpleSkill_P_2_5:OnActivateSkill_BP()
    TuYang_WPRatePurpleSkill_P_2_5.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_WPRatePurpleSkill_P_2_5:OnDeActivateSkill_BP()
    TuYang_WPRatePurpleSkill_P_2_5.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_WPRatePurpleSkill_P_2_5:CanActivateSkill_BP()
    return TuYang_WPRatePurpleSkill_P_2_5.SuperClass.CanActivateSkill_BP(self)
end

function TuYang_WPRatePurpleSkill_P_2_5:QuickReloadTime()
    local playerController = self:GetNetOwnerActor():GetInstigatorController()
    if UE.IsValid(playerController) then
        playerController:QuickReloadTime()
    end
end

return TuYang_WPRatePurpleSkill_P_2_5