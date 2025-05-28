---@class BP_BoomRobot_AIController_C:BP_YXAIController_C
---@field AIParachuteJump UAIParachuteJumpComponent
--Edit Below--
local BP_BoomRobot_AIController = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    BP_BoomRobot_AIController.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function BP_BoomRobot_AIController:OnUnpossess(UnpossessedPawn)
    BP_BoomRobot_AIController.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return BP_BoomRobot_AIController