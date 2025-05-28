---@class ZombieAI1_C:MobAIController
--Edit Below--
local ScorpionAI = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    ScorpionAI.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function ScorpionAI:OnUnpossess(UnpossessedPawn)
    ScorpionAI.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return ScorpionAI