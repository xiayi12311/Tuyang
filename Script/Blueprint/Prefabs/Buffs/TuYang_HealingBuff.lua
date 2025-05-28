---@class TuYang_HealingBuff_C:PersistEffectBuff
--Edit Below--
local TuYang_HealingBuff = {}
 
-- buff启动条件
--[[
function TuYang_HealingBuff:CanApply_BP(OwnerActor)
-- return true
end
--]]

-- buff开始
--[[
function TuYang_HealingBuff:OnApply_BP(OwnerActor)

end
--]]

-- buff结束
--[[
function TuYang_HealingBuff:OnUnApply_BP(OwnerActor, Reason)

end
--]]

-- buff合并条件，A为当前身上已有buff，B为外来buff，当要挂载外来buff时会判断A.CanMerge(B)
--[[
function TuYang_HealingBuff:CanMerge_BP(PersistEffect)
-- return true
end
--]]

-- buff合并，A为当前身上已有buff，B为外来buff，调用A.OnMerge(B)
--[[
function TuYang_HealingBuff:OnMerge_BP(PersistEffect)

end
--]]

-- 开启Tick需要SetTickEnable(true)，或buff为间隔触发类型会自动开启
--[[
function TuYang_HealingBuff:Tick_BP(OwnerActor, DeltaTime)

end
--]]

--[[
function TuYang_HealingBuff:OnInterrupted_BP(OwnerActor)

end
--]]

-- buff总持续时长变化，如修改ApplyTime、修改StackNum
--[[
function TuYang_HealingBuff:OnTotalDurationChange_BP(PreTime, CurTime)

end
--]]

-- buff堆叠层数变化
--[[
function TuYang_HealingBuff:OnStackChange_BP(PreNum, CurNum)

end
--]]

-- buff触发前条件判断
--[[
function TuYang_HealingBuff:CanTrigger_BP()
	return true
end
--]]

-- buff触发效果
--[[
function TuYang_HealingBuff:OnTrigger_BP(Delta)

end
--]]

return TuYang_HealingBuff