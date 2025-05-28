---@class SpawnMonster_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local SpawnTesla_4 = {
    
}
local EventSystem =  require('Script.common.UGCEventSystem')
SpawnTesla_4.MonsterClass = nil

   
function SpawnTesla_4:ReceiveBeginPlay()
    ugcprint("SpawnTesla_4 begin！")
    SpawnTesla_4.SuperClass.ReceiveBeginPlay(self)
    self:GetMonsterClass()
    -- EventSystem:AddListener("Spawn1", function(num) 
    --     self:Spawn(num) 
    -- end)
    local Gamestate = UGCGameSystem.GetGameState()
    local Region =Gamestate:GetRegion()
    local Location = self:K2_GetActorLocation().X
    local RegionCount =Gamestate:GetRegionCount()
    for i =1 , RegionCount do
        
    if  Location<= Region[i] and Location>= Region[i+1] then
        local text = ("Spawn" ..i)
        EventSystem:AddListener(text,self.TrySpawnMonster,self)
    end
end
    --EventSystem:AddListener("BossUI",self.SetPercent,self)
end


--[[
function SpawnTesla_4:ReceiveTick(DeltaTime)
    SpawnTesla_4.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SpawnTesla_4:ReceiveEndPlay()
    SpawnTesla_4.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnTesla_4:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnTesla_4:GetAvailableServerRPCs()
    return
end
--]]
function SpawnTesla_4:GetMonsterClass()
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_1/Tesla_1.Tesla_1_C')
    self.MonsterClass = UE.LoadClass(path)
    --return nil
end

function SpawnTesla_4:TrySpawnMonster()
    ugcprint("spawn !")
    if self:HasAuthority() then
		local Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    self:K2_DestroyActor()
end



return SpawnTesla_4