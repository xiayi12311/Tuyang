local BossBullet = {}
 
--[[
function BossBullet:ReceiveBeginPlay()
    BossBullet.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function BossBullet:ReceiveTick(DeltaTime)
    BossBullet.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BossBullet:ReceiveEndPlay()
    BossBullet.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BossBullet:GetReplicatedProperties()
    return
end
--]]

--[[
function BossBullet:GetAvailableServerRPCs()
    return
end
--]]

return BossBullet