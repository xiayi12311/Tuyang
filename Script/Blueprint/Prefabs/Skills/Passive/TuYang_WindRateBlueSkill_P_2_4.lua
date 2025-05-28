---@class TuYang_WindRateBlueSkill_P_2_4_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_WindRateBlueSkill_P_2_4 = {}

function TuYang_WindRateBlueSkill_P_2_4:SetSkillDirection()
    ugcprint("[maoyu] TuYang_WindRateBlueSkill_P_2_4:SetSkillDirection")

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
 
function TuYang_WindRateBlueSkill_P_2_4:OnEnableSkill_BP()
    TuYang_WindRateBlueSkill_P_2_4.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_WindRateBlueSkill_P_2_4:OnDisableSkill_BP()
    TuYang_WindRateBlueSkill_P_2_4.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_WindRateBlueSkill_P_2_4:OnActivateSkill_BP()
    TuYang_WindRateBlueSkill_P_2_4.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_WindRateBlueSkill_P_2_4:OnDeActivateSkill_BP()
    TuYang_WindRateBlueSkill_P_2_4.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_WindRateBlueSkill_P_2_4:CanActivateSkill_BP()
    return TuYang_WindRateBlueSkill_P_2_4.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_WindRateBlueSkill_P_2_4