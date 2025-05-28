---@class Jstkai_C:BP_JSTK_Controller_C
--Edit Below--
local Jstkai = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    Jstkai.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function Jstkai:OnUnpossess(UnpossessedPawn)
    Jstkai.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return Jstkai