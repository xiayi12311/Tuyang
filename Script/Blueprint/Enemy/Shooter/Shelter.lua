local Shelter = {}
 
--[[
function Shelter:ReceiveBeginPlay()
    Shelter.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Shelter:ReceiveTick(DeltaTime)
    Shelter.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Shelter:ReceiveEndPlay()
    Shelter.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Shelter:GetReplicatedProperties()
    return
end
--]]

--[[
function Shelter:GetAvailableServerRPCs()
    return
end
--]]

return Shelter