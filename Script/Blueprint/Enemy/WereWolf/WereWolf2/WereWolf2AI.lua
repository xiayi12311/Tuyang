---@class WereWolf2AI_C:MobAIController
--Edit Below--
local WereWolf2AI = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    WereWolf2AI.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function WereWolf2AI:OnUnpossess(UnpossessedPawn)
    WereWolf2AI.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return WereWolf2AI