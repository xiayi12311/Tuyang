---@class EnterBoss_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local EnterBoss = {}
 
local  SequenceActor
function EnterBoss:ReceiveBeginPlay()
    EnterBoss.SuperClass.ReceiveBeginPlay(self)
	ugcprint("Enter begin")
	SequenceActor = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Boss/Sequence/SpawnBoss.SpawnBoss_C'))
	self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
end


--[[
function EnterBoss:ReceiveTick(DeltaTime)
    EnterBoss.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function EnterBoss:ReceiveEndPlay()
    EnterBoss.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function EnterBoss:GetReplicatedProperties()
    return
end
--]]

--[[
function EnterBoss:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function EnterBoss:LuaInit()
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

function EnterBoss:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
	ugcprint("leave npc!")
	local PlayerController = OtherActor:GetPlayerControllerSafety()
	if PlayerController then
	ugcprint("Boss Overlap!")
	if self:HasAuthority() then
		local BossSequence = ScriptGameplayStatics.SpawnActor(self,SequenceActor,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
	end
	self:K2_DestroyActor();
	return nil;
end
end

-- [Editor Generated Lua] function define End;

return EnterBoss