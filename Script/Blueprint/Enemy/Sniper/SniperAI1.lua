---@class SniperAI1_C:MobAIController
--Edit Below--
local SniperAI = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    SniperAI.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function SniperAI:OnUnpossess(UnpossessedPawn)
    SniperAI.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return SniperAI