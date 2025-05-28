---@class BP_AIC_Scientist_C:BP_YXAIController_C
--Edit Below--
local BP_AIC_Scientist = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    BP_AIC_Scientist.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function BP_AIC_Scientist:OnUnpossess(UnpossessedPawn)
    BP_AIC_Scientist.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return BP_AIC_Scientist