---@class WereWolf3AI_C:MobAIController
--Edit Below--
local WereWolf3AI = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    WereWolf3AI.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function WereWolf3AI:OnUnpossess(UnpossessedPawn)
    WereWolf3AI.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return WereWolf3AI