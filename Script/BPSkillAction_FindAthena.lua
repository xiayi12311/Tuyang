---@class BPSkillAction_FindAthena_C:UAESkillActionBP
---@field Athena FUAEBlackboardKeySelector
--Edit Below--
local BPSkillAction_FindAthena = {}

function BPSkillAction_FindAthena:OnRealDoAction()
    local GameState = GameplayStatics.GetGameState(self)
    -- self:SetValueAsWeakObject(self.Athena, GameState.BP_Athena())

    -- sandbox.LogNormalDev(StringFormat_Dev("[BPSkillAction_FindAthena:OnRealDoAction] self=%s GameState=%s Athena=%s", GetObjectFullName_Dev(self), GetObjectFullName_Dev(GameState), GetObjectFullName_Dev(GameState.BP_Athena())))

    return true
end

return BPSkillAction_FindAthena