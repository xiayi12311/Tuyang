---@class SpawnMonster_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local SpawnWolf1 = {
    
}
local EventSystem =  require('Script.common.UGCEventSystem')
SpawnWolf1.MonsterClass = nil
   
function SpawnWolf1:ReceiveBeginPlay()
    ugcprint("SpawnWolf1 begin！")
    SpawnWolf1.SuperClass.ReceiveBeginPlay(self)
    self:GetMonsterClass()
    -- EventSystem:AddListener("Spawn1", function(num) 
    --     self:Spawn(num) 
    -- end)
    local Gamestate = UGCGameSystem.GetGameState()
    local Region =Gamestate:GetRegion()
    local Location = self:K2_GetActorLocation().X
    local RegionCount =Gamestate:GetRegionCount()
    for i =1 ,RegionCount do
   
    if  Location<= Region[i] and Location>= Region[i+1] then
        local text = ("Spawn" ..i)
        ugcprint(text)
        EventSystem:AddListener(text,self.TrySpawnMonster,self)
    end
end
    --EventSystem:AddListener("BossUI",self.SetPercent,self)
end


--[[
function SpawnWolf1:ReceiveTick(DeltaTime)
    SpawnWolf1.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SpawnWolf1:ReceiveEndPlay()
    SpawnWolf1.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnWolf1:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnWolf1:GetAvailableServerRPCs()
    return
end
--]]
function SpawnWolf1:GetMonsterClass()
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/WereWolf/Werewolf1/WereWolf1.WereWolf1_C')
    self.MonsterClass = UE.LoadClass(path)
    --return nil
end

function SpawnWolf1:TrySpawnMonster()
    ugcprint("spawn !")

    if self:HasAuthority() then
		local Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    self:K2_DestroyActor()
end

function SpawnWolf1:ReceiveEnd()
    ugcprint("Received ENd")
    IsSpawn = false
    self:K2_DestroyActor()
end

return SpawnWolf1