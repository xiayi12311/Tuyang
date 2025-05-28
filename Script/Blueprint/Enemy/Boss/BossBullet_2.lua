local BossBullet_2 = {}
 
--[[
function BossBullet_2:ReceiveBeginPlay()
    BossBullet_2.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function BossBullet_2:ReceiveTick(DeltaTime)
    BossBullet_2.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BossBullet_2:ReceiveEndPlay()
    BossBullet_2.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BossBullet_2:GetReplicatedProperties()
    return
end
--]]

--[[
function BossBullet_2:GetAvailableServerRPCs()
    return
end
--]]

return BossBullet_2