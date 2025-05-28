---@class SendRank_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local SendRank = {}
 
UGCGameSystem.UGCRequire("ExtendResource.RankingList.OfficialPackage.Script.RankingList.RankingListManager")
function SendRank:ReceiveBeginPlay()
    SendRank.SuperClass.ReceiveBeginPlay(self)
    self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
end


--[[
function SendRank:ReceiveTick(DeltaTime)
    SendRank.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SendRank:ReceiveEndPlay()
    SendRank.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SendRank:GetReplicatedProperties()
    return
end
--]]

--[[
function SendRank:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function SendRank:LuaInit()
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

function SendRank:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    ugcprint("Send OVerlap")
	local PlayerController = OtherActor:GetPlayerControllerSafety()
	if PlayerController then
		ugcprint("Send Rank!")
       -- PlayerController:UpLoad()
	   local PlayerControllers = UGCGameSystem.GetAllPlayerController()
	   for _,Controller in pairs(PlayerControllers) do
		   Controller:UpLoad() 
	   end
	end
    return nil;
end

-- [Editor Generated Lua] function define End;

return SendRank