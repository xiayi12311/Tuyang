---@class TestBox_C:UGCTreasureBox
---@field Box UBoxComponent
--Edit Below--
local TestBox = {}
 

function TestBox:ReceiveBeginPlay()
    TestBox.SuperClass.ReceiveBeginPlay(self)
	self:LuaInit()
end


--[[
function TestBox:ReceiveTick(DeltaTime)
    TestBox.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TestBox:ReceiveEndPlay()
    TestBox.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TestBox:GetReplicatedProperties()
    return
end
--]]

--[[
function TestBox:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function TestBox:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	self.Box.OnComponentHit:Add(self.Box_OnComponentHit, self);
	-- [Editor Generated Lua] BindingEvent End;
end

function TestBox:Box_OnComponentHit(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit)
	ugcprint("增伤开始碰撞")
	local PlayerKey = OtherActor.PlayerKey
	if PlayerKey then
		local PlayerPawn = UGCGameSystem.GetPlayerPawnByPlayerKey(PlayerKey)
		ugcprint("增伤开始Pawn")
		PlayerPawn:BindItemDelegate()
		ugcprint("增伤开始调用")
	end
	
end

-- [Editor Generated Lua] function define End;

return TestBox