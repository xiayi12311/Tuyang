---@class DestoryActor_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local DestoryActor = {}
 

function DestoryActor:ReceiveBeginPlay()
    DestoryActor.SuperClass.ReceiveBeginPlay(self)
    self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
end


--[[
function DestoryActor:ReceiveTick(DeltaTime)
    DestoryActor.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function DestoryActor:ReceiveEndPlay()
    DestoryActor.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function DestoryActor:GetReplicatedProperties()
    return
end
--]]

--[[
function DestoryActor:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function DestoryActor:LuaInit()
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

function DestoryActor:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    ugcprint("D Overlap!")
    OtherActor:ReceiveEnd()
    --OtherActor:K2_DestroyActor()
    return nil;
end

-- [Editor Generated Lua] function define End;

return DestoryActor