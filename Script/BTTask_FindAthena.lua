---@class BTTask_FindAthena_C:BTTask_LuaBase
---@field BP_Athena FBlackboardKeySelector
--Edit Below--
local BTTask_FindAthena = BTTask_FindAthena or {}

function BTTask_FindAthena:ReceiveExecuteAI(OwnerController, ControlledPawn)
    --BTFunctionLibrary.SetBlackboardValueAsObject(self, self.BP_Athena, GameplayStatics.GetGameState(self).BP_Athena())
    self:FinishExecute(true)
end

return BTTask_FindAthena