---@class TuYang_SpeedMovePurpleSkill_P_4_7_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_SpeedMovePurpleSkill_P_4_7 = {}
 
function TuYang_SpeedMovePurpleSkill_P_4_7:OnEnableSkill_BP()
    TuYang_SpeedMovePurpleSkill_P_4_7.SuperClass.OnEnableSkill_BP(self)
    UGCLog.Log("[maoyu]TuYang_SpeedMovePurpleSkill_P_4_7:OnEnableSkill_BP")
    return true
end

function TuYang_SpeedMovePurpleSkill_P_4_7:OnDisableSkill_BP()
    TuYang_SpeedMovePurpleSkill_P_4_7.SuperClass.OnDisableSkill_BP(self)
    UGCLog.Log("[maoyu]TuYang_SpeedMovePurpleSkill_P_4_7:OnDisableSkill_BP")
end

function TuYang_SpeedMovePurpleSkill_P_4_7:OnActivateSkill_BP()
    TuYang_SpeedMovePurpleSkill_P_4_7.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_SpeedMovePurpleSkill_P_4_7:OnDeActivateSkill_BP()
    TuYang_SpeedMovePurpleSkill_P_4_7.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_SpeedMovePurpleSkill_P_4_7:CanActivateSkill_BP()
    return TuYang_SpeedMovePurpleSkill_P_4_7.SuperClass.CanActivateSkill_BP(self)
end

function TuYang_SpeedMovePurpleSkill_P_4_7:OnMoveDropRedPacket()
    UGCLog.Log("[maoyu]TuYang_SpeedMovePurpleSkill_P_4_7:OnMoveDropRedPacket")
    local playerController = self:GetNetOwnerActor():GetInstigatorController()
    if UE.IsValid(playerController) then
        playerController:MoveDropRedPacket()
    end
end

return TuYang_SpeedMovePurpleSkill_P_4_7