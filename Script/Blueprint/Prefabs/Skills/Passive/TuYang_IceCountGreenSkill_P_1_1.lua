---@class TuYang_IceCountGreenSkill_P_1_1_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_IceCountGreenSkill_P_1_1 = {}

function TuYang_IceCountGreenSkill_P_1_1:SetSkillDirection()
    ugcprint("[maoyu] TuYang_IceCountGreenSkill_P_1_1:SetSkillDirection")

    local ownerActor = self:GetNetOwnerActor()
    if not ownerActor then
        ugcprint("[maoyu Error] OwnerActor is nil!")
        return
    end
    -- 添加控制器有效性检查
    local controller = ownerActor:GetInstigatorController()
    if not controller then
        ugcprint("[maoyu Error] Controller is nil!")
        return
    end
    
    local forwardVector = controller:GetActorForwardVector()
    self:SetSelectDirection(forwardVector)
end
 
function TuYang_IceCountGreenSkill_P_1_1:OnEnableSkill_BP()
    TuYang_IceCountGreenSkill_P_1_1.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_IceCountGreenSkill_P_1_1:OnDisableSkill_BP()
    TuYang_IceCountGreenSkill_P_1_1.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_IceCountGreenSkill_P_1_1:OnActivateSkill_BP()
    TuYang_IceCountGreenSkill_P_1_1.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_IceCountGreenSkill_P_1_1:OnDeActivateSkill_BP()
    TuYang_IceCountGreenSkill_P_1_1.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_IceCountGreenSkill_P_1_1:CanActivateSkill_BP()
    return TuYang_IceCountGreenSkill_P_1_1.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_IceCountGreenSkill_P_1_1