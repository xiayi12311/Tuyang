---@class TuYang_WPCountGreenSkill_P_1_5_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_WPCountGreenSkill_P_1_5 = {}
 
function TuYang_WPCountGreenSkill_P_1_5:OnEnableSkill_BP()
    TuYang_WPCountGreenSkill_P_1_5.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_WPCountGreenSkill_P_1_5:OnDisableSkill_BP()
    TuYang_WPCountGreenSkill_P_1_5.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_WPCountGreenSkill_P_1_5:OnActivateSkill_BP()
    TuYang_WPCountGreenSkill_P_1_5.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_WPCountGreenSkill_P_1_5:OnDeActivateSkill_BP()
    TuYang_WPCountGreenSkill_P_1_5.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_WPCountGreenSkill_P_1_5:CanActivateSkill_BP()
    return TuYang_WPCountGreenSkill_P_1_5.SuperClass.CanActivateSkill_BP(self)
end

function TuYang_WPCountGreenSkill_P_1_5:IncShootIntervalTime()
    local playerController = self:GetNetOwnerActor():GetInstigatorController()
    if UE.IsValid(playerController) then
        playerController:IncShootIntervalTime()
    end
end

return TuYang_WPCountGreenSkill_P_1_5