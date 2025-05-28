---@class TuYang_WPCountBlueSkill_P_1_6_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_WPCountBlueSkill_P_1_6 = {}
 
function TuYang_WPCountBlueSkill_P_1_6:OnEnableSkill_BP()
    TuYang_WPCountBlueSkill_P_1_6.SuperClass.OnEnableSkill_BP(self)
    return true
end

function TuYang_WPCountBlueSkill_P_1_6:OnDisableSkill_BP()
    TuYang_WPCountBlueSkill_P_1_6.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_WPCountBlueSkill_P_1_6:OnActivateSkill_BP()
    TuYang_WPCountBlueSkill_P_1_6.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_WPCountBlueSkill_P_1_6:OnDeActivateSkill_BP()
    TuYang_WPCountBlueSkill_P_1_6.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_WPCountBlueSkill_P_1_6:CanActivateSkill_BP()
    return TuYang_WPCountBlueSkill_P_1_6.SuperClass.CanActivateSkill_BP(self)
end

function TuYang_WPCountBlueSkill_P_1_6:IncBulletNumInOneClip()
    local playerController = self:GetNetOwnerActor():GetInstigatorController()
    if UE.IsValid(playerController) then
        playerController:IncBulletNumInOneClip()
    end
end

return TuYang_WPCountBlueSkill_P_1_6