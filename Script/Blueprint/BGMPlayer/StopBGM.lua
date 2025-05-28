---@class StopBGM_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local StopBGM = {}
 

function StopBGM:ReceiveBeginPlay()
    StopBGM.SuperClass.ReceiveBeginPlay(self)
    self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
end


--[[
function StopBGM:ReceiveTick(DeltaTime)
    StopBGM.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function StopBGM:ReceiveEndPlay()
    StopBGM.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function StopBGM:GetReplicatedProperties()
    return
end
--]]

--[[
function StopBGM:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function StopBGM:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
	-- [Editor Generated Lua] BindingEvent End;
end

function StopBGM:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    if not self:HasAuthority() then 
        local PlayerController = OtherActor:GetPlayerControllerSafety()
        if PlayerController then
            local PlayerState = OtherActor.PlayerState
            local PlayingEvent = PlayerState:GetAkEvent()
                UGCSoundManagerSystem.StopSoundByID(PlayingEvent)
                PlayerState:SetAkEvent(nil)
                PlayerState:SetBGMID(0)
        end
    end
    return nil;
end

-- [Editor Generated Lua] function define End;

return StopBGM