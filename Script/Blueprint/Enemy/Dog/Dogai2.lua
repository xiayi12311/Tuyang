---@class Dogai2_C:BP_MobAIC_ZombieDog_C
--Edit Below--
local Dogai2 = {}
 
--[[
function ActorName:OnPossess(PossessedPawn)
    Dogai2.SuperClass.OnPossess(self, PossessedPawn)

    -- local BehaviorTree = UE.LoadObject("填入要加载的BehaviorTree资源路径")
    -- if BehaviorTree ~= nil then
        -- self:RunBehaviorTree()
    -- end
end
--]]

--[[
function Dogai2:OnUnpossess(UnpossessedPawn)
    Dogai2.SuperClass.OnUnpossess(self, UnpossessedPawn)
end
--]]

return Dogai2