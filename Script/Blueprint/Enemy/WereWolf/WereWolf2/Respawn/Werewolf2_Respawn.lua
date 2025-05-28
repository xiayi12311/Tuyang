---@class Werewolf2_Respawn_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local Werewolf2_Respawn = {}
Werewolf2_Respawn.MonsterClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/WereWolf/Werewolf2/WereWolf2.WereWolf2_C'))
local EventSystem =  require('Script.common.UGCEventSystem')
local IsSpawn = true
function Werewolf2_Respawn:ReceiveBeginPlay()
    Werewolf2_Respawn.SuperClass.ReceiveBeginPlay(self)
    -- local RegionCount =self.LoadMonster:GetRegionCount()
    -- local Region =self.LoadMonster:GetRegion()
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


--[[
function Werewolf2_Respawn:ReceiveTick(DeltaTime)
    Werewolf2_Respawn.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function Werewolf2_Respawn:ReceiveEndPlay()
    Werewolf2_Respawn.SuperClass.ReceiveEndPlay(self) 
    if self:HasAuthority() and IsSpawn  then 
		local BP_Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
	end
end


--[[
function Werewolf2_Respawn:GetReplicatedProperties()
    return
end
--]]

--[[
function Werewolf2_Respawn:GetAvailableServerRPCs()
    return
end
--]]
function Werewolf2_Respawn:ReceiveEnd()
    ugcprint("Received ENd")
    IsSpawn = false
    self:K2_DestroyActor()
end
return Werewolf2_Respawn