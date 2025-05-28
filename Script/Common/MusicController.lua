local MusicController = {}

MusicController.Music = {
    {
        Path = UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Rebellion_of_Human_Civilization_1.Rebellion_of_Human_Civilization_1'),
        Index = 1,
        AKEventID = nil
    }

}


function MusicController:PlayerMusic(Index)
    for i, music in ipairs(self.Music) do
        if music.Index == Index then
            local AKEvent = UE.LoadObject(music.Path)
            music.AkEventID = UGCSoundManagerSystem.PlaySound2D(AKEvent)
        end
    end
end

function MusicController:StopSoundByID(Index)
    for i, music in ipairs(self.Music) do
        if music.Index == Index then
            UGCSoundManagerSystem.StopSoundByID(music.AkEventID)
        end
    end
    
end

--[[
function MusicController:ReceiveBeginPlay()
    MusicController.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function MusicController:ReceiveTick(DeltaTime)
    MusicController.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function MusicController:ReceiveEndPlay()
    MusicController.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function MusicController:GetReplicatedProperties()
    return
end
--]]

--[[
function MusicController:GetAvailableServerRPCs()
    return
end
--]]

return MusicController