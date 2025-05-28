---@class SpawnMonster_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local SpawnTesla_1 = {
    
}
local EventSystem =  require('Script.common.UGCEventSystem')
SpawnTesla_1.MonsterClass = nil

   
function SpawnTesla_1:ReceiveBeginPlay()
    ugcprint("SpawnTesla_1 begin！")
    SpawnTesla_1.SuperClass.ReceiveBeginPlay(self)
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
        EventSystem:AddListener(text,self.TrySpawnMonster,self)
    end
end
    --EventSystem:AddListener("Spawn1",self.TrySpawnMonster,self)
    --EventSystem:AddListener("BossUI",self.SetPercent,self)
end


--[[
function SpawnTesla_1:ReceiveTick(DeltaTime)
    SpawnTesla_1.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SpawnTesla_1:ReceiveEndPlay()
    SpawnTesla_1.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnTesla_1:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnTesla_1:GetAvailableServerRPCs()
    return
end
--]]
function SpawnTesla_1:GetMonsterClass()
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_1/Tesla_1_2.Tesla_1_2_C')
    self.MonsterClass = UE.LoadClass(path)
    --return nil
end

function SpawnTesla_1:TrySpawnMonster()
    ugcprint("spawn !")
    --local Location = self:K2_GetActorLocation().X
    --if  Location<= self.Region[num] and Location>= self.Region[num+1] then
    if self:HasAuthority() then
		local Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    self:K2_DestroyActor()
    --end
end



return SpawnTesla_1