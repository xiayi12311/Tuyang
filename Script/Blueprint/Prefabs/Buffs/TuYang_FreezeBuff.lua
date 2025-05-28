---@class TuYang_FreezeBuff_C:PersistEffectBuff
--Edit Below--
local TuYang_FreezeBuff = {}
 
-- buff启动条件
--[[
function TuYang_FreezeBuff:CanApply_BP(OwnerActor)
-- return true
end
--]]

-- buff开始
--[[
function TuYang_FreezeBuff:OnApply_BP(OwnerActor)

end
--]]

-- buff结束
--[[
function TuYang_FreezeBuff:OnUnApply_BP(OwnerActor, Reason)

end
--]]

-- buff合并条件，A为当前身上已有buff，B为外来buff，当要挂载外来buff时会判断A.CanMerge(B)
--[[
function TuYang_FreezeBuff:CanMerge_BP(PersistEffect)
-- return true
end
--]]

-- buff合并，A为当前身上已有buff，B为外来buff，调用A.OnMerge(B)
--[[
function TuYang_FreezeBuff:OnMerge_BP(PersistEffect)

end
--]]

-- 开启Tick需要SetTickEnable(true)，或buff为间隔触发类型会自动开启
--[[
function TuYang_FreezeBuff:Tick_BP(OwnerActor, DeltaTime)

end
--]]

--[[
function TuYang_FreezeBuff:OnInterrupted_BP(OwnerActor)

end
--]]

-- buff总持续时长变化，如修改ApplyTime、修改StackNum
--[[
function TuYang_FreezeBuff:OnTotalDurationChange_BP(PreTime, CurTime)

end
--]]

-- buff堆叠层数变化
--[[
function TuYang_FreezeBuff:OnStackChange_BP(PreNum, CurNum)

end
--]]

-- buff触发前条件判断
--[[
function TuYang_FreezeBuff:CanTrigger_BP()
	return true
end
--]]

-- buff触发效果
--[[
function TuYang_FreezeBuff:OnTrigger_BP(Delta)
	UGCLog.Log("[maoyu]:TuYang_FreezeSkill:OnTriggerSkill_BP - Skill Triggered")

	local SelfOwnerComp = self:GetOwnerSafety(self)

	self.Owner = GetFirstPersistEffectDataByClass

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
        if Timer.IsTimerExistByName("SlowMonsterTimer") and MonsterSpeedScale ~= 1 then
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
        end, false, "SlowMonsterTimer")
    end

    -- 遍历所有目标并处理
    for _, Monster in ipairs(Monsters) do
        HandleMonster(Monster)
    end
end
--]]

return TuYang_FreezeBuff