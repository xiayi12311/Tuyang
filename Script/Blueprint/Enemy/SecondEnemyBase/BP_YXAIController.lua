---@class BP_YXAIController_C:MobAIController
--Edit Below--
local BP_YXAIController = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    BP_YXAIController.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function BP_YXAIController:OnUnpossess(UnpossessedPawn)
    BP_YXAIController.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return BP_YXAIController