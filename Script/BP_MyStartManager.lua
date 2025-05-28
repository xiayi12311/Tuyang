local BP_MyStartManager = {}
---@field  box1  BP_PlayerStartManager
function BP_MyStartManager:GetUGCModePlayerStart(Controller)

    --标记当前属于服务器还是客户端
    if UGCGameSystem.GameState:HasAuthority() == true then 
        print("MMG_Lua MyStartManager:GetUGCModePlayerStart Server");
    else
        print("MMG_Lua MyStartManager:GetUGCModePlayerStart Client");
    end

    --获取当前控制器的玩家状态（PlayerState）
    local PlayerState = Controller.PlayerState;

    --PlayerState为空时，打印警告
    if PlayerState == nil then
        print( "Error: MyStartManager:GetUGCModePlayerStart PlayerState is nil!");
    end
    
    -- local SelectedPlayerStart = self:FindPlayerStartByBornPointID(PlayerState:GetPlayerBornPoint(), true); 
   
    -- --self:FindPlayerStartByBornPointID(PlayerState.TeamID, true);--当一个出生点已经被使用过一次，用于出生玩家时，自动寻找其他未被使用的出生点
    -- print(string.format("MMG_Lua MyStartManager:GetUGCModePlayerStart PlayerState.TeamID[%s]", PlayerState.TeamID));

    -- --若找到玩家出生点（PlayerStart），打印当前玩家出生点名称和对应BornID，否则输出错误信息
    -- if SelectedPlayerStart ~= nil then
    --     print(string.format("MyStartManager:GetUGCModePlayerStart SelectedPlayerStart[%s] BornID[%d] PlayerID[%s]",   
    --     KismetSystemLibrary.GetObjectName(SelectedPlayerStart), SelectedPlayerStart.PlayerBornPointID, Controller.PlayerKey));
    --     ugcprint("Player Born Point "..PlayerState:GetPlayerBornPoint())
    --     --设置当前PlayerStart被占用
    --     -- SelectedPlayerStart:SetMarkOccupied();
    --     -- print(string.format( "PlayerStartOccupied?[%s]",SelectedPlayerStart:IsMarkOccupied()));
    --     return SelectedPlayerStart;
    -- else
    --     ugcprint("Player Born Point is nil ")
    --     print("Error: MyStartManager:GetUGCModePlayerStart SelectedPlayerStart is nil!");
    -- end
   
    -- return nil;
    local bornPointId = 0
    bornPointId = PlayerState.TeamID
    local playerStart = self:FindPlayerStartByBornPointID(bornPointId, true);
    return playerStart
end
--[[
function BP_MyStartManager:ReceiveBeginPlay()
    BP_MyStartManager.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function BP_MyStartManager:ReceiveTick(DeltaTime)
    BP_MyStartManager.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BP_MyStartManager:ReceiveEndPlay()
    BP_MyStartManager.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BP_MyStartManager:GetReplicatedProperties()
    return
end
--]]

--[[
function BP_MyStartManager:GetAvailableServerRPCs()
    return
end
--]]

return BP_MyStartManager