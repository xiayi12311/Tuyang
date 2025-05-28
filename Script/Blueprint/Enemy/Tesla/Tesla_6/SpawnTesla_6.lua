---@class SpawnMonster_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local SpawnTesla_6 = {
    
}
local EventSystem =  require('Script.common.UGCEventSystem')
SpawnTesla_6.MonsterClass = nil
   
function SpawnTesla_6:ReceiveBeginPlay()
    ugcprint("SpawnTesla_6 begin！")
    SpawnTesla_6.SuperClass.ReceiveBeginPlay(self)
    self:GetMonsterClass()
    -- EventSystem:AddListener("Spawn1", function(num) 
    --     self:Spawn(num) 
    -- end)
    local Gamestate = UGCGameSystem.GetGameState()
    local Region =Gamestate:GetRegion()
    local RegionCount =Gamestate:GetRegionCount()
    local Location = self:K2_GetActorLocation().X
    for i =1 ,RegionCount do
   
    if  Location<= Region[i] and Location>= Region[i+1] then
        local text = ("Spawn" ..i)
        EventSystem:AddListener(text,self.TrySpawnMonster,self)
    end
end
    --EventSystem:AddListener("BossUI",self.SetPercent,self)
end


--[[
function SpawnTesla_6:ReceiveTick(DeltaTime)
    SpawnTesla_6.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SpawnTesla_6:ReceiveEndPlay()
    SpawnTesla_6.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnTesla_6:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnTesla_6:GetAvailableServerRPCs()
    return
end
--]]
function SpawnTesla_6:GetMonsterClass()
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_6/Tesla_6.Tesla_6_C')--UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_6/Tesla_6.Tesla_6_C')
    self.MonsterClass = UE.LoadClass(path)
    --return nil
end

function SpawnTesla_6:TrySpawnMonster()
    ugcprint("spawn !")
    if self:HasAuthority() then
		local Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    self:K2_DestroyActor()
end



return SpawnTesla_6