---@class TuYang_WoodRateGreenSkill_P_2_9_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_WoodRateGreenSkill_P_2_9 = {}
 
function TuYang_WoodRateGreenSkill_P_2_9:SetSkillDirection()
    ugcprint("[maoyu] TuYang_WoodRateGreenSkill_P_2_9:SetSkillDirection")

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

function TuYang_WoodRateGreenSkill_P_2_9:OnEnableSkill_BP()
    TuYang_WoodRateGreenSkill_P_2_9.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_WoodRateGreenSkill_P_2_9:OnDisableSkill_BP()
    TuYang_WoodRateGreenSkill_P_2_9.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_WoodRateGreenSkill_P_2_9:OnActivateSkill_BP()
    TuYang_WoodRateGreenSkill_P_2_9.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_WoodRateGreenSkill_P_2_9:OnDeActivateSkill_BP()
    TuYang_WoodRateGreenSkill_P_2_9.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_WoodRateGreenSkill_P_2_9:CanActivateSkill_BP()
    return TuYang_WoodRateGreenSkill_P_2_9.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_WoodRateGreenSkill_P_2_9