---@class TeslaAI6_C:MobAIController
--Edit Below--
local TeslaAI6 = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    TeslaAI6.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function TeslaAI6:OnUnpossess(UnpossessedPawn)
    TeslaAI6.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return TeslaAI6