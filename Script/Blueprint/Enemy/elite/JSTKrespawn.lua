---@class JSTKrespawn_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local KanDao_Respawn = {}
KanDao_Respawn.MonsterClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/elite/Jstk.Jstk_C'))
--[[UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/elite/Jstk.Jstk_C')
function KanDao_Respawn:ReceiveBeginPlay()
    KanDao_Respawn.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function KanDao_Respawn:ReceiveTick(DeltaTime)
    KanDao_Respawn.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function KanDao_Respawn:ReceiveEndPlay()
    KanDao_Respawn.SuperClass.ReceiveEndPlay(self) 
    if self:HasAuthority() then 
		local BP_Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
	end
end


--[[
function KanDao_Respawn:GetReplicatedProperties()
    return
end
--]]

--[[
function KanDao_Respawn:GetAvailableServerRPCs()
    return
end
--]]

return KanDao_Respawn