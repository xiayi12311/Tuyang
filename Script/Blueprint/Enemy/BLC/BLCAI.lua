---@class BLCAI_C:MobAIController
--Edit Below--
local BLCAI = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    BLCAI.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function BLCAI:OnUnpossess(UnpossessedPawn)
    BLCAI.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return BLCAI