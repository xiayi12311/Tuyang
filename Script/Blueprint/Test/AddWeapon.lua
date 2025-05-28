---@class AddWeapon_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local RecordWeapon = {}
 

function RecordWeapon:ReceiveBeginPlay()
    RecordWeapon.SuperClass.ReceiveBeginPlay(self)
    self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
end


--[[
function RecordWeapon:ReceiveTick(DeltaTime)
    RecordWeapon.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function RecordWeapon:ReceiveEndPlay()
    RecordWeapon.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function RecordWeapon:GetReplicatedProperties()
    return
end
--]]

--[[
function RecordWeapon:GetAvailableServerRPCs()
    return
end
--]]
function RecordWeapon:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    local PlayerController = OtherActor:GetPlayerControllerSafety()
	if PlayerController then
        PlayerController:Inherit()

    end
    return nil;
end

return RecordWeapon