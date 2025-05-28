---@class TalkNPC_C:NPC1_C
---@field ClickActorComponentBase UClickActorComponentBase
---@field CustomBoxCollision UCustomBoxCollisionComponent
---@field Capsule UCapsuleComponent
---@field NPC_ID int32
---@field NPC_Type FString
--Edit Below--
local TalkNPC = {}
TalkNPC.TestButton = nil
function TalkNPC:ReceiveBeginPlay()

    self.CustomBoxCollision.OnComponentBeginOverlap:Add(self.CustomBoxCollision_OnComponentBeginOverlap, self);
	self.CustomBoxCollision.OnComponentEndOverlap:Add(self.CustomBoxCollision_OnComponentEndOverlap, self);
    
end

-- function TalkNPC:ReceiveTick(DeltaTime)

-- end

function TalkNPC:ReceiveEndPlay()


end

-- [Editor Generated Lua] function define Begin:

function TalkNPC:LuaInit()
	if self.bInitDoOnce then
		return;
	end
	self.bInitDoOnce = true;
	-- [Editor Generated Lua] BindingProperty Begin:
	-- [Editor Generated Lua] BindingProperty End;
	
	-- [Editor Generated Lua] BindingEvent Begin:
	
	-- [Editor Generated Lua] BindingEvent End;
end

function TalkNPC:CustomBoxCollision_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    if not self:HasAuthority() then 
        local PlayerController = OtherActor:GetPlayerControllerSafety()
        if PlayerController then
			local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/TaskUI/TaskNPC1_UI.TaskNPC1_UI_C')
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
end

function TalkNPC:CustomBoxCollision_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
	
	if not self:HasAuthority() then 
		ugcprint("leave npc!")
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

return TalkNPC;