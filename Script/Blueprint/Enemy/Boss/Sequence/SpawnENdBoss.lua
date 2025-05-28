---@class SpawnEndBoss_C:LevelSequenceActor
--Edit Below--
local SpawnENdBoss = {}
 

function SpawnENdBoss:ReceiveBeginPlay()
    SpawnENdBoss.SuperClass.ReceiveBeginPlay(self)
    ugcprint("SpawnENdBoss:ReceiveBeginPlay!")    
    if self:HasAuthority() then
        local oBTimerDelegate1 = ObjectExtend.CreateDelegate(self,
        function()      
            ugcprint("Spawn Game End")    
    
           
            
        end)
        KismetSystemLibrary.K2_SetTimerDelegateForLua(oBTimerDelegate1, self,5, false)
    end
end


--[[
function SpawnENdBoss:ReceiveTick(DeltaTime)
    SpawnENdBoss.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SpawnENdBoss:ReceiveEndPlay()
    SpawnENdBoss.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnENdBoss:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnENdBoss:GetAvailableServerRPCs()
    return
end
--]]

return SpawnENdBoss