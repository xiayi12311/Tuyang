---@class TuYang_SpecialMonsterSequence_C:TuYang_SequenceBase_C
--Edit Below--
local TuYang_SpecialMonsterSequence = {}
 
--[[
function TuYang_SpecialMonsterSequence:ReceiveBeginPlay()
    TuYang_SpecialMonsterSequence.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function TuYang_SpecialMonsterSequence:ReceiveTick(DeltaTime)
    TuYang_SpecialMonsterSequence.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TuYang_SpecialMonsterSequence:ReceiveEndPlay()
    TuYang_SpecialMonsterSequence.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TuYang_SpecialMonsterSequence:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_SpecialMonsterSequence:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_SpecialMonsterSequence