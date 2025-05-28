---@class WeaponShopAoctorJujiqiang2_C:AActor
---@field ActorSequence UActorSequenceComponent
---@field STCustomMesh1 USTCustomMeshComponent
---@field STCustomMesh USTCustomMeshComponent
---@field Scene USceneComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local WeaponShopAoctorQinwuqi = {}
 
--[[
function WeaponShopAoctorQinwuqi:ReceiveBeginPlay()
    WeaponShopAoctorQinwuqi.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function WeaponShopAoctorQinwuqi:ReceiveTick(DeltaTime)
    WeaponShopAoctorQinwuqi.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function WeaponShopAoctorQinwuqi:ReceiveEndPlay()
    WeaponShopAoctorQinwuqi.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function WeaponShopAoctorQinwuqi:GetReplicatedProperties()
    return
end
--]]

--[[
function WeaponShopAoctorQinwuqi:GetAvailableServerRPCs()
    return
end
--]]

return WeaponShopAoctorQinwuqi