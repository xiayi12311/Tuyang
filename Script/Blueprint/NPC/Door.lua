local Door = {}
 
--[[
function Door:ReceiveBeginPlay()
    Door.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Door:ReceiveTick(DeltaTime)
    Door.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Door:ReceiveEndPlay()
    Door.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Door:GetReplicatedProperties()
    return
end
--]]

--[[
function Door:GetAvailableServerRPCs()
    return
end
--]]

return Door