---@class BP_Summon_C:STExtraSimpleCharacter
---@field BPProduceDropItemComponent_Summon UBPProduceDropItemComponent_Summon_C
---@field UAECharacterSkillManager UUAECharacterSkillManagerComponent
---@field HitCapsuleComponent UCapsuleComponent
---@field UAEMonsterAnimList UUAEMonsterAnimListComponent
---@field SummonRoundAttributes TArray<FS_SummonRoundAtrributes__pf1905232249>
---@field DropItemProbability float
--Edit Below--
local Delegate = require("common.Delegate")

local BP_Summon = BP_Summon or {}

--BP_Summon.CurrentHpChangedDelegate = Delegate.New()

BP_Summon.DieGold = 1000

BP_Summon.DamageReceivedDelegate = Delegate.New()

-- BP_Summon.DamageScaleValue = 1

BP_Summon.Round = 1

BP_Summon.LevelAttributes = 
{
    [1] = 
    {
        DamageAmount = 20, 
        Health = 100, 
        SpeedScale = 1.1, 
    }, 
    [2] = 
    {
        DamageAmount = 20, 
        Health = 100, 
        SpeedScale = 1.1, 
    }, 
    [3] = 
    {
        DamageAmount = 30, 
        Health = 200, 
        SpeedScale = 1.1, 
    }, 
    [4] = 
    {
        DamageAmount = 35, 
        Health = 250, 
        SpeedScale = 1.2, 
    }, 
    [5] = 
    {
        DamageAmount = 40, 
        Health = 300, 
        SpeedScale = 1.2, 
    }, 
    [6] = 
    {
        DamageAmount = 45, 
        Health = 350, 
        SpeedScale = 1.2, 
    }, 
    [7] = 
    {
        DamageAmount = 50, 
        Health = 400, 
        SpeedScale = 1.3, 
    }, 
}

--[[
function BP_Summon:GetReplicatedProperties()
    return "DamageScaleValue"
end


function BP_Summon:OnRep_CurrentHp()
    BP_Summon.SuperClass.OnRep_CurrentHp(self)
    
    self.CurrentHpChangedDelegate(self)
end
]]

function BP_Summon:ReceiveBeginPlay()
    sandbox.LogNormalDev(StringFormat_Dev("[BP_Summon:ReceiveBeginPlay] self=%s", GetObjectFullName_Dev(self)))

    BP_Summon.SuperClass.ReceiveBeginPlay(self)

    self.OnDeath:AddInstance(self.OnSelfDeath, self)
end

function BP_Summon:ReceiveEndPlay(EndPlayReason)
    sandbox.LogNormalDev(StringFormat_Dev("[BP_Summon:ReceiveEndPlay] self=%s EndPlayReason=%s", GetObjectFullName_Dev(self), ToString_Dev(EndPlayReason)))

    local GameState = GameplayStatics.GetGameState(self)
    GameState.CurrentSummonCount = GameState.CurrentSummonCount - 1
    GameState.CurrentSummonCountChangedDelegate(GameState)

    BP_Summon.SuperClass.ReceiveEndPlay(self, EndPlayReason)
end

function BP_Summon:InvalidateSummonRoundAttributes(Round)
    sandbox.LogNormalDev(StringFormat_Dev("[BP_Summon:InvalidateSummonRoundAttributes] self=%s Round=%s", GetObjectFullName_Dev(self), ToString_Dev(Round)))
    
    if Round <= self.SummonRoundAttributes:Num() then
        self.Round = Round
        local SummonRoundAttributes = self.SummonRoundAttributes[self.Round]
        if SummonRoundAttributes ~= nil then
            self.Health = SummonRoundAttributes.Health
            self.HealthMax = SummonRoundAttributes.Health
            self.SpeedScale = SummonRoundAttributes.SpeedScale
        end
    end
end

function BP_Summon:BP_CharacterModifyDamage(DamageAmount, DamageEvent, EventInstigator, DamageCauser)
    -- DamageAmount = BP_Summon.SuperClass.BP_CharacterModifyDamage(self, DamageAmount, DamageEvent, EventInstigator, DamageCauser)
    if UE.IsValid(EventInstigator) and type(EventInstigator.PreInstigatedDamage) == "function" then
        DamageAmount = EventInstigator:PreInstigatedDamage(DamageAmount, DamageEvent, DamageCauser, self)
    end
    return DamageAmount
end

function BP_Summon:PreInstigatedDamage(DamageAmount, DamageEvent, DamageCauser, Victim)
    --KismetSystemLibrary.PrintString(self, "BP_Summon:PreInstigatedDamage " .. tostring(self.DamageScaleValue) .. " " .. tostring(DamageAmount), true, true, LinearColor.New(1, 1, 1, 1), 15)

    -- return DamageAmount * self.DamageScaleValue

    if self.Round <= self.SummonRoundAttributes:Num() then
        local SummonRoundAttributes = self.SummonRoundAttributes[self.Round]
        if SummonRoundAttributes ~= nil then
            return SummonRoundAttributes.DamageAmount
        end
    end

    return DamageAmount
end

function BP_Summon:BPReceiveDamage(DamageAmount, DamageType, EventInstigator, DamageCauser)
    BP_Summon.SuperClass.BPReceiveDamage(self, DamageAmount, DamageType, EventInstigator, DamageCauser)

    if self:HasAuthority() then
        self.DamageReceivedDelegate(self, DamageAmount, DamageType, EventInstigator, DamageCauser)
    end
    
end

function BP_Summon:OnSelfDeath(BP_Summon, KillerController, DamageCauseActor, HitResult, HitImpulseDirection, DamageTypeID, bHeadShotDamage)
    sandbox.LogNormalDev(StringFormat_Dev("[BP_Summon:OnSelfDeath] self=%s", GetObjectFullName_Dev(self)))

    if math.random() > self.DropItemProbability then
        self.BPProduceDropItemComponent_Summon:StartDrop(BP_Summon, KillerController)
    end
end

return BP_Summon