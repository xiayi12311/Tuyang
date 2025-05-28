local RecoveryAction = {}

function RecoveryAction:OnReset()
    ugcprint("mySkillAction:OnReset")
    local SkillPawn = self:GetOwnerPawn()
    SkillPawn.SetHasShieldEnd();
    return true
end

--Action每一帧调用
function RecoveryAction:OnUpdateAction(DeltaSeconds)
    ugcprint("mySkillAction:OnUpdateAction")
    return true
end

--Action开始执行调用
function RecoveryAction:OnRealDoAction()
    ugcprint("mySkillAction:OnRealDoAction")
    local SkillPawn = self:GetOwnerPawn()
    SkillPawn:SetHasShieldOn();
    return true
end
--[[
function RecoveryAction:ReceiveBeginPlay()
    RecoveryAction.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function RecoveryAction:ReceiveTick(DeltaTime)
    RecoveryAction.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function RecoveryAction:ReceiveEndPlay()
    RecoveryAction.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function RecoveryAction:GetReplicatedProperties()
    return
end
--]]

--[[
function RecoveryAction:GetAvailableServerRPCs()
    return
end
--]]

return RecoveryAction