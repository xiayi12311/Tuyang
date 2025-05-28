---@class Sequence_Beginplay_C:LevelSequenceActor
--Edit Below--
local Sequence_Beginplay = {}
 

function Sequence_Beginplay:ReceiveBeginPlay()
    Sequence_Beginplay.SuperClass.ReceiveBeginPlay(self)
	ugcprint("sequence beginplay")


end


--[[
function Sequence_Beginplay:ReceiveTick(DeltaTime)
    Sequence_Beginplay.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Sequence_Beginplay:ReceiveEndPlay()
    Sequence_Beginplay.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Sequence_Beginplay:GetReplicatedProperties()
    return
end
--]]

--[[
function Sequence_Beginplay:GetAvailableServerRPCs()
    return
end
--]]

return Sequence_Beginplay