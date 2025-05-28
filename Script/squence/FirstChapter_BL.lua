---@class FirstChapter_BL_C:LevelSequenceActor
--Edit Below--
local FirstChapter_BL = {}
 

function FirstChapter_BL:ReceiveBeginPlay()
    FirstChapter_BL.SuperClass.ReceiveBeginPlay(self)
    local oBTimerDelegate = ObjectExtend.CreateDelegate(self,
	function()
        local SequencePlayer = self.SequencePlayer
    
        -- 触发播放
        if SequencePlayer then
            SequencePlayer:Play()
            print("Level Sequence is now playing.")
        else
            print("SequencePlayer not found.")
        end
		
	end
    )
	
	KismetSystemLibrary.K2_SetTimerDelegateForLua(oBTimerDelegate, self, 38, true)
    

	
end


--[[
function FirstChapter_BL:ReceiveTick(DeltaTime)
    FirstChapter_BL.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function FirstChapter_BL:ReceiveEndPlay()
    FirstChapter_BL.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function FirstChapter_BL:GetReplicatedProperties()
    return
end
--]]

--[[
function FirstChapter_BL:GetAvailableServerRPCs()
    return
end
--]]

return FirstChapter_BL