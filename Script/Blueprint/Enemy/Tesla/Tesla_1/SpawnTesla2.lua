---@class SpawnMonster_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local SpawnMonster = {
    
}
local EventSystem =  require('Script.common.UGCEventSystem')
SpawnMonster.MonsterClass = nil
   
function SpawnMonster:ReceiveBeginPlay()
    ugcprint("SpawnMonster begin！")
    SpawnMonster.SuperClass.ReceiveBeginPlay(self)
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
function SpawnMonster:ReceiveTick(DeltaTime)
    SpawnMonster.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function SpawnMonster:ReceiveEndPlay()
    SpawnMonster.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function SpawnMonster:GetReplicatedProperties()
    return
end
--]]

--[[
function SpawnMonster:GetAvailableServerRPCs()
    return
end
--]]
function SpawnMonster:GetMonsterClass()
    local path = UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Tesla/Tesla_1/Tesla_2.Tesla_2_C')
    self.MonsterClass = UE.LoadClass(path)
    --return nil
end

function SpawnMonster:TrySpawnMonster()
    ugcprint("spawn !")
    if self:HasAuthority() then
		local Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),self:K2_GetActorRotation(),{X = 1, Y = 1, Z = 1},self);
    end
    self:K2_DestroyActor()

end



return SpawnMonster