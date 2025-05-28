---@class TeslaAI_C:MobAIController
--Edit Below--
local TeslaAI1 = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    TeslaAI1.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function TeslaAI1:OnUnpossess(UnpossessedPawn)
    TeslaAI1.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return TeslaAI1