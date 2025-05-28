---@class TuYang_WindSkill1_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_FireBulletSkill = {}
 
function TuYang_FireBulletSkill:OnEnableSkill_BP()
    TuYang_FireBulletSkill.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_FireBulletSkill:OnDisableSkill_BP()
    TuYang_FireBulletSkill.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_FireBulletSkill:OnActivateSkill_BP()
    TuYang_FireBulletSkill.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_FireBulletSkill:OnDeActivateSkill_BP()
    TuYang_FireBulletSkill.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_FireBulletSkill:CanActivateSkill_BP()
    return TuYang_FireBulletSkill.SuperClass.CanActivateSkill_BP(self)
end

return TuYang_FireBulletSkill