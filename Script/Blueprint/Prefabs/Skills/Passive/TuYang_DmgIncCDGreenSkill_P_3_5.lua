---@class TuYang_DmgIncCDGreenSkill_P_3_5_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_DmgIncCDGreenSkill_P_3_5 = {}
 
function TuYang_DmgIncCDGreenSkill_P_3_5:OnEnableSkill_BP()
    TuYang_DmgIncCDGreenSkill_P_3_5.SuperClass.OnEnableSkill_BP(self)
    self.IsFirstBullet = true  -- 确保技能启用时重置状态
end

function TuYang_DmgIncCDGreenSkill_P_3_5:OnDisableSkill_BP()
    TuYang_DmgIncCDGreenSkill_P_3_5.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_DmgIncCDGreenSkill_P_3_5:OnActivateSkill_BP()
    TuYang_DmgIncCDGreenSkill_P_3_5.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_DmgIncCDGreenSkill_P_3_5:OnDeActivateSkill_BP()
    TuYang_DmgIncCDGreenSkill_P_3_5.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_DmgIncCDGreenSkill_P_3_5:CanActivateSkill_BP()
    return TuYang_DmgIncCDGreenSkill_P_3_5.SuperClass.CanActivateSkill_BP(self)
end

function TuYang_DmgIncCDGreenSkill_P_3_5:OnCheckFirstBullet()
    ugcprint("[maoyu]:OnCheckFirstBullet")
    
    local weapon = UGCWeaponManagerSystem.GetCurrentWeapon(self:GetNetOwnerActor())
    if not UE.IsValid(weapon) then return end
    
    local weaponClipMaxNum = UGCGunSystem.GetMaxBulletNumInOneClip(weapon)
    
    -- 状态同步检测
    if weapon.CurBulletNumInClip < weaponClipMaxNum and not self.IsFirstBullet then
        local playercontroller = self:GetNetOwnerActor():GetInstigatorController()
        if UE.IsValid(playercontroller) then
            playercontroller:RestoreOriginalDamage(1.5)
            self.IsFirstBullet = true  -- 重置标记
            ugcprint("[maoyu] 伤害已恢复")
        end
    -- 新增换弹完成检测
    elseif weapon.CurBulletNumInClip == weaponClipMaxNum and self.IsFirstBullet then
        local playercontroller = self:GetNetOwnerActor():GetInstigatorController()
        if UE.IsValid(playercontroller) then
            playercontroller:SingleDamageIncrease(1.5)
            self.IsFirstBullet = false
            ugcprint("[maoyu] 首子弹伤害加成激活")
        end
    end
end

return TuYang_DmgIncCDGreenSkill_P_3_5