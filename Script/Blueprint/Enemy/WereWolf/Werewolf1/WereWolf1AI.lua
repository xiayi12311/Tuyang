---@class WereWolf1AI_C:MobAIController
--Edit Below--
local WereWolf1AI = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    WereWolf1AI.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function WereWolf1AI:OnUnpossess(UnpossessedPawn)
    WereWolf1AI.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return WereWolf1AI