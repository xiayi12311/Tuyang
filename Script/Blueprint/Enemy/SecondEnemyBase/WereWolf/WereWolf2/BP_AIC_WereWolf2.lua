---@class BP_AIC_WereWolf2_C:BP_YXAIController_C
--Edit Below--
local BP_AIC_WereWolf2 = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    BP_AIC_WereWolf2.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function BP_AIC_WereWolf2:OnUnpossess(UnpossessedPawn)
    BP_AIC_WereWolf2.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return BP_AIC_WereWolf2