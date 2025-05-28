local MyPlayerStart = {}

function MyPlayerStart:GetUGCModePlayerStart(Controller)
    local PlayerState = Controller.PlayerState
    local bornPointId = 1
    if PlayerState.PlayerBornPoint == 1 then
        bornPointId = 1
    end

    if PlayerState.PlayerBornPoint == 2 then
        bornPointId = 2
    end

    if PlayerState.PlayerBornPoint == 3 then
        bornPointId = 3
    end

    local SelectedPlayerStart = self:FindPlayerStartByBornPointID(bornPointId,true)

    if SelectedPlayerStart ~= nil then
        SelectedPlayerStart:SetMarkOccupied()
        return SelectedPlayerStart
    end
    
    
    

end

--[[
function MyPlayerStart:ReceiveBeginPlay()
    MyPlayerStart.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function MyPlayerStart:ReceiveTick(DeltaTime)
    MyPlayerStart.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function MyPlayerStart:ReceiveEndPlay()
    MyPlayerStart.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function MyPlayerStart:GetReplicatedProperties()
    return
end
--]]

--[[
function MyPlayerStart:GetAvailableServerRPCs()
    return
end
--]]

return MyPlayerStart