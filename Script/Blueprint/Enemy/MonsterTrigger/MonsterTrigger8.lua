---@class MonsterTrigger1_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local MonsterTrigger1 = {}
local HasTrigger = false
local EventSystem =  require('Script.common.UGCEventSystem')
function MonsterTrigger1:ReceiveBeginPlay()
    MonsterTrigger1.SuperClass.ReceiveBeginPlay(self)
    self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
end


--[[
function MonsterTrigger1:ReceiveTick(DeltaTime)
    MonsterTrigger1.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function MonsterTrigger1:ReceiveEndPlay()
    MonsterTrigger1.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function MonsterTrigger1:GetReplicatedProperties()
    return
end
--]]

--[[
function MonsterTrigger1:GetAvailableServerRPCs()
    return
end
--]]
function MonsterTrigger1:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)

	local PlayerController = OtherActor:GetPlayerControllerSafety()
    if PlayerController and HasTrigger ==false then
        HasTrigger = true
		ugcprint("PlayerBorn BeginOverLap1")
		EventSystem:SendEvent("Spawn8");
    end

	
	
end
return MonsterTrigger1