---@class TuYang_SpeedMoveBlueSkill_P_4_5_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_SpeedMoveBlueSkill_P_4_5 = {}
 
function TuYang_SpeedMoveBlueSkill_P_4_5:OnEnableSkill_BP()
    TuYang_SpeedMoveBlueSkill_P_4_5.SuperClass.OnEnableSkill_BP(self)
    self.isSpeedBoostCooldown = false  -- 确保技能启用时初始状态正常
end

function TuYang_SpeedMoveBlueSkill_P_4_5:OnDisableSkill_BP()
    TuYang_SpeedMoveBlueSkill_P_4_5.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_SpeedMoveBlueSkill_P_4_5:OnActivateSkill_BP()
    TuYang_SpeedMoveBlueSkill_P_4_5.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_SpeedMoveBlueSkill_P_4_5:OnDeActivateSkill_BP()
    TuYang_SpeedMoveBlueSkill_P_4_5.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_SpeedMoveBlueSkill_P_4_5:CanActivateSkill_BP()
    return TuYang_SpeedMoveBlueSkill_P_4_5.SuperClass.CanActivateSkill_BP(self)
end

function TuYang_SpeedMoveBlueSkill_P_4_5:OnCheckSpeedInc()

    -- 新增冷却状态检测
    if self.isSpeedBoostCooldown then return end  -- 如果技能处于冷却状态，直接返回

    -- 调用方法获取原始速度增量
    local origSpeedScale = UGCPawnAttrSystem.GetSpeedScale(self:GetNetOwnerActor())
    -- 设置加速并标记冷却状态
    UGCPawnAttrSystem.SetSpeedScale(self:GetNetOwnerActor(), origSpeedScale * 1.35)
    self.isSpeedBoostCooldown = true

    -- 定时器结束后重置
    Timer.InsertTimer(5.0, function()
        local modifiedSpeedScale = UGCPawnAttrSystem.GetSpeedScale(self:GetNetOwnerActor())
        UGCPawnAttrSystem.SetSpeedScale(self:GetNetOwnerActor(), modifiedSpeedScale / 1.35)
        self.isSpeedBoostCooldown = false  -- 解除冷却状态
    end, false)
end

return TuYang_SpeedMoveBlueSkill_P_4_5