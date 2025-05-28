---@class BPAIController_Summon_C:MobAIController
--Edit Below--

local BPAIController_Summon = BPAIController_Summon or {}

function BPAIController_Summon:GetBehaviorTreeObjectPath()
    return string.format([[BehaviorTree'%sAsset/BT_Summon.BT_Summon']], UGCMapInfoLib.GetRootLongPackagePath())
end

function BPAIController_Summon:OnPossess()
    BPAIController_Summon.SuperClass.OnPossess(self)

    -- RunBehaviorTree is required Super of BasicAIController but MobAIController
    --self:RunBehaviorTree(UE.LoadObject(self:GetBehaviorTreeObjectPath()))
end

function BPAIController_Summon:PreInstigatedDamage(DamageAmount, DamageEvent, DamageCauser, Victim)
    return self.Pawn:PreInstigatedDamage(DamageAmount, DamageEvent, DamageCauser, Victim)
end

return BPAIController_Summon