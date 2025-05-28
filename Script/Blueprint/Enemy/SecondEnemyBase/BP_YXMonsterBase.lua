---@class BP_YXMonsterBase_C:STExtraSimpleCharacter
---@field Capsule UCapsuleComponent
--Edit Below--
local BP_YXMonsterBase = {}
 

function BP_YXMonsterBase:ReceiveBeginPlay()
    BP_YXMonsterBase.SuperClass.ReceiveBeginPlay(self)
end

function BP_YXMonsterBase:ReceiveTick(DeltaTime)
    BP_YXMonsterBase.SuperClass.ReceiveTick(self, DeltaTime)
end

function BP_YXMonsterBase:ReceiveEndPlay()
    BP_YXMonsterBase.SuperClass.ReceiveEndPlay(self) 
end

--动态生成任何Actor
---@param InWorldContext UObject    @世界上下文对象     必须传入
---@param InActorClass  UClass  @需要使用 UE.LoadClass 加载对应 Class 再作为参数传入    必须传入
---@param InLocation    Vector  @默认{X=0,Y=0,Z=0}
---@param InRotation    Rotator @默认{Roll=0,Pitch=0,Yaw=0}
---@param InScale3D     Vector  @默认{X=1,Y=1,Z=1}
---@param InOwner       Actor   @Actor 的拥有者 默认nil
function BP_YXMonsterBase:SpawnAnything(InWorldContext,InActorClass, InLocation, InRotation, InScale3D,InOwner)
    UGCLog.Log("[YX]:BP_YXMonsterBase:SpawnAnything")
    InLocation = InLocation or {X=0,Y=0,Z=0}
    InRotation = InRotation or {Roll=0,Pitch=0,Yaw=0}
    InScale3D = InScale3D or  {X=1,Y=1,Z=1}
    InOwner = InOwner or nil
    UGCGameSystem.SpawnActor(InWorldContext,InActorClass,InLocation,InRotation,InScale3D,InOwner)
end

--[[
function BP_YXMonsterBase:GetReplicatedProperties()
    return
end
--]]

--[[
function BP_YXMonsterBase:GetAvailableServerRPCs()
    return
end
--]]

return BP_YXMonsterBase