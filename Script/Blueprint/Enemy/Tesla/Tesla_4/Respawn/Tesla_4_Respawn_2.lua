---@class Tesla_4_Respawn_2_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local Tesla_4_Respawn = {}
Tesla_4_Respawn.MonsterClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_4/Tesla_5.Tesla_5_C'))
local EventSystem =  require('Script.common.UGCEventSystem')
local IsSpawn = true
function Tesla_4_Respawn:ReceiveBeginPlay()
    Tesla_4_Respawn.SuperClass.ReceiveBeginPlay(self)
    local Gamestate = UGCGameSystem.GetGameState()
    local Region =Gamestate:GetRegion()
    local Location = self:K2_GetActorLocation().X
    local RegionCount =Gamestate:GetRegionCount()
    for i =2 ,RegionCount do
        if  Location >= Region[i] and Location <= Region[i-1] then
        local text = ("Spawn" ..i)
        ugcprint(text)
        EventSystem:AddListener(text,self.ReceiveEnd,self)
        end
    end
end



--[[
function Tesla_4_Respawn:ReceiveTick(DeltaTime)
    Tesla_4_Respawn.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function Tesla_4_Respawn:ReceiveEndPlay()
    Tesla_4_Respawn.SuperClass.ReceiveEndPlay(self) 
    if self:HasAuthority() and IsSpawn then 
		local BP_Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
	end
end


--[[
function Tesla_4_Respawn:GetReplicatedProperties()
    return
end
--]]

--[[
function Tesla_4_Respawn:GetAvailableServerRPCs()
    return
end
--]]
function Tesla_4_Respawn:ReceiveEnd()
    ugcprint("Received ENd")
    IsSpawn = false
    self:K2_DestroyActor()
end
return Tesla_4_Respawn