---@class TEST_C:BP_UGC_MobPawn_Normal_Near_C
--Edit Below--
local TEST = {}
 
--[[
function TEST:ReceiveBeginPlay()
    TEST.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function TEST:ReceiveTick(DeltaTime)
    TEST.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TEST:ReceiveEndPlay()
    TEST.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TEST:GetReplicatedProperties()
    return
end
--]]

--[[
function TEST:GetAvailableServerRPCs()
    return
end
--]]

--[[
function TEST:PreTakeDamageEvent(DamageCauser, EventInstigator, Damage, DamageContext)
     
end
--]]

--[[
function TEST:PostTakeDamageEvent(DamageCauser, EventInstigator, Damage, DamageContext)
    
end
--]]

--[[
function TEST:PreOverrideDamageValue(Damage, DamageType, EventInstigator, DamageCauser, Hit)
    return Damage
end
--]]

--[[
function TEST:PostOverrideDamageValue(Damage, DamageType, EventInstigator, DamageCauser, Hit)
    return Damage
end
--]]

--[[
function TEST:MobPawnDeadEvent(Killer, DamageCauser, KillingHitDamageType)
    
end
--]]

--[[
function TEST:StateChangeEvent(OldState, NewState)
    
end
--]]




return TEST