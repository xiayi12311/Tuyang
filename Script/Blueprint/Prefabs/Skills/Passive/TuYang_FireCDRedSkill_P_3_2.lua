---@class TuYang_FireCDRedSkill_P_3_2_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_FireCDRedSkill_P_3_2 = {}
 
function TuYang_FireCDRedSkill_P_3_2:SetSkillDirection()
    ugcprint("[maoyu] TuYang_FireCDRedSkill_P_3_2:SetSkillDirection")

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

function TuYang_FireCDRedSkill_P_3_2:OnEnableSkill_BP()
    TuYang_FireCDRedSkill_P_3_2.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_FireCDRedSkill_P_3_2:OnDisableSkill_BP()
    TuYang_FireCDRedSkill_P_3_2.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_FireCDRedSkill_P_3_2:OnActivateSkill_BP()
    TuYang_FireCDRedSkill_P_3_2.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_FireCDRedSkill_P_3_2:OnDeActivateSkill_BP()
    TuYang_FireCDRedSkill_P_3_2.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_FireCDRedSkill_P_3_2:CanActivateSkill_BP()
    return TuYang_FireCDRedSkill_P_3_2.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_FireCDRedSkill_P_3_2