---@class EnterFirstChapter_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local EnterFirstChapter = {}
 
local  SequenceActor
local EventSystem =  require('Script.common.UGCEventSystem')
function EnterFirstChapter:ReceiveBeginPlay()
    EnterFirstChapter.SuperClass.ReceiveBeginPlay(self)
	ugcprint("Enter begin")--UGCGameSystem.GetUGCResourcesFullPath('Asset/squence/Sequence_Sync/SpawnFirstChapter.SpawnFirstChapter_C')
	if self:HasAuthority()  then
	SequenceActor = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/squence/Sequence_Sync/SpawnFirstChapter.SpawnFirstChapter_C'))
	local gamestate = UGCGameSystem.GetGameState()
	
	local function EndVote()
		if self:HasAuthority() then
			local gamestate = UGCGameSystem.GetGameState()
			
		
			local PlayerStates = UGCGameSystem.GetAllPlayerState()
			local Players = UGCGameSystem.GetAllPlayerPawn()
			for i,Player in pairs(Players) do
				Player:BindItemDelegate()
			end

		end
	end
	UGCGameSystem.SetTimer(self,EndVote,62,false)
end
	--EventSystem:AddListener("FirstChapter",self.SpawnFirstChapter)
	-- if self:HasAuthority() then
	-- 	ugcprint("First Sequence Actived")
	-- 	local FirstChapterSequence = ScriptGameplayStatics.SpawnActor(
	-- 		self,SequenceActor,
	-- 		self:K2_GetActorLocation(),
	-- 		self:K2_GetActorRotation(),
	-- 		{X = 1, Y = 1, Z = 1},self);
	-- end
	--self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
end


--[[
function EnterFirstChapter:ReceiveTick(DeltaTime)
    EnterFirstChapter.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function EnterFirstChapter:ReceiveEndPlay()
    EnterFirstChapter.SuperClass.ReceiveEndPlay(self) 
	ugcprint("Enter Over")
	-- if self:HasAuthority() then
	-- 	ugcprint("First Sequence Actived")
	-- 	local FirstChapterSequence = ScriptGameplayStatics.SpawnActor(
	-- 		self,SequenceActor,
	-- 		self:K2_GetActorLocation(),
	-- 		self:K2_GetActorRotation(),
	-- 		{X = 1, Y = 1, Z = 1},self);
	-- end

end


--[[
function EnterFirstChapter:GetReplicatedProperties()
    return
end
--]]

--[[
function EnterFirstChapter:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function EnterFirstChapter:LuaInit()
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

function EnterFirstChapter:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
		ugcprint("First Chapter OverLap ")
	--local PlayerController = OtherActor:GetPlayerControllerSafety()
  -- if PlayerController then
		if self:HasAuthority() then
			ugcprint("First Sequence Actived")
			local FirstChapterSequence = ScriptGameplayStatics.SpawnActor(
				self,SequenceActor,
				self:K2_GetActorLocation(),
				self:K2_GetActorRotation(),
				{X = 1, Y = 1, Z = 1},self);
		end
	self:K2_DestroyActor();
	--end

	return nil;
end
function EnterFirstChapter:SpawnFirstChapter(target)
	ugcprint("receive and do ")
	--if self:HasAuthority() then
		ugcprint("First Sequence Actived")
		local FirstChapterSequence = ScriptGameplayStatics.SpawnActor(
			self,SequenceActor,
			self:K2_GetActorLocation(),
			self:K2_GetActorRotation(),
			{X = 1, Y = 1, Z = 1},self);
	--end
	self:K2_DestroyActor();
end
-- [Editor Generated Lua] function define End;

return EnterFirstChapter