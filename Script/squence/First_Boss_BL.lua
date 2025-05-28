---@class First_Boss_BL_C:LevelSequenceActor
---@field Box UBoxComponent
--Edit Below--
local First_Boss_BL = {}
 

function First_Boss_BL:ReceiveBeginPlay()
    First_Boss_BL.SuperClass.ReceiveBeginPlay(self)
	self.HasPlayed = false
	self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
end


--[[
function First_Boss_BL:ReceiveTick(DeltaTime)
    First_Boss_BL.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function First_Boss_BL:ReceiveEndPlay()
    First_Boss_BL.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function First_Boss_BL:GetReplicatedProperties()
    return
end
--]]

--[[
function First_Boss_BL:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function First_Boss_BL:LuaInit()
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

function First_Boss_BL:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
		local SequencePlayer = self.SequencePlayer
		if not self.HasPlayed then
			self.HasPlayed = true
		-- 触发播放
		if SequencePlayer then
			SequencePlayer:Play()
			ugcprint("小BOSS正在播放")
		else
			ugcprint("SequencePlayer not found.")
		end
		



	local oBTimerDelegate2 = ObjectExtend.CreateDelegate(self,
	function()
		if self:HasAuthority() then 
			--根据路径加载类
			local Path_Hello = UGCGameSystem.GetUGCResourcesFullPath('Asset/F_Boss.F_Boss_C')
			local Class_Hello = UE.LoadClass(Path_Hello)

			--刷出Actor
			local BP_Hello = ScriptGameplayStatics.SpawnActor(self, Class_Hello, 
			{X=-5641.255859,Y=19910.000000,Z=70.442627},    --坐标
			{Roll = 0, Pitch = 0, Yaw = 0},     --旋转
		{X = 1, Y = 1, Z = 1})              --缩放

		
	
		end
	end
	)
	KismetSystemLibrary.K2_SetTimerDelegateForLua(oBTimerDelegate2, self, 10, false)
end
	return nil;
	
end

-- [Editor Generated Lua] function define End;

return First_Boss_BL