local TestAction = {
    -- 可配置参数定义，参数将显示在Action配置面板
    -- 例：
    -- MyIntParameter = 0
}

-- 触发器激活时，将执行Action的Execute
function TestAction:Execute(...)

    return true
end

--[[
-- 需要勾选Action的EnableTick，才会执行Update
-- 触发器激活后，将在每个tick执行Action的Update，直到self.bEnableActionTick为false
function TestAction:Update(DeltaSeconds)

end
]]

return TestAction