---@class RestartActor_C:AActor
---@field Box UBoxComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local RestartActor = {}
 

function RestartActor:ReceiveBeginPlay()
    RestartActor.SuperClass.ReceiveBeginPlay(self)
    self.Box.OnComponentBeginOverlap:Add(self.Box_OnComponentBeginOverlap, self);
end


--[[
function RestartActor:ReceiveTick(DeltaTime)
    RestartActor.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function RestartActor:ReceiveEndPlay()
    RestartActor.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function RestartActor:GetReplicatedProperties()
    return
end
--]]

--[[
function RestartActor:GetAvailableServerRPCs()
    return
end
--]]

-- [Editor Generated Lua] function define Begin:
function RestartActor:LuaInit()
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

function RestartActor:Box_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    ugcprint("restart")
	local PlayerController = OtherActor:GetPlayerControllerSafety()
    if PlayerController then

        ugcprint("respawn id is" ..OtherActor.PlayerKey)
		local Damage = UGCGameSystem.ApplyRadialDamage(1000,1000,OtherActor:K2_GetActorLocation(),100,100,0, EDamageType.RadialDamage,nil,nil,nil,ECollisionChannel.ECC_Visibility, 0);
	
		ugcprint("DamageDamage is " ..Damage)
        local oBTimerDelegate1 = ObjectExtend.CreateDelegate(self,
        function(TargetActor)      
            ugcprint("Second damage!")                      
			local Damage = UGCGameSystem.ApplyRadialDamage(1000,1000,OtherActor:K2_GetActorLocation(),100,100,0, EDamageType.RadialDamage,nil,nil,nil,ECollisionChannel.ECC_Visibility, 0);
           
        end,OtherActor)
    KismetSystemLibrary.K2_SetTimerDelegateForLua(oBTimerDelegate1, self,1, false)
    end
    return nil;
end

-- [Editor Generated Lua] function define End;

return RestartActor