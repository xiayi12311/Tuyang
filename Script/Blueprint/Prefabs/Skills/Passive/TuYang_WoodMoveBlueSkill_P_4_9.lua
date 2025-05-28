---@class TuYang_WoodMoveBlueSkill_P_4_9_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_WoodMoveBlueSkill_P_4_9 = {}
 
function TuYang_WoodMoveBlueSkill_P_4_9:OnEnableSkill_BP()
    TuYang_WoodMoveBlueSkill_P_4_9.SuperClass.OnEnableSkill_BP(self)
    UGCLog.Log("[maoyu]:TuYang_WoodMoveBlueSkill_P_4_9:OnEnableSkill_BP")
    return true
end

function TuYang_WoodMoveBlueSkill_P_4_9:OnDisableSkill_BP()
    TuYang_WoodMoveBlueSkill_P_4_9.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_WoodMoveBlueSkill_P_4_9:OnActivateSkill_BP()
    TuYang_WoodMoveBlueSkill_P_4_9.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_WoodMoveBlueSkill_P_4_9:OnDeActivateSkill_BP()
    TuYang_WoodMoveBlueSkill_P_4_9.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_WoodMoveBlueSkill_P_4_9:CanActivateSkill_BP()
    return TuYang_WoodMoveBlueSkill_P_4_9.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_WoodMoveBlueSkill_P_4_9