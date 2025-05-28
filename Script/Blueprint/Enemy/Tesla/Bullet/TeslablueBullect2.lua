---@class TeslablueBullect2_C:UGC_BulletBall_C
---@field Teslabulletetd UParticleSystemComponent
--Edit Below--
local Tesla_SnipeBullect = {}
 
--[[
function Tesla_SnipeBullect:ReceiveBeginPlay()
    Tesla_SnipeBullect.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Tesla_SnipeBullect:ReceiveTick(DeltaTime)
    Tesla_SnipeBullect.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Tesla_SnipeBullect:ReceiveEndPlay()
    Tesla_SnipeBullect.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Tesla_SnipeBullect:GetReplicatedProperties()
    return
end
--]]

--[[
function Tesla_SnipeBullect:GetAvailableServerRPCs()
    return
end
--]]

return Tesla_SnipeBullect