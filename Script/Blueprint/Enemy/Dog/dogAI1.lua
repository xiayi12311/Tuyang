---@class InsectAI_C:MobAIController
--Edit Below--
local InsectAI = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    InsectAI.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function InsectAI:OnUnpossess(UnpossessedPawn)
    InsectAI.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return InsectAI