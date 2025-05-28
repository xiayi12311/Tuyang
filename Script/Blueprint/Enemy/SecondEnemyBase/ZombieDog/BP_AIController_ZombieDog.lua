---@class BP_AIController_ZombieDog_C:MobAIController
--Edit Below--
local BP_AIController_ZombieDog = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    BP_AIController_ZombieDog.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function BP_AIController_ZombieDog:OnUnpossess(UnpossessedPawn)
    BP_AIController_ZombieDog.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return BP_AIController_ZombieDog