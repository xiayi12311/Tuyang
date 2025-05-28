---@class TuYang_DmgIncCDRedSkill_P_3_6_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_DmgIncCDRedSkill_P_3_6 = {}
 
function TuYang_DmgIncCDRedSkill_P_3_6:OnEnableSkill_BP()
    TuYang_DmgIncCDRedSkill_P_3_6.SuperClass.OnEnableSkill_BP(self)
    self.IsLastBullet = true  -- 初始化标记
end

function TuYang_DmgIncCDRedSkill_P_3_6:OnDisableSkill_BP()
    TuYang_DmgIncCDRedSkill_P_3_6.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_DmgIncCDRedSkill_P_3_6:OnActivateSkill_BP()
    TuYang_DmgIncCDRedSkill_P_3_6.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_DmgIncCDRedSkill_P_3_6:OnDeActivateSkill_BP()
    TuYang_DmgIncCDRedSkill_P_3_6.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_DmgIncCDRedSkill_P_3_6:CanActivateSkill_BP()
    return TuYang_DmgIncCDRedSkill_P_3_6.SuperClass.CanActivateSkill_BP(self)
end

function TuYang_DmgIncCDRedSkill_P_3_6:OnCheckFirstBullet()
    ugcprint("[maoyu]:OnCheckFirstBullet")
    
    local weapon = UGCWeaponManagerSystem.GetCurrentWeapon(self:GetNetOwnerActor())
    if not UE.IsValid(weapon) then return end
    
    local weaponClipMaxNum = UGCGunSystem.GetMaxBulletNumInOneClip(weapon)
    
    -- 最后一发子弹逻辑
    if weapon.CurBulletNumInClip == 1 and self.IsLastBullet then
        local playercontroller = self:GetNetOwnerActor():GetInstigatorController()
        if UE.IsValid(playercontroller) then
            playercontroller:SingleDamageIncrease(4.0)
            self.IsLastBullet = false  -- 确保只执行一次
            ugcprint("[maoyu] 最后一发子弹伤害加成激活")
        end
    -- 非最后一发且已激活过加成
    elseif weapon.CurBulletNumInClip > 1 and not self.IsLastBullet then
        local playercontroller = self:GetNetOwnerActor():GetInstigatorController()
        if UE.IsValid(playercontroller) then
            playercontroller:RestoreOriginalDamage(4.0)
            self.IsLastBullet = true  -- 重置标记
            ugcprint("[maoyu] 已复原最后一颗子弹伤害")
        end
    end
end

return TuYang_DmgIncCDRedSkill_P_3_6