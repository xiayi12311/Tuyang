---@class TeslaAI3_C:MobAIController
--Edit Below--
local TeslaAI3 = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    TeslaAI3.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function TeslaAI3:OnUnpossess(UnpossessedPawn)
    TeslaAI3.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return TeslaAI3