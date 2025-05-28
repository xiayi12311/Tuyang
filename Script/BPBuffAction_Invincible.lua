local BPBuffAction_Invincible = {}

function BPBuffAction_Invincible:LuaDoAction()
    local OwnerPawn = self:GetOwnerPawn()

    sandbox.LogNormalDev(
        StringFormat_Dev(
            "[BPBuffAction_Invincible:LuaDoAction] self=%s OwnerPawn=%s bInvincible=%s", 
            GetObjectFullName_Dev(self), 
            GetObjectFullName_Dev(OwnerPawn), 
            ToString_Dev(OwnerPawn.bInvincible)
        )
    )
    
    OwnerPawn.bInvincible = true

    return true
end

function BPBuffAction_Invincible:LuaUndoAction()
    local OwnerPawn = self:GetOwnerPawn()

    sandbox.LogNormalDev(
        StringFormat_Dev(
            "[BPBuffAction_Invincible:LuaUndoAction] self=%s OwnerPawn=%s bInvincible=%s", 
            GetObjectFullName_Dev(self), 
            GetObjectFullName_Dev(OwnerPawn), 
            ToString_Dev(OwnerPawn.bInvincible)
        )
    )

    OwnerPawn.bInvincible = false
end

return BPBuffAction_Invincible