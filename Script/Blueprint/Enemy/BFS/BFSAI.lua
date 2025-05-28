---@class BFSAI_C:MobAIController
--Edit Below--
local BFSAI = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    BFSAI.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function BFSAI:OnUnpossess(UnpossessedPawn)
    BFSAI.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return BFSAI