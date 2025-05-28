---@class TeslaAI4_C:MobAIController
--Edit Below--
local TeslaAI4 = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    TeslaAI4.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function TeslaAI4:OnUnpossess(UnpossessedPawn)
    TeslaAI4.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return TeslaAI4