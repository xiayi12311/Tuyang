---@class SpawnMonster_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local SpawnTesla_2_1 = {
    
}
local EventSystem =  require('Script.common.UGCEventSystem')
SpawnTesla_2_1.MonsterClass = nil
   
function SpawnTesla_2_1:ReceiveBeginPlay()
    ugcprint("SpawnTesla_2_1 begin！")
    SpawnTesla_2_1.SuperClass.ReceiveBeginPlay(self)
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
function SpawnTesla_2_1:ReceiveTick(DeltaTime)
    SpawnTesla_2_1.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SpawnTesla_2_1:ReceiveEndPlay()
    SpawnTesla_2_1.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnTesla_2_1:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnTesla_2_1:GetAvailableServerRPCs()
    return
end
--]]
function SpawnTesla_2_1:GetMonsterClass()
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_2/Tesla_2_1.Tesla_2_1_C')
    self.MonsterClass = UE.LoadClass(path)
    --return nil
end

function SpawnTesla_2_1:TrySpawnMonster()
    ugcprint("spawn SpawnTesla_2_1 !")
    if self:HasAuthority() then
		local Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    self:K2_DestroyActor()
end



return SpawnTesla_2_1