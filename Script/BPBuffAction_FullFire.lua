local BPBuffAction_FullFire = {}

function BPBuffAction_FullFire:LuaDoAction()
    local OwnerPawn = self:GetOwnerPawn()

    sandbox.LogNormalDev(
        StringFormat_Dev(
            "[BPBuff_AthenaHealthRecoverWhenPeace:LuaDoAction] self=%s OwnerPawn=%s DamageScaleValue=%s", 
            GetObjectFullName_Dev(self), 
            GetObjectFullName_Dev(OwnerPawn), 
            ToString_Dev(OwnerPawn.DamageScaleValue)
        )
    )

    OwnerPawn.DamageScaleValue = OwnerPawn.DamageScaleValue + 1

    return true
end

function BPBuffAction_FullFire:LuaUndoAction()
    local OwnerPawn = self:GetOwnerPawn()

    sandbox.LogNormalDev(
        StringFormat_Dev(
            "[BPBuff_AthenaHealthRecoverWhenPeace:LuaUndoAction] self=%s OwnerPawn=%s DamageScaleValue=%s", 
            GetObjectFullName_Dev(self), 
            GetObjectFullName_Dev(OwnerPawn), 
            ToString_Dev(OwnerPawn.DamageScaleValue)
        )
    )

    OwnerPawn.DamageScaleValue = OwnerPawn.DamageScaleValue - 1
end

return BPBuffAction_FullFire