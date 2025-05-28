---@class BLC_Respawn_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local BLC_Respawn = {}
BLC_Respawn.MonsterClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/BLC/BLC.BLC_C'))
local EventSystem =  require('Script.common.UGCEventSystem')
local IsSpawn = true
function BLC_Respawn:ReceiveBeginPlay()
    BLC_Respawn.SuperClass.ReceiveBeginPlay(self)
    local Gamestate = UGCGameSystem.GetGameState()
    local Region =Gamestate:GetRegion()
    local RegionCount =Gamestate:GetRegionCount()
    local Location = self:K2_GetActorLocation().X
    
    for i =2 ,RegionCount do
        if  Location >= Region[i] and Location <= Region[i-1] then
        local text = ("Spawn" ..i)
        ugcprint(text)
        EventSystem:AddListener(text,self.ReceiveEnd,self)
        end
    end
end
--]]

--[[
function BLC_Respawn:ReceiveTick(DeltaTime)
    BLC_Respawn.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function BLC_Respawn:ReceiveEndPlay()
    BLC_Respawn.SuperClass.ReceiveEndPlay(self) 
    if self:HasAuthority()  and IsSpawn then 
		local BP_Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
	end
end


--[[
function BLC_Respawn:GetReplicatedProperties()
    return
end
--]]

--[[
function BLC_Respawn:GetAvailableServerRPCs()
    return
end
--]]
function BLC_Respawn:ReceiveEnd()
    ugcprint("Received ENd")
    IsSpawn = false
    self:K2_DestroyActor()
end
return BLC_Respawn