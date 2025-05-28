---@class TuYang_LightCDGreenSkill_P_3_3_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_LightCDGreenSkill_P_3_3 = {}
 

function TuYang_LightCDGreenSkill_P_3_3:SetSkillDirection()
    ugcprint("[maoyu] TuYang_LightCDGreenSkill_P_3_3:SetSkillDirection")

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

function TuYang_LightCDGreenSkill_P_3_3:OnEnableSkill_BP()
    TuYang_LightCDGreenSkill_P_3_3.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_LightCDGreenSkill_P_3_3:OnDisableSkill_BP()
    TuYang_LightCDGreenSkill_P_3_3.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_LightCDGreenSkill_P_3_3:OnActivateSkill_BP()
    TuYang_LightCDGreenSkill_P_3_3.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_LightCDGreenSkill_P_3_3:OnDeActivateSkill_BP()
    TuYang_LightCDGreenSkill_P_3_3.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_LightCDGreenSkill_P_3_3:CanActivateSkill_BP()
    return TuYang_LightCDGreenSkill_P_3_3.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_LightCDGreenSkill_P_3_3