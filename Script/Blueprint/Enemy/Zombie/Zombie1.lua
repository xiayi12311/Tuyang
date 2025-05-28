---@class Zombie1_C:BP_UGC_MobPawn_Normal_Near_C
--Edit Below--
local Zombie1 = {}
 
--[[
function Zombie1:ReceiveBeginPlay()
    Zombie1.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Zombie1:ReceiveTick(DeltaTime)
    Zombie1.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function Zombie1:ReceiveEndPlay()
    Zombie1.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function Zombie1:GetReplicatedProperties()
    return
end
--]]

--[[
function Zombie1:GetAvailableServerRPCs()
    return
end
--]]

--[[
function Zombie1:PreTakeDamageEvent(Damage, DamageEvent, EventInstigator, DamageCauser)
     
end
--]]

--[[
function Zombie1:PostTakeDamageEvent(Damage, DamageEvent, EventInstigator, DamageCauser)
    
end
--]]

--[[
function Zombie1:PreOverrideDamageValue(Damage, DamageType, EventInstigator, DamageCauser, Hit)
    return Damage
end
--]]

--[[
function Zombie1:PostOverrideDamageValue(Damage, DamageType, EventInstigator, DamageCauser, Hit)
    return Damage
end
--]]

--[[
function Zombie1:MobPawnDeadEvent(Killer, DamageCauser, KillingHitDamageType)
    
end
--]]

--[[
function Zombie1:StateChangeEvent(OldState, NewState)
    
end
--]]




return Zombie1