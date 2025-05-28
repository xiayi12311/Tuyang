local EnterSpectater = {
    -- 可配置参数定义，参数将显示在Action配置面板
    -- 例：
    -- MyIntParameter = 0
    PlayerKey = 0;
}

-- 触发器激活时，将执行Action的Execute
function EnterSpectater:Execute(...)
    ugcprint("Player DIe211！")
    local RespawnComponent= UGCGameSystem.GetRespawnComponent()
    if RespawnComponent then
        RespawnComponent:RecordPlayerRespawnKeepItems(self.PlayerKey, false, true);
    end
    local PlayerController1 = UGCGameSystem.GetPlayerControllerByPlayerKey(self.PlayerKey)
    
    local gamestate = UGCGameSystem.GetGameState()
    gamestate:AddRespawnPlayer(PlayerController1)
    gamestate:EnterSpectater(PlayerController1)


    return true
    
end

--[[
-- 需要勾选Action的EnableTick，才会执行Update
-- 触发器激活后，将在每个tick执行Action的Update，直到self.bEnableActionTick为false
function EnterSpectater:Update(DeltaSeconds)

end
]]

return EnterSpectater