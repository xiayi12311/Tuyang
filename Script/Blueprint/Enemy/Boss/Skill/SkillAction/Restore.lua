---@class Restore_C:UAESkillActionBP
--Edit Below--
local Restore = {}
 

function Restore:OnRealDoAction()
    ugcprint("restore Start")
    local SkillPawn = self:GetOwnerPawn()
    SkillPawn.SetShield()
    return true
end
function Restore:ReceiveBeginPlay()
    Restore.SuperClass.ReceiveBeginPlay(self)
    ugcprint("restore Start")
    local SkillPawn = self:GetOwnerPawn()

    SkillPawn.SetShield()
end



-- function Restore:ReceiveTick(DeltaTime)
--     Restore.SuperClass.ReceiveTick(self, DeltaTime)
-- end



-- function Restore:ReceiveEndPlay()
--     Restore.SuperClass.ReceiveEndPlay(self) 
-- end


-- --[[
-- function Restore:GetReplicatedProperties()
--     return
-- end
-- --]]

-- --[[
-- function Restore:GetAvailableServerRPCs()
--     return
-- end
-- --]]

-- function mySkillAction:OnReset()
--     print("mySkillAction:OnReset")
--     return true
-- end

-- --Action每一帧调用
-- function mySkillAction:OnUpdateAction(DeltaSeconds)
--     print("mySkillAction:OnUpdateAction")
--     return true
-- end

-- --Action开始执行调用
-- function mySkillAction:OnRealDoAction()
--     print("mySkillAction:OnRealDoAction")
--     return true
-- end
-- return Restore