UGCGameSystem.UGCRequire('Script.GameAttribute.game_attribute_type')
local UGCGlobalDamageCalculation = {}

function UGCGlobalDamageCalculation:GetCalculationResult(Context, ExtraResult)
    local VictimActor				= UGCAttributeSystem.GetVictimFromContext(Context)      --受害者
    local Causer					= UGCAttributeSystem.GetCauserFromContext(Context)      --枪等武器或者人(空手情况)
    local InstigatorController      = UGCAttributeSystem.GetInstigatorFromContext(Context)  --攻击者的Controller
    local CauserActor= InstigatorController:K2_GetPawn()    --攻击者角色
    print("[UGCGlobalDamageCalculation] Context CauserActor --->"..tostring(CauserActor))
    
    if not VictimActor or not CauserActor then
        print("[UGCGlobalDamageCalculation] VictimActor or CauserActor is null.")
        return 0
    end
    
    -- 传入的原始伤害数值
    local SkillAttack = UGCAttributeSystem.GetSourceMagnitudeFromContext(Context)
    return SkillAttack, ExtraResult
end

return UGCGlobalDamageCalculation