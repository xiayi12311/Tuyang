local Tesla = {}
 
--[[
function Tesla:ReceiveBeginPlay()
    Tesla.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Tesla:ReceiveTick(DeltaTime)
    Tesla.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Tesla:ReceiveEndPlay()
    Tesla.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Tesla:GetReplicatedProperties()
    return
end
--]]

--[[
function Tesla:GetAvailableServerRPCs()
    return
end
--]]

return Tesla