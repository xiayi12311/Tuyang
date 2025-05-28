local BPBuff_AthenaHealthRecoverWhenPeace = {}

BPBuff_AthenaHealthRecoverWhenPeace.HelathToRecover = 20

BPBuff_AthenaHealthRecoverWhenPeace.HelathToRecoverThresholdMilliseconds = 2000

function BPBuff_AthenaHealthRecoverWhenPeace:LuaDoAction()
    local Athena = self:GetOwnerPawn()

    sandbox.LogNormalDev(
        StringFormat_Dev(
            "[BPBuff_AthenaHealthRecoverWhenPeace:LuaDoAction] self=%s Athena=%s CurrentHp=%s MaxHp=%s HelathToRecover=%s", 
            GetObjectFullName_Dev(self), 
            GetObjectFullName_Dev(Athena), 
            ToString_Dev(Athena.CurrentHp), 
            ToString_Dev(Athena.MaxHp), 
            ToString_Dev(self.HelathToRecover)
        )
    )

    Athena.CurrentHp = math.min(Athena.MaxHp, Athena.CurrentHp + self.HelathToRecover)
    Athena:OnRep_CurrentHp()

    return true
end

function BPBuff_AthenaHealthRecoverWhenPeace:IsConditionOK()
    local Athena = self:GetOwnerPawn()
    local CurrentHp = Athena.CurrentHp
    local MaxHp = Athena.MaxHp
    local UnderAttackUtcNowUnixTimestampMillseconds = Athena.UnderAttackUtcNowUnixTimestampMillseconds
    local UtcNowUnixTimestampMillseconds = STExtraBlueprintFunctionLibrary.GetUtcNowUnixTimestampMillseconds()
    local bConditionOk = UtcNowUnixTimestampMillseconds - UnderAttackUtcNowUnixTimestampMillseconds >= self.HelathToRecoverThresholdMilliseconds
     and CurrentHp < MaxHp

    sandbox.LogNormalDev(
        StringFormat_Dev(
            "[BPBuff_AthenaHealthRecoverWhenPeace:IsConditionOK] self=%s Athena=%s CurrentHp=%s MaxHp=%s UnderAttackUtcNowUnixTimestampMillseconds=%s UtcNowUnixTimestampMillseconds=%s bConditionOk=%s", 
            GetObjectFullName_Dev(self), 
            GetObjectFullName_Dev(Athena), 
            ToString_Dev(CurrentHp), 
            ToString_Dev(MaxHp), 
            ToString_Dev(UnderAttackUtcNowUnixTimestampMillseconds), 
            ToString_Dev(UtcNowUnixTimestampMillseconds), 
            ToString_Dev(bConditionOk)
        )
    )
    
    return bConditionOk
end

return BPBuff_AthenaHealthRecoverWhenPeace