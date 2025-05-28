---@class Traininstrom_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local Traininstrom = {};
 

function Traininstrom:ReceiveBeginPlay()
	self.SuperClass.ReceiveBeginPlay(self);
	self.HasPlayed = false
	self:LuaInit();
end


--[[
function Traininstrom:ReceiveTick(DeltaTime)
    self.SuperClass.ReceiveTick(self, DeltaTime);
end
--]]

--[[
function Traininstrom:ReceiveEndPlay()
    self.SuperClass.ReceiveEndPlay(self); 
end
--]]

--[[
function Traininstrom:GetReplicatedProperties()
    return
end
--]]

--[[
function Traininstrom:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function Traininstrom:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	if self:HasAuthority() == false then
		self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
		self.Box.OnComponentEndOverlap:Add(self.Box_OnComponentEndOverlap, self);
	end
end

function Traininstrom:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
	local PlayerController = OtherActor:GetPlayerControllerSafety()
	if PlayerController then
		if not self.HasPlayed then
			self.HasPlayed = true
			UGCSoundManagerSystem.StopSoundByID(self.EventID)
			local Path = UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/NPCnsasoldierjingjie_1.NPCnsasoldierjingjie_1')
			local AKEvent = UE.LoadObject(Path)
			local orientation = {Roll=0,Pitch=0,Yaw=45}
			self.EventID = UGCSoundManagerSystem.PlaySoundAtLocation(AKEvent,{X=11358.989258,Y=20083.251953,Z=3.557533},orientation)
		end
	end
	return nil;
end

function Traininstrom:Box_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
	return nil;
end

-- [Editor Generated Lua] function define End;

return Traininstrom;