---@class TuYang_RoundStart_C:AActor
---@field DefaultSceneRoot USceneComponent
---@field ItemID int32
--Edit Below--
local TuYang_RoundStartNote = {}
 

function TuYang_RoundStartNote:ReceiveBeginPlay()
    TuYang_RoundStartNote.SuperClass.ReceiveBeginPlay(self)
    local GameState = UGCGameSystem.GetGameState()
    if GameState.RoundStartTepeportActorLocation[self.ItemID] == nil then
        GameState.RoundStartTepeportActorLocation[self.ItemID] = self:K2_GetActorLocation()
    end
end


--[[
function TuYang_RoundStartNote:ReceiveTick(DeltaTime)
    TuYang_RoundStartNote.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TuYang_RoundStartNote:ReceiveEndPlay()
    TuYang_RoundStartNote.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TuYang_RoundStartNote:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_RoundStartNote:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_RoundStartNote