local PlayerAddGunBuff = {
    -- 可配置参数定义，参数将显示在Action配置面板
    -- 例：
    -- MyIntParameter = 0
    PlayerKey = 0;
}

-- 触发器激活时，将执行Action的Execute
function PlayerAddGunBuff:Execute(...)
    local PlayerPawn = UGCGameSystem.GetPlayerPawnByPlayerKey(self.PlayerKey)
    PlayerPawn:BindItemDelegate()
    local PlayerController = UGCGameSystem.GetPlayerControllerByPlayerKey(self.PlayerKey)
    PlayerController:AddItem(302001, 10)
    PlayerController:AddItem(303001, 10)
    PlayerController.PlayerState:SetCurrentMonsterNumStage(PlayerController.TeamID)
    return true
end

--[[
-- 需要勾选Action的EnableTick，才会执行Update
-- 触发器激活后，将在每个tick执行Action的Update，直到self.bEnableActionTick为false
function PlayerAddGunBuff:Update(DeltaSeconds)

end
]]

return PlayerAddGunBuff