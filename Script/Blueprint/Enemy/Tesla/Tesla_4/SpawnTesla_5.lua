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
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_4/Tesla_5.Tesla_5_C')--UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_4/Tesla_5.Tesla_5_C')
    self.MonsterClass = UE.LoadClass(path)
    --return nil
end

function SpawnTesla_1:TrySpawnMonster()
    ugcprint("spawn !")
    if self:HasAuthority() then
		local Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    self:K2_DestroyActor()
end



return SpawnTesla_1