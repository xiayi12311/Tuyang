local test = {}
 
--[[
function test:ReceiveBeginPlay()
    test.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function test:ReceiveTick(DeltaTime)
    test.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function test:ReceiveEndPlay()
    test.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function test:GetReplicatedProperties()
    return
end
--]]

--[[
function test:GetAvailableServerRPCs()
    return
end
--]]

return test