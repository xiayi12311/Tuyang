---@class TeslaAI2_C:MobAIController
--Edit Below--
local TeslaAI2 = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    TeslaAI2.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function TeslaAI2:OnUnpossess(UnpossessedPawn)
    TeslaAI2.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return TeslaAI2