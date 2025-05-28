---@class BP_Scorpion_AIController_C:BP_YXAIController_C
--Edit Below--
local BP_Scorpion_AIController = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    BP_Scorpion_AIController.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function BP_Scorpion_AIController:OnUnpossess(UnpossessedPawn)
    BP_Scorpion_AIController.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return BP_Scorpion_AIController