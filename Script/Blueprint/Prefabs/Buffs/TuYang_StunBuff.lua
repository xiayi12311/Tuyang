---@class TuYang_StunBuff_C:PersistEffectBuff
--Edit Below--
local TuYang_StunBuff = {}
 
-- buff启动条件
--[[
function TuYang_StunBuff:CanApply_BP(OwnerActor)
-- return true
end
--]]

-- buff开始
--[[
function TuYang_StunBuff:OnApply_BP(OwnerActor)

end
--]]

-- buff结束
--[[
function TuYang_StunBuff:OnUnApply_BP(OwnerActor, Reason)

end
--]]

-- buff合并条件，A为当前身上已有buff，B为外来buff，当要挂载外来buff时会判断A.CanMerge(B)
--[[
function TuYang_StunBuff:CanMerge_BP(PersistEffect)
-- return true
end
--]]

-- buff合并，A为当前身上已有buff，B为外来buff，调用A.OnMerge(B)
--[[
function TuYang_StunBuff:OnMerge_BP(PersistEffect)

end
--]]

-- 开启Tick需要SetTickEnable(true)，或buff为间隔触发类型会自动开启
--[[
function TuYang_StunBuff:Tick_BP(OwnerActor, DeltaTime)

end
--]]

--[[
function TuYang_StunBuff:OnInterrupted_BP(OwnerActor)

end
--]]

-- buff总持续时长变化，如修改ApplyTime、修改StackNum
--[[
function TuYang_StunBuff:OnTotalDurationChange_BP(PreTime, CurTime)

end
--]]

-- buff堆叠层数变化
--[[
function TuYang_StunBuff:OnStackChange_BP(PreNum, CurNum)

end
--]]

-- buff触发前条件判断
--[[
function TuYang_StunBuff:CanTrigger_BP()
	return true
end
--]]

-- buff触发效果
--[[
function TuYang_StunBuff:OnTrigger_BP(Delta)

end
--]]

return TuYang_StunBuff