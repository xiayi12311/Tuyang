---@class Respawn_C:LevelSequenceActor
--Edit Below--
local Respawn = {}
 
--[[
function Respawn:ReceiveBeginPlay()
    Respawn.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Respawn:ReceiveTick(DeltaTime)
    Respawn.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function Respawn:ReceiveEndPlay()
    ugcprint("Respawn Start")
    if self:HasAuthority() then 
    local RespawnActor = UGCMapInfoLib.GetRootLongPackagePath().."Asset/Blueprint/Enemy/Tank/Tank_2.Tank_2_C"
    local RespawnClass = UE.LoadClass(RespawnActor)
    local BP_Hello = ScriptGameplayStatics.SpawnActor(self, RespawnClass, 
    self:K2_GetActorLocation(),    --坐标
    {Roll = 0, Pitch = 0, Yaw = 0},     --旋转
    {X = 1, Y = 1, Z = 1}) 
    end
    Respawn.SuperClass.ReceiveEndPlay(self)
end


--[[
function Respawn:GetReplicatedProperties()
    return
end
--]]

--[[
function Respawn:GetAvailableServerRPCs()
    return
end
--]]

return Respawn