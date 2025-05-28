---@class KuangZhanAI_C:MobAIController
--Edit Below--
local KuangZhanAI = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    KuangZhanAI.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function KuangZhanAI:OnUnpossess(UnpossessedPawn)
    KuangZhanAI.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return KuangZhanAI