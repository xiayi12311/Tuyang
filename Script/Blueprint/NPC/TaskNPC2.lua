---@class TaskNPC1_C:SkeletalMeshActor
---@field CustomBoxCollision UCustomBoxCollisionComponent
---@field GISActorComponentBase UGISActorComponentBase
---@field NPC_ID int32
---@field NPC_Type FString
--Edit Below--
local TaskNPC1 = {}
TaskNPC1.TestButton = nil
 

function TaskNPC1:ReceiveBeginPlay()
    --TaskNPC1.SuperClass.ReceiveBeginPlay(self)
	self.CustomBoxCollision.OnComponentBeginOverlap:Add(self.CustomBoxCollision_OnComponentBeginOverlap, self)
	self.CustomBoxCollision.OnComponentEndOverlap:Add(self.CustomBoxCollision_OnComponentEndOverlap, self)
	
end


--[[
function TaskNPC1:ReceiveTick(DeltaTime)
    TaskNPC1.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TaskNPC1:ReceiveEndPlay()
    TaskNPC1.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TaskNPC1:GetReplicatedProperties()
    return
end
--]]

--[[
function TaskNPC1:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function TaskNPC1:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	
	-- [Editor Generated Lua] BindingEvent End;
end

function TaskNPC1:CustomBoxCollision_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
	
	if not self:HasAuthority() then
		local PlayerController = OtherActor:GetPlayerControllerSafety()
		if PlayerController then
			local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/TaskUI/TaskNPC2_UI.TaskNPC2_UI_C')
			local TalkClass = UE.LoadClass(path)
			if UE.IsValid(TalkClass) then
				if not UE.IsValid(self.TestButton) then
					self.TestButton = UserWidget.NewWidgetObjectBP(PlayerController,TalkClass)
				end
					if UE.IsValid(self.TestButton) then
						if self.TestButton:AddToViewport(0) then
						end
					end
			end
		end
	end

	-- local PlayerController = GameplayStatics.GetPlayerController(self, 0)
	-- local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/TaskUI/TaskNPC2_UI.TaskNPC2_UI_C')
    -- local TalkClass = UE.LoadClass(path)
	-- if UE.IsValid(TalkClass) then
	-- 	if not UE.IsValid(self.TestButton) then
    --         self.TestButton = UserWidget.NewWidgetObjectBP(PlayerController,TalkClass)
    --     end
	-- 		if UE.IsValid(self.TestButton) then
	-- 			if self.TestButton:AddToViewport(0) then
	-- 			end
	-- 		end
	-- end
end

function TaskNPC1:CustomBoxCollision_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
	ugcprint("leave npc!")
	if not self:HasAuthority() then
		local PlayerController = OtherActor:GetPlayerControllerSafety()
		if PlayerController then
	if UE.IsValid(self.TestButton) then
        self.TestButton:RemoveFromViewport()
		self.TestButton:DestoryTalk()
        self.TestButton = nil
        
    end
end
end
end

-- [Editor Generated Lua] function define End;

return TaskNPC1