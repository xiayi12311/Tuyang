---@class Testskill_C:PESkillPassiveSkillTemplate_C
--Edit Below--
local TuYang_FreezeSkill = {}
 
function TuYang_FreezeSkill:OnEnableSkill_BP()
    TuYang_FreezeSkill.SuperClass.OnEnableSkill_BP(self)
end

function TuYang_FreezeSkill:OnDisableSkill_BP()
    TuYang_FreezeSkill.SuperClass.OnDisableSkill_BP(self)
end

function TuYang_FreezeSkill:OnActivateSkill_BP()

    local TuYang_FreezeBuff = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_FreezeBuff.TuYang_FreezeBuff_C')
    
    UGCLog.Log("[maoyu]:TuYang_FreezeSkill:GetFirstPersistEffectDataByClass")
    self.Buff = self:GetOwnerSafety(self):GetFirstPersistEffectDataByClass(TuYang_FreezeBuff)
    UGCLog.Log("[maoyu]:TuYang_FreezeSkill:GetFirstPersistEffectDataByClass", self.Buff)
    TuYang_FreezeSkill.SuperClass.OnActivateSkill_BP(self)
end

function TuYang_FreezeSkill:OnDeActivateSkill_BP()
    TuYang_FreezeSkill.SuperClass.OnDeActivateSkill_BP(self)
end

function TuYang_FreezeSkill:CanActivateSkill_BP()
    return TuYang_FreezeSkill.SuperClass.CanActivateSkill_BP(self)
end

function TuYang_FreezeSkill:OnTriggerSkill_BP()
    UGCLog.Log("[maoyu]:TuYang_FreezeSkill:OnTriggerSkill_BP - Skill Triggered")

    -- 获取所有目标
    local Monsters = self:GetSelectTargetActor(EPESkillSelectTarget.E_PESKILL_PickerType_AllTarget)
    if not Monsters or #Monsters == 0 then
        UGCLog.Log("[maoyu]:TuYang_FreezeSkill:OnTriggerSkill_BP - No valid targets found")
        return
    end

    -- 定义一个函数处理单个怪物的逻辑
    local function HandleMonster(Monster)
        if not UE.IsValid(Monster) then
            UGCLog.Log("[maoyu]:TuYang_FreezeSkill:HandleMonster - Invalid Monster")
            return
        end

        -- 预设速度缩放值
        local PreviewSpeedScale = 0.6
        -- 获取当前速度缩放值
        local MonsterSpeedScale = UGCSimpleCharacterSystem.GetSpeedScale(Monster)

        -- 如果速度缩放值已被修改，则移除之前的定时器
        if Timer.IsTimerExistByName("SlowOneMonsterTimer") and MonsterSpeedScale ~= 1 then
            Timer.RemoveTimer(self.SlowMonsterTimer)
            UGCLog.Log("[maoyu]:TuYang_FreezeSkill:HandleMonster - Removed existing timer")
        end

        -- 设置新的速度缩放值
        UGCSimpleCharacterSystem.SetSpeedScale(Monster, PreviewSpeedScale)
        UGCLog.Log("[maoyu]:TuYang_FreezeSkill:HandleMonster - SetSpeedScale =  ", PreviewSpeedScale)

        -- 设置定时器，3秒后恢复速度
        self.SlowMonsterTimer = Timer.InsertTimer(3.0, function()
            if UE.IsValid(Monster) then
                UGCSimpleCharacterSystem.SetSpeedScale(Monster, 1.0)
                UGCLog.Log("[maoyu]:TuYang_FreezeSkill:HandleMonster - Restored SpeedScale to 1.0")
            end
        end, false, "SlowOneMonsterTimer")
    end

    -- 遍历所有目标并处理
    for _, Monster in ipairs(Monsters) do
        HandleMonster(Monster)
    end
end

return TuYang_FreezeSkill