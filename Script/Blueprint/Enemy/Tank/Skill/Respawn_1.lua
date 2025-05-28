---@class Respawn_1_C:AActor
---@field snowboom UParticleSystemComponent
---@field P_Repository_EFX_CastSkill_Section02_Loop_Skill03 UParticleSystemComponent
---@field ParticleSystem UParticleSystemComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local Respawn_1 = {}
 
--[[
function Respawn_1:ReceiveBeginPlay()
    Respawn_1.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Respawn_1:ReceiveTick(DeltaTime)
    Respawn_1.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function Respawn_1:ReceiveEndPlay()
    ugcprint("Respawn Start")
    if self:HasAuthority() then 
        local RespawnActor = UGCMapInfoLib.GetRootLongPackagePath().."Asset/Blueprint/Enemy/Tank/Tank_2.Tank_2_C"
        local RespawnClass = UE.LoadClass(RespawnActor)
        local BP_Hello = ScriptGameplayStatics.SpawnActor(self, RespawnClass, 
            self:K2_GetActorLocation(),    --坐标
            {Roll = 0, Pitch = 0, Yaw = 0},     --旋转
            {X = 1, Y = 1, Z = 1}) 
    end
    Respawn_1.SuperClass.ReceiveEndPlay(self) 

end


--[[
function Respawn_1:GetReplicatedProperties()
    return
end
--]]

--[[
function Respawn_1:GetAvailableServerRPCs()
    return
end
--]]

return Respawn_1