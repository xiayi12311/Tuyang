---@class TankAI_C:MobAIController
--Edit Below--
local TankAI = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    TankAI.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function TankAI:OnUnpossess(UnpossessedPawn)
    TankAI.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return TankAI