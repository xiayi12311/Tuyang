---@class TestMusicArea_C:AActor
---@field Box UBoxComponent
---@field StaticMesh UStaticMeshComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local GunTestBox = {}
 
function GunTestBox:ReceiveBeginPlay()
    GunTestBox.SuperClass.ReceiveBeginPlay(self)
    self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
	self.Box.OnComponentEndOverlap:Add(self.Box_OnComponentEndOverlap, self);
end


--[[
function GunTestBox:ReceiveTick(DeltaTime)
    GunTestBox.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function GunTestBox:ReceiveEndPlay()
    GunTestBox.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function GunTestBox:GetReplicatedProperties()
    return
end
--]]

--[[
function GunTestBox:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function GunTestBox:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	
	-- [Editor Generated Lua] BindingEvent End;
end

function GunTestBox:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
	ugcprint("增伤开始碰撞")
	local PlayerKey = OtherActor.PlayerKey
	if PlayerKey then
		local PlayerPawn = UGCGameSystem.GetPlayerPawnByPlayerKey(PlayerKey)
		ugcprint("增伤开始Pawn")
		PlayerPawn:BindItemDelegate()
		ugcprint("增伤开始调用")
	end
	
	
end

function GunTestBox:Box_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)

end

-- [Editor Generated Lua] function define End;

return GunTestBox